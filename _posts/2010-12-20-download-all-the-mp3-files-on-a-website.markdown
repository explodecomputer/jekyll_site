---
layout: post
title:  "Download all the mp3 files on a website"
date:   2010-12-20 12:43:57
categories: 
- Blog
tags: 
- Programming 
---

I'll be driving home this week. Detours via Newcastle, drop offs along the way, and snowy conditions probably mean that it's going to be a long journey. Radio 4 to the rescue - their series A history of the world in 100 objects has recently been completed, and I missed most of them. A hundred 15 minute episodes - that should probably just about cover the return trip.

<!--more-->

I didn't really fancy clicking 'download' 100 times though, so after watching this tutorial by google, I was inspired to try to write a programme in python that would do it for me. Here's the result (getfiles.py):

{% highlight python %}
#! /usr/bin/env python

import sys
import re
import urllib
import commands

def main():
  if len(sys.argv) == 3:
    print "We're going to download all the %s files at %s" % (sys.argv[2],sys.argv[1])
  else:
    print "Specify a website to violate:\n%s [url] [filetype]" % sys.argv[0]
    return
  
  f = urllib.urlopen(sys.argv[1])
  s = f.read()
  m = re.findall("(http://.+?\.%s)" % sys.argv[2], s)
  print "%d files found..." % len(m)
  i = 1
  for x in m:
    temp = re.search("/([^/]+\.%s)" % sys.argv[2], x)
    print "%d : %s" % (i,temp.group(1))
    urllib.urlretrieve(x,"%d - %s" % (i,temp.group(1)))
    #com = "wget -nc %s" % x
    #commands.getoutput(com)
    i = i + 1
  return

if __name__ == '__main__':
  main()
{% endhighlight %}


Usage:
{% highlight bash %}
chmod 755 getfiles.py
./getfiles.py http://www.bbc.co.uk/podcasts/series/ahow/all mp3
{% endhighlight %}

The commented out bits are an alternative method that uses wget, but this is not cross-platform compatible and it's a bit less elegant than using internal language methods I suppose. I'd be quite interested to see how an advanced python programmer might do this differently.

It took very little time, the structure is no different from an R solution, but it would probably have been quicker to just do the 100 clicks. I have elevated procrastination to an art form.