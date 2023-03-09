---
description: High performance build and compute servers
---

# Triple Crown

These 2U servers are highly capable large memory servers, except that they have limited PCIe4 slots for expansion.

* HPE ProLiant DL385 Gen10 Plus chassis
* 2 AMD EPYC 7742 64-Core Processors
  * configured with two threads per core, so presents as 256 cores
  * this can be altered per request
* 1 TB physical memory
  * 16 DDR4 Synchronous Registered (Buffered) 3200 MHz 64 GiB DIMMS
* 2 HP EG001200JWJNQ 1.2 TB SAS 10500 RPM Disks
  * one is system disk, one available for research use
* 4 MO003200KWZQQ 3.2 TB NVME storage
  * available as needed

#### Usage

These servers are generally used for customized VM environments, which are often scheduled via SLURM, and for networking/DPU research.
