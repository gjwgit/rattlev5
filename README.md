# README #

Rattle - the R Analytical Tool To Learn Easily - is a popular toolkit
for data mining using R, also supporting a GUI. It presents
statistical and visual summaries of data, transforms data that can be
readily modelled, builds both unsupervised and supervised models from
the data, presents the performance of models graphically, and scores
new datasets. One of the most important features (according to its
author) is that all of your interactions through the graphical user
interface are captured as an R script that can be readily executed in
R independently of the Rattle interface.

Rattle is Free (as in Libre) Open Source Software and the source code
is available on Github. We give you the freedom to review the
code, use it for whatever purpose you like, and to extend it however
you like, without restriction, except that if you then distribute your
changes you also need to distribute your source code too.

Rattle V5 is available from [CRAN](https://cran.r-project.org/), but
requires the deprecated RGtk2 pacakge. If you have RGtk2 installed
then you can still use Rattle V5. Otherwise visit
https://rattle.togaware.com for a modern re-implementation of the
rattle UI utilising much of the same underlying R code for the data
analyses. The new UI, otherwise known as Rattle V6, is written using
the modern [Flutter](https://flutter.org) framework while retaining
the flavour of Rattle V5.

Rattle is developed as an open source product by
[Togaware](https://www.togaware.com/) and is freely available to
anyone. Details are available from the
[Rattle](https://rattle.togaware.com/) home page.

RGtk2 Archived on CRAN December 2021
=====================================

The RGtk2 pacakge, required for the GUI tools in this R implementation
of Rattle V5, is archived on CRAN. To use the GUI tools from the now
deprecated Rattle V5 user interface you will need to find a version of
RGtk2 to run on your R instance.

On Linux:

```
> install.packages("https://access.togaware.com/RGtk2_2.20.36.2.tar.gz", repos=NULL)
```

On Windows:

```
> install.packages("https://access.togaware.com/RGtk2_2.20.36.2.zip", repos=NULL)
```

On Mac:

```
> install.packages("https://access.togaware.com/RGtk2_2.20.36.2.tgz", repos=NULL)
```

Even though we make these archived versions of the UI available for
Rattle V5 you are strong encouraged to migrate to [Rattle
V6](https://rattle.togaware.com).

Reporting an Issue
==================

Before reporting an issue be sure to update Rattle, R, and your
operating system to their latest releases.

When reporting an issue please provide a Minimal, Reproducible
Example. This will ensure we can help you more quickly.

We will be better able to resolve the issue if you provide a complete
example that we can easily understand and use to reproduce the
problem. This might need to include data that you are using (if you
are able to share it). If you can reproduce the issue using the
datasets supplied with Rattle that is even better.

Your example should be:

* Minimal - The least number of steps to replicate the issue
* Complete - Include all the steps required to reproduce
* Reproducible - Test the steps yourself to ensure it reproduces the problem

Be sure to include the output of:

```R
> rattleInfo()
```

Issues can be sent to support@togaware.com or else raised as on issue
on github (https://github.com/gjwgit/rattlev5).

References
==========

* [Joseph Rickert on
  fancyRpartPlot](https://blog.revolutionanalytics.com/2013/06/plotting-classification-and-regression-trees-with-plotrpart.html)

* [fancyRpartPlot example](https://discuss.analyticsvidhya.com/t/what-are-the-packages-required-to-plot-a-fancy-rpart-plot-in-r/6776)
