#
# Auto upload to MS/Windows R Check

DEST=win-builder.r-project.org
USER=Graham.Williams@togaware.com
TARGETREL=/R-release
TARGETDEV=/R-devel
TARGETOLD=/R-oldrelease

APP=$(egrep '^APP=' Makefile | cut -d'=' -f 2)
VERSION=$(egrep '^VER=' Makefile | cut -d'=' -f 2)
LATEST=${APP}_${VERSION}.tar.gz

echo "Upload '${LATEST}' to ${DEST}."

ftp -n -i << _EOF_
open ${DEST}
user anonymous ${USER}
bin
cd ${TARGETREL}
put ${LATEST}
cd ../${TARGETDEV}
put ${LATEST}
cd ../${TARGETOLD}
put ${LATEST}
quit
_EOF_

