---
layout: post
title:  "Walker's alias method in C"
date:   2010-08-06 00:18:35
categories: 
- Blog
tags: 
- Statistics
- Programming
---

Uniform discrete random samples with equal weights are easy:
<!--more-->

{% highlight c %}
int n = 5; // number of discrete classes
int val = rand();
int class = (int) (val / (float) (RAND_MAX / n));
{% endhighlight %}

Essentially the number line from 0 to RAND_MAX is split into n equal size chunks, each chunk representing a class. A uniform random value is sampled, which chunk that random value lands corresponds to the class that has been sampled.

This idea can be extended to sampling discrete classes with unequal weights. Instead of each chunk being uniform in length, its length is proportional to the relative probability of its class. The problem then becomes cumbersome, because for each random sample made its flanking boundaries must be identified. 

Walker's alias method overcomes this by creating n equal sized bins, where each bin can hold at most two classes. Across all bins the total area covered by each class remains proportional to its relative weight. Initially, tables are made designating which classes reside in which bins, and what relative proportions of each bin they constitute. A random sample is made, the bin in which it lands can be solved simply using the example above, and the remainder from the division decrees which of the (at most) two variables within this bin has been selected. This is a really elegant algorithm. It's used by the R function sample(), and this adaptation is for use in C:

{% highlight c %}
void walkersalias(
int n,   // number of classes
double *p, // relative weights of each class
int nans,  // sample size to return
int *ans  // sample as an array of class indices
){
    int *a = malloc(n,sizeof(int)),
    double *q, rU;
    int i,j,k;
    int *HL,*H,*L;
    HL = calloc(n,sizeof(int));
    q = calloc(n,sizeof(double));
    H = HL - 1; L = HL + n;
    double sum = 0;
    for(i = 0; i < n; i++)
    {
        sum += p[i];
    }
    for(i = 0; i < n; i++)
    {
        p[i] /= sum;
    }
    for(i = 0; i < n; i++)
    {
        q[i] = p[i] * n;
        if(q[i] < 1.) *++H = i; else *--L = i;
    }
    if(H >= HL && L < HL +n)
    {
        for(k = 0; k < n-1; k++)
        {
            i = HL[k];
            j = *L;
            a[i] = j;
            q[j] += q[i] - 1;
            if(q[j] < 1.) L++;
            if(L >= HL + n) break;
        }
    }
    for(i = 0; i < n; i++) q[i] += i;
    for(i = 0; i < nans; i++)
    {
        rU = (double) rand() / RAND_MAX * n;
        k = (int) rU;
        ans[i] = (rU < q[k]) ? k : a[k];
    }
    free(HL);
    free(q);
        free(a);
}
{% endhighlight %}
Usage: *e.g.* 100 classes, 2000 samples required

{% highlight c %}
int n = 100;
float *weights = malloc(n*sizeof(float));
int samplesize = 2000;
int *sample = malloc(samplesize*sizeof(int));
walkersalias(n,weights,samplesize,sample);
{% endhighlight %}


{{ site.url'/assets/Vi.jpg' | asset_url | img_tag }}

![hello]({{ site.url }}/assets/Vi.jpg)