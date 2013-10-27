---
layout: post
title: "Writing C extensions for R"
date: 2009-07-09 17:44:42
categories: blog
tags: [Programming, C, R]
---

A very simple example of how R objects can be passed to C subroutines from within the R console.

<!--more-->

With [Rcpp](http://adv-r.had.co.nz/Rcpp.html) being so ridiculously good, it is not recommended that anyone use these methods anymore. But here they are anyway.

First, the C subroutine (`adding.c`) that takes an array, `a`, and it's length, `b`, and adds 5 to each element of `a` to return the new array in `ab`.

{% highlight c %}
#include <stdio.h>
#include <stdlib.h>
void adding(double* a, int* b, double* ab)
{
    int i;
    for (i = 0; i < *b; i++)
    {
        ab[i] = a[i] + 5;
    }
}
{% endhighlight %}

This is compiled as a shared object (`.so`) in Mac OS X

    gcc -dynamiclib adding.c -o adding.so

or UNIX-alikes

    gcc -fPIC -c adding.c
    gcc -shared adding.o -o adding.so

or as a dynamic linked library (`.dll`) in Windows

    gcc -BUILD_DLL -c adding.c
    gcc -shared adding.o -o adding.dll

Next, the R code to load the module and pass variables to it:

{% highlight r %}
a <- c(1:9)
dyn.load(paste("adding", .Platform$dynlib.ext, sep = ""))

adding_5 <- function(a)
{
    .C("adding", as.double(a), as.integer(length(a)), ab = double(length(a)))$ab
}
adding_5(a)
{% endhighlight %}

R is ideal for data manipulation and graphical output. Writing bulky kernals in C and calling them from within R makes it extremely efficient also, in terms of both CPU and user time.

