Two Nvidia H100s are now available on hudson.ftpn.ornl.gov. From Nvidia documentation:

> The NVIDIA H100 NVL card is a dual-slot 10.5 inch PCI Express Gen5 card based on the NVIDIA Hopper™ architecture. It uses a passive heat sink for cooling, which requires system airflow to operate the card properly within its thermal limits. The NVIDIA H100 NVL operates unconstrained up to its maximum thermal design power (TDP) level of 400 W to accelerate applications that require the fastest computational speed and highest data throughput. The NVIDIA H100 NVL debuts the world’s highest PCIe card memory bandwidth of nearly 4,000 gigabytes per second (GBps)

Basic validation has been done via running the nvidia samples nbody program on both devices:

```txt
10485760 bodies, total time for 10 iterations: 401572.656 ms
= 2738.014 billion interactions per second
= 54760.284 single-precision GFLOP/s at 20 flops per interaction
```

The GPUs are available to the same UIDs as are using the A100s on milan0. If nvidia-smi does not work for you, you don't have the proper group memberships -- please send email to excl-help@ornl.gov and we will fix it. `nvhpc` is installed as a module as it is on other systems.