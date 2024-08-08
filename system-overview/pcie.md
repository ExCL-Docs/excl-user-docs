# pcie

## Description

This system is intended for pci-based device support.

This system is a generic development server purchased with the intent of housing various development boards as needed.

The system is

* Atipa
* Tyan Motherboard S7119GMR-06
* 192 GB memory
* Intel(R) Xeon(R) Gold 6130 CPU @ 2.10GHzIntel(R) Xeon(R) Gold 6130 CPU @ 2.10GHz 2x16 cores no hyperthreading
* Centos

# Use

This system is used for heterogeneous accelerator exploration and FPGA Alveo/Vitis-based development.

## Current VMs

| Name     | Purpose                                                                                                                                                                                                                                                                                                                                                                                                                              |
| -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Spike    | Main VM with GPUs and FPGAs passed to it. This VM uses Ubuntu 22.04 and software is deployed via modules.                                                                                                                                                                                                                                                                                                                            |
| Intrepid | Legacy Vitis development system. Also has docker deployed for Vitis AI work.                                                                                                                                                                                                                                                                                                                                                         |
| Aries    | Has specialized Vivado install for Ettus RFSoC development. See [USRP Hardware Driver and USRP Manual: Generation 3 USRP Build Documentation (ettus.com)](https://files.ettus.com/manual/md_usrp3_build_instructions.html) and [FIR Compiler IP: FIR output is incorrect when using symmetric coefficients and convergent rounding (xilinx.com)](https://support.xilinx.com/s/article/76780?language=en_US) for the applied patches. |

## Access

There is not currently special access permissions. System is available to ExCL users. This may change as needed.

## Images

![system layout](../.gitbook/assets/20190621\_151129.jpg)

![pci detail](../.gitbook/assets/20190621\_151211.jpg)

![device wiring detail](../.gitbook/assets/20190621\_151218.jpg)

![disks/fans/cpu](../.gitbook/assets/20190621\_151227.jpg)

## Contact

Please send assistance requests to excl-help@ornl.gov.
