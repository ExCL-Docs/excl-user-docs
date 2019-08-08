# Qualcomm 855 SoC (SM8510P) - Snapdragon

## Description

The Qualcomm® Snapdragon™ 855 Mobile Hardware Development Kit (HDK) is a highly integrated and optimized Android development platform.

Accessing this system:

*  Qualcomm board is connected to an HPZ820 workstation  through USB 
*  Development Environment: Android SDK/NDK
*  Login to mcmurdo
  *  $ ssh –Y mcmurdo
* Setup Android platform tools and development environment
  *  $ source /home/nqx/setup_android.source
*  Run Hello-world on ARM cores 
  * $ git clone https://code.ornl.gov/nqx/helloworld-android 
  * $ make  compile  push  run
*  Run OpenCL example on GPU
  * $ git clone https://code.ornl.gov/nqx/opencl-img-processing 
  * Run Sobel edge detection
    * 	$ make  compile  push  run  fetch
  *  Login to Qualcomm development board shell
    * $ adb shell 
    * $ cd /data/local/tmp

## Access

Access will be granted per request (as this cannot be used as a shared
resource).  

## Images

![Laboratory Setup](images/snapdragon1.jpg "Laboratory Setup")
![fpga detail](images/20190607_154604.jpg "fpga detail")
*fpga detail*
![left daughterboard detail](images/20190607_154621.jpg "left daughterboard detail")
*left daughterboard detail*
![right daughterboard gpu removed ](images/20190607_155804.jpg "right daughterboard gpu removed")
*right daughterboard detail gpu removed*
![gpu identification detail](images/20190607_155811.jpg "gpu identification detail")
*gpu identification detail*


## Contact
Please send assistance requests to excl-help@ornl.gov.