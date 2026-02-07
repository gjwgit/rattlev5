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
is available here on Bitbucket. We give you the freedom to review the
code, use it for whatever purpose you like, and to extend it however
you like, without restriction, except that if you then distribute your
changes you also need to distribute your source code too.

Whilst Rattle is available from [CRAN](https://cran.r-project.org/)
you can install the latest developments direct from Togaware using:

```R
> install.packages("rattle", repos="https://rattle.togaware.com", type="source")
```

Rattle is developed as an open source product by
[Togaware](https://www.togaware.com/) and is freely available to
anyone. Details are available from the
[Rattle](https://rattle.togaware.com/) home page.

RGtk2 Archived on CRAN December 2021
=====================================

Currently RGtk2, required for the GUI tools, is archived on CRAN. To
use the GUI tools install RGtk2 from the Microsoft CRAN snapshots:

On Linux:

```
> install.packages("https://cran.microsoft.com/snapshot/2021-12-01/src/contrib/RGtk2_2.20.36.2.tar.gz", repos=NULL)
```

On Windows:

```
> install.packages("https://cran.microsoft.com/snapshot/2021-12-01/bin/windows/contrib/4.1/RGtk2_2.20.36.2.zip", repos=NULL)
```

On Mac:

```
> install.packages("https://cran.microsoft.com/snapshot/2021-12-01/bin/macosx/contrib/4.1/RGtk2_2.20.36.2.tgz", repos=NULL)
```

Rattle utilises many other R packages that may become archived on CRAN
over time, even though they likely remain fit for purpose for
rattle. They can be similarly installed, if required, from the
Microsoft CRAN snapshots.

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
on bitbucket (https://bitbucket.org/kayontoga/rattle).

References
==========

* [Joseph Rickert on
  fancyRpartPlot](https://blog.revolutionanalytics.com/2013/06/plotting-classification-and-regression-trees-with-plotrpart.html)

* [fancyRpartPlot example](https://discuss.analyticsvidhya.com/t/what-are-the-packages-required-to-plot-a-fancy-rpart-plot-in-r/6776)
