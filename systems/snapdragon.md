# Snapdragon

## Description

The Qualcomm® Snapdragon™ 855 Mobile Hardware Development Kit \(HDK\) is a highly integrated and optimized Android development platform.

Accessing this system:

* Qualcomm board is connected to an HPZ820 workstation  through USB
* Development Environment: Android SDK/NDK
* Login to mcmurdo
  * $ ssh –Y mcmurdo
* Setup Android platform tools and development environment
  * $ source /home/nqx/setup\_android.source
* Run Hello-world on ARM cores
  * $ git clone [https://code.ornl.gov/nqx/helloworld-android](https://code.ornl.gov/nqx/helloworld-android)
  * $ make  compile  push  run
* Run OpenCL example on GPU
  * $ git clone [https://code.ornl.gov/nqx/opencl-img-processing](https://code.ornl.gov/nqx/opencl-img-processing)
  * Run Sobel edge detection
    * $ make  compile  push  run  fetch
  * Login to Qualcomm development board shell
    * $ adb shell
    * $ cd /data/local/tmp

## Access

Access will be granted per request \(as this cannot be used as a shared resource\).

## Useful Links

1. Android Studio: [https://developer.android.com/studio](https://developer.android.com/studio)
2. Qualcomm HDK: [https://developer.qualcomm.com/hardware/snapdragon-855-hdk](https://developer.qualcomm.com/hardware/snapdragon-855-hdk)
3. Quallcomm Neural Processor SDK: [https://developer.qualcomm.com/software/qualcomm-neural-processing-sdk](https://developer.qualcomm.com/software/qualcomm-neural-processing-sdk)

   [https://developer.qualcomm.com/docs/snpe/overview.htm](https://developer.qualcomm.com/docs/snpe/overview.htm)

## Images

![Laboratory Setup](../.gitbook/assets/snapdragon1.jpg)

