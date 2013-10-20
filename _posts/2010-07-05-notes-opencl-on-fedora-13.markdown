---
layout: post
title:  "Notes: OpenCL on Fedora 13"
date:   2010-07-05 20:57:09
categories: 
- Blog
tags:
- Programming 
---


To setup NVIDIA drivers on Fedora 13, and to install OpenCL libraries.
<!--more-->

## NVIDIA drivers:

Followed this [guide](http://rpmfusion.org/Howto/nVidia).

No need to run in level 3. Open terminal, login as root, append

    rdblacklist=nouveau nomodeset

to the end of the line starting with kernel in the file `/etc/grub.conf`.

Then simply:

    yum install kmod-nvidia

Reboot, and after booting in text mode the driver should kick in and X will work normally. Check 3D acceleration is available by enabling `Desktop Effects in System > Preferences`


## OpenCL libraries

Download the developer drivers for linux [here](https://developer.nvidia.com/cuda-toolkit-31-downloads).

Install linux kernel source rpm:

    yum install kernel-devel

Enter run level 3, and install after `Ctrl+Alt+F2`:

    telinit 3
    chmod 755 devdriver_3.1_linux_64_256.35.run
    ./devdriver_3.1_linux_64_256.35.run

After the reboot there were no problems, and the CL folder now existed in `/usr/include/`. However, it may be that installing the NVIDIA drivers first is not necessary, not sure if doing it this way causes the driver to be installed twice.