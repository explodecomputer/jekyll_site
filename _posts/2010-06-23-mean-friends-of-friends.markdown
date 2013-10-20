---
layout: post
title:  "mean(# friends of friends) > (# friends of individual)"
date:   2010-06-23 01:24:33
categories: 
- Blog
tags: 
- Programming
- Statistics
---

It's just an example of the class size paradox.
<!--more-->

If you ask a random sample how many people were in their class, the mean of the answer will be higher than the true class size mean (as long as there is variance in the population of classes). This is intuitive - the chance that any individual went to a large class is higher than if they went to a small class, and so members of small classes will always be underrepresented if the sampling process is random.

It extends to everything, e.g. social networks - Scott L. Feld (1991) shows that the same principle applies. Only the degree of disparity between the mean number of friends of friends and the mean number of friends of individuals varies when the distribution of connectivity varies, but the qualitative result is consistent (in all cases other than an exhaustive network, where there is no disparity).

This small R script generates an entirely random friendship network:

{% highlight r %}
library(network)
pop <- matrix(0,30,30)
a <- sample(1:30,40,replace=T)
b <- sample(1:30,40,replace=T)
for(i in 1:40)
{
    pop[a[i],b[i]] <- 1
    pop[b[i],a[i]] <- 1
}
plot.network(network(pop))
{% endhighlight %}

Represented here:

![Random friendship network]({{ site.url }}/assets/randomfriends.jpg)

Summarised:

{% highlight r %}
fof <- array(0,30) # friends of friends
foi <- array(0,30) # friends of individuals
for(i in 1:30)
{
    friends <- which(pop[,i] == 1)
    foi[i] <- length(friends)
    temp <- 0
    for(j in 1:foi[i])
    {
        temp <- temp + sum(pop[,friends[j]])
    }
    fof[i] <- round(temp / foi[i],1)
}
cbind(foi,fof)
{% endhighlight %}

          foi fof
     [1,]   1 4.0
     [2,]   4 3.2
     [3,]   3 4.0
     [4,]   2 3.5
     [5,]   3 3.0
     [6,]   4 4.0
     [7,]   3 2.3
     [8,]   2 3.0
     [9,]   4 3.5
    [10,]   2 2.0
    [11,]   3 4.0
    [12,]   3 2.3
    [13,]   1 5.0
    [14,]   5 3.0
    [15,]   3 3.0
    [16,]   2 2.5
    [17,]   2 4.5
    [18,]   3 3.3
    [19,]   1 3.0
    [20,]   1 3.0
    [21,]   5 2.6
    [22,]   3 3.0
    [23,]   0 0.0
    [24,]   4 3.0
    [25,]   4 3.0
    [26,]   0 0.0
    [27,]   2 3.5
    [28,]   2 3.5
    [29,]   2 2.5
    [30,]   3 4.0

So 22 out of 30 individuals in this network have fewer friends than the average number of friends of their friends. The simulation can be made slightly more sophisticated by "growing" a social network, rather than assigning random relationships:


{% highlight r %}
N <- 30
pop <- array(0,c(N,N))
nfriends <- array(0,N)
friends <- list()
for(i in 1:N)
{
    sums <- apply(pop,2,sum)
    nfriends[i] <- sample(1:(N/10),1)
    friends[[i]] <- sample((1:N)[-i],nfriends[i],F,sums[-i]+0.1)
    for(j in 1:nfriends[i])
    {
        pop[i,friends[[i]][j]] <- 1
        pop[friends[[i]][j],i] <- 1
    }
}
plot.network(network(pop))
{% endhighlight %}

Graphed:

![Growing friendship network]({{ site.url }}/assets/growingfriends.jpg)

and summarised:


          foi  fof
     [1,]   3  9.7
     [2,]   3  7.3
     [3,]   9  5.3
     [4,]   7  6.3
     [5,]   6  7.8
     [6,]   7  6.3
     [7,]   3 10.7
     [8,]   2 12.5
     [9,]   3  6.3
    [10,]   8  7.1
    [11,]  16  4.6
    [12,]   5  7.2
    [13,]   1 16.0
    [14,]   6  5.3
    [15,]   1 16.0
    [16,]   3  6.7
    [17,]   7  3.9
    [18,]   1  7.0
    [19,]   1  6.0
    [20,]   2 13.0
    [21,]   1  8.0
    [22,]   2 11.0
    [23,]   3 10.3
    [24,]  10  5.2
    [25,]   1  9.0
    [26,]   2  9.5
    [27,]   4 10.0
    [28,]   2  6.0
    [29,]   2  6.5
    [30,]   3  7.3

where 22 out of 30 have fewer friends than their friends have.

Here, the whole population is represented, it's not a sampling issue. What is the consequence for genetic systems? Most gene effects will be larger than the average size, can a distribution be inferred? Most networks studied will be larger than the majority that exist, and will be over-represented by genes that have more interactions than average.

It's 2.30am and I can't think properly anymore.
