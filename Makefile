########################################################################
#
# Generic Makefile
#
# Copyright (c) Graham.Williams@togaware.com
#
# License: Creative Commons Attribution-ShareAlike 4.0 International.
#
########################################################################

APP=rattle
VER=5.5.2

INC_BASE    = $(HOME)/.local/share/make
INC_CLEAN   = $(INC_BASE)/clean.mk
INC_R       = $(INC_BASE)/r.mk
INC_KNITR   = $(INC_BASE)/knitr.mk
INC_PANDOC  = $(INC_BASE)/pandoc.mk
INC_GIT     = $(INC_BASE)/git.mk
INC_AZURE   = $(INC_BASE)/azure.mk
INC_LATEX   = $(INC_BASE)/latex.mk
INC_MLHUB   = $(INC_BASE)/mlhub.mk

ifneq ("$(wildcard $(INC_CLEAN))","")
  include $(INC_CLEAN)
endif
ifneq ("$(wildcard $(INC_GIT))","")
  include $(INC_GIT)
endif

define HELP
rattle:

  dist		Do everything and upload to repo on togaware.

  install	Build and install for local testing.
  version	Update the version in various files.

  check         Run a local check.
  ucheck        Submit to the R check before submitting to CRAN.

  www		Update the rattle website on togware with version.
  weather       Update weather datasets for the package.

  logs          Update the CRAN download log plot.
endef
export HELP

help::
	@echo "$$HELP"

######################################################################
# Configuration

DATE=$(shell date +%Y-%m-%d)
REPOSITORY=repository
RSITELIB=$(shell Rscript -e "cat(installed.packages()['$(APP)','LibPath'])")
FILES=Makefile DESCRIPTION inst man R

WEATHER=$(HOME)/git/github/gjwgit/weather
WWW=$(HOME)/projects/togaware/www

######################################################################
# R Package Management

.PHONY: version
version:
	perl -pi -e 's|^Version: .*|Version: $(VER)|' DESCRIPTION
	perl -pi -e 's|^Date: .*|Date: $(DATE)|' DESCRIPTION
	perl -pi -e 's|^VERSION <- .*|VERSION <- "$(VER)"|' R/$(APP).R
	perl -pi -e 's|^DATE <- .*|DATE <- "$(DATE)"|' R/$(APP).R

.PHONY: check
check: clean version build
	/usr/lib/R/bin/R CMD check --as-cran --check-subdirs=yes $(APP)_$(VER).tar.gz

.PHONY: build
build: version $(APP)_$(VER).tar.gz

.PHONY: rebuild
rebuild: build install

.PHONY: install
install: build
	/usr/lib/R/bin/R CMD INSTALL $(APP)_$(VER).tar.gz

.PHONY: test
test: install
	Rscript -e 'library($(APP));$(APP)();Sys.sleep(120)'

# 20210820 gjw Add --no-build-vignette due to getting the LaTeX error:
# ! LaTeX Error: File `l3backend-pdfmode.def' not found. Need to debug
# this.

$(APP)_$(VER).tar.gz: $(FILES) .Rbuildignore
	/usr/lib/R/bin/R CMD build .
#	/usr/lib/R/bin/R CMD build --no-build-vignettes .

$(APP)_$(VER).check: $(APP)_$(VER).tar.gz
	/usr/lib/R/bin/R CMD check --as-cran --check-subdirs=yes $^

.PHONY: ucheck
ucheck: $(APP)_$(VER).tar.gz
	sh ./upload_uwe.sh
	@echo Wait for email from Uwe Legge.

.PHONY: cran
cran: $(APP)_$(VER).tar.gz
	sh ./upload_cran.sh
	@echo Be sure to email cran@r-project.org.

.PHONY: src
src: $(APP)_$(VER)_src.zip  $(APP)_$(VER)_src.tar.gz

.PHONY: zip
zip: $(APP)_$(VER).zip

$(APP)_$(VER)_src.zip: Makefile $(FILES)
	zip -r $@ $^
		-x *~		 \
		-x */*~          \
		-x .Rbuildignore \
		-x .git/**\* 	 \
		-x .git/      	 \
		-x .gitignore 	 \
		-x .Rhistory

$(APP)_$(VER)_src.tar.gz: Makefile $(FILES)
	tar zcvf $@ $^ \
		--exclude="*~" 		\
		--exclude=".git*" 	\
		--exclude=".R*"

$(APP)_$(VER).zip: install
	(cd $(RSITELIB); zip -r9 - $(APP)) >| $(APP)_$(VER).zip

########################################################################
# Source code management and distribution.

.PHONY: dist
dist: www repo version access

.PHONY: www
www:
	(cd /home/gjw/projects/togaware/www/;\
	 perl -pi -e "s|Version [0-9\.]* |Version $(VER) |" \
			rattle.html.in;\
	 perl -pi -e "s|rattle_[0-9\.]*.tar.gz|rattle_$(VER).tar.gz|" \
			rattle.html.in;\
	 perl -pi -e "s|access/rattle_[0-9\.]*_src.tar.gz|access/rattle_$(VER)_src.tar.gz|" \
			rattle.html.in;\
	 perl -pi -e "s| dated [^\.]*:| dated $(DATE):|" \
			rattle.html.in;\
	 perl -pi -e "s|rattle_[0-9\.]*.zip|rattle_$(VER).zip|" \
			rattle-install-mswindows.html.in;\
	 make rattle)

.PHONY: access
access: zip
	chmod 0644 $(APP)_$(VER).tar.gz $(APP)_$(VER).zip
	rsync -ahv $(APP)_$(VER).tar.gz $(APP)_$(VER).zip \
		   togaware.com:apps/access/

#	chmod 0644 $(APP)_$(VER)_src.zip $(APP)_$(VER)_src.tar.gz \
#		   $(APP)_$(VER).tar.gz $(APP)_$(VER).zip
#	rsync -ahv $(APP)_$(VER)_src.zip $(APP)_$(VER)_src.tar.gz \
#		   $(APP)_$(VER).tar.gz $(APP)_$(VER).zip \
#		   togaware.com:apps/access/

.PHONY: repo
repo: build zip
	cp $(APP)_$(VER).tar.gz $(APP)_$(VER).zip $(REPOSITORY)
	-R --no-save < repository/repository.R
	chmod go+rx $(REPOSITORY)
	chmod go+r $(REPOSITORY)/* inst/NEWS
	rsync -ahv repository/ togaware.com:apps/rattle/src/contrib
	rsync -ahv repository/*.zip togaware.com:apps/rattle/bin/windows/contrib/all/
	rsync -ahv repository/PACKAGE* togaware.com:apps/rattle/bin/windows/contrib/all/
	rsync -ahv inst/NEWS togaware.com:apps/rattle/NEWS

.PHONY: weather
weather: 
	(cd $(WEATHER); make update)
	rsync $(WEATHER)/weather.RData data/
	rsync $(WEATHER)/weatherAUS.RData data/
	rsync $(WEATHER)/locationsAUS.RData data/
	rsync $(WEATHER)/weather.csv inst/csv/
	rsync $(WEATHER)/weather.arff inst/arff/

########################################################################
# Administration

.PHONY: logs
logs:
	(cd $(HOME)/cloud/togaware.net/gjw/projects/cran_download_logs; make update)

.PHONY: clean
clean::
	rm -vf *~ .*~ */*~
	rm -rf $(APP).Rcheck
	rm -vf file*.xdf
	rm -vf weather_rattle.xdf xgboost.model

.PHONY: realclean
realclean:: clean
	mkdir -p BACKUP
	-@mv -vf $(APP)_* BACKUP/
