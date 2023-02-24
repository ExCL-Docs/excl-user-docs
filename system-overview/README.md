---
description: Overview of ExCL Systems
---

# System Overview

## ExCL Server List with Accelerators

| Host Name                            | Description                              | OS                    | Accelerators or other special hardware                                 |
| ------------------------------------ | ---------------------------------------- | --------------------- | ---------------------------------------------------------------------- |
| [affirmed](affirmed.md)              | Triple Crown AMD (128 cores/1 TB)        | Ubuntu 20.04          | Bluefield 2                                                            |
| [amundsen](amundsen.md)              | Desktop embedded system development      | Ubuntu 20.04          | Snapdragon 855 (retiring)                                              |
| [apachepass](apachepass.md)          | ApachePass memory system                 | Centos 7.9            | 375 GB Apachepass memory                                               |
| [clark](clark.md)                    | Desktop embedded system development      | Ubuntu 22.04          |                                                                        |
| [cousteau](cousteau.md)              | HP AMD 24 Core Server 256 GB             | Ubuntu 22.04          | 2 AMD MI100 GPUs                                                       |
| [docker](docker.md) (quad03)         | Intel 20 Core Server 96 GB               | Ubuntu 20.04          | Docker development environment                                         |
| [equinox](equinox.md)                | DGX Workstation                          | Ubuntu 20.04          | 4 Tesla V100 32 GB GPUs                                                |
| [excl-us00](excl-us.md)              | Intel 16 Core Utility Server 196 GB      |                       |                                                                        |
| [excl-us01](excl-us.md) (hypervisor) | Intel 16 Core Utility Server 196 GB      |                       |                                                                        |
| [excl-us03](excl-us.md)              | Intel 16 Core Utility Server 196 GB      |                       |                                                                        |
| [explorer](explorer.md)              | AMD 128 Core 512 Gb                      |                       | 2 AMD MI50 GPUs                                                        |
| [justify](justify.md)                | Triple Crown AMD (128 cores/1 TB)        | Centos 7.9            |                                                                        |
| [leconte](leconte.md)                | Summit server Power9 42 Cores            | Centos 8.4            | 6 Tesla V100 16 Gb                                                     |
| [lewis](lewis.md)                    | Desktop embedded system development      | Ubuntu 22.04          |                                                                        |
| [mcmurdo](mcmurdo.md)                | Desktop embedded system development      | Ubuntu 20.04          | Snapdragon 855 & PolarFire SoC (retiring)                              |
| [milan0](milan.md)                   | AMD Milan server                         | Ubuntu 22.04          | 2 \* Nvidia A100 (not deployed)                                        |
| [milan\[1-3\]](milan.md)             | AMD Milan server                         | Ubuntu 22.04 or other | <p>heterogeneous research<br>not deployed</p>                          |
| [minim1](minim1.md)                  | Apple M1 Desktop                         | OSX                   |                                                                        |
| [oswald00](oswald.md)                | Intel 32 Core 256 GB                     | Centos 7.9            | Tesla P100 & Nallatech FPGA                                            |
| [oswald01](oswald.md)                | failed, all usable accelerators salvaged |                       |                                                                        |
| [oswald02](oswald.md)                | Intel 32 Core 256 GB                     | Centos 7.9            | Tesla P100 & Nallatech FPGA                                            |
| [oswald03](oswald.md)                | Intel 32 Core 256 GB                     | Centos 7.9            | Tesla P100 & Nallatech FPGA                                            |
| [oswald](oswald.md)                  | Intel 16 Core 128 GB utility server      | Centos 7.9            |                                                                        |
| [pcie](pcie.md)                      | Intel 32 Core 196 GB                     | Ubuntu 22.04          | <p>Xylinx U250<br>Nalllatech Stratix 10<br>Tesla P100<br>Groq Card</p> |
| [pharoah](pharoah.md)                | Triple Crown AMD (128 cores/1 TB)        | Centos 7.9            |                                                                        |
| [quad00](quad.md) (graylog)          | Intel 20 Core 96 GB utility server       | Centos 7.9            |                                                                        |
| [quad01](quad.md)                    | Intel 20 Core 96 GB utility server       | Centos 7.9            |                                                                        |
| [quad02](quad.md)                    | Intel 20 Core 96 GB utility server       | Centos 7.9            |                                                                        |
| [radeon](radeon.md)                  | Intel 4 Core 64 GB                       | Ubuntu 22.04          | AMD Vega20 Radeon VII GPU                                              |
| [secretariat](secretariat.md)        | Triple Crown AMD (128 cores/1 TB)        | Ubuntu 20.04          | Bluefield 2                                                            |
| [thunderx](thunderx.md)              | ARM Cavium ThunderX2 Server 128 GB       | Centos Stream 8       |                                                                        |
| [xavier\[1-3\]](xavier.md)           | Nvidia Jetson AGX                        | Ubuntu                | Volta GPU                                                              |
| [xavier\[4-5\]](xavier.md)           | Nvidia Jetsion AGX Orin                  | Ubuntu                | Ampere GPU (not deployed)                                              |
| [zenith](zenith.md)                  | AMD Ryzen 32 Core 132 Gb                 | Ubuntu 22.04          | <p>Nvidia GTX 3090<br>AMD Radeon RX 6800</p>                           |

## New Systems and Devices to be Deployed

* Intel ARC GPU
* Achronix FPGA
* Xilinx U280

See [https://excl.ornl.gov/excl-systems/](https://excl.ornl.gov/excl-systems/) for additional information (outdated).

## Accelerator Highlights

| Accelerator Name                         | Host(s)           |
| ---------------------------------------- | ----------------- |
| AMD Radeon VII GPU                       | radeon            |
| AMD MI50 GPU                             | explorer          |
| AMD MI100 GPU                            | cousteau          |
| Nvidia P100 GPU                          | pcie              |
| Nvidia V100 GPU                          | equinox, leconte  |
| Nvidia Jetson                            | xavier            |
| [Qualcomm Snapdragon 855](snapdragon.md) | amundsen, mcmurdo |
| Intel Stratix 10 FPGA                    | pcie              |
| Xilinx Zynq ZCU 102                      | n/a               |
| Xilinx Zynq ZCU 106                      | n/a               |
| Xilinx Alveo U250                        | pcie              |
| Intel Optane DC Persistent Memory        | apachepass        |
| Emu Technology CPU                       | emu               |
| Cavium CPU                               | thunderx          |
