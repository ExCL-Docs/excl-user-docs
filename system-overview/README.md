---
description: Overview of ExCL Systems
cover: ../.gitbook/assets/systems-image.jpg
coverY: 0
---
# System Overview

## ExCL Server List with Accelerators

| Host Name                                  | Description                                                       | OS                    | Accelerators or other special hardware                                 |
| ------------------------------------------ | ----------------------------------------------------------------- | --------------------- | ---------------------------------------------------------------------- |
| [affirmed](triple-crown.md#affirmed)       | Triple Crown AMD EPYC 7742 (Rome) 2x64-core 1 TB                  | Ubuntu 24.04          | <p>Bluefield 2 </p><p>NIC/DPUs</p>                                     |
| [amundsen](amundsen.md)                    | Desktop embedded system development                               | Ubuntu 20.04          | Snapdragon 855 (desktop retiring)                                      |
| [clark](clark.md)                          | Desktop embedded system development                               | Ubuntu 24.04          | Intel A770 Accelerator                                                 |
| [cousteau](cousteau.md)                    | AMD EPYC 7272 (Rome) 2x12-core 256 GB                             | Ubuntu 24.04          | 2 AMD MI100 32 GB GPUs                                                 |
| [docker](docker.md) (quad03)               | Intel 20 Core Server 96 GB                                        | Ubuntu 24.04          | Docker development environment                                         |
| [explorer](explorer.md)                    | AMD EPYC 7702 (Rome) 2x64-core 512 GB                             | Ubuntu 24.04          | 2 AMD MI60 32 GB GPUs                                                  |
| [faraday](faraday.md)                      | AMP APU 4x24 Zen 4 cores 512 GB unified HBM3 912 CDNA 3 GPU units | Ubuntu 24.04          | 4 Mi300a APUs                                                          |
| [hudson](hudson.md)                        | AMD EPYC 9454 (Genoa) 2x48-core 1.5 TB                            | Ubuntu 24.04          | 2 Nvidia H100s                                                         |
| [justify](triple-crown.md#justify)         | Triple Crown AMD EPYC 7742 (Rome) 2x64-core 1 TB                  | Ubuntu 24.04          |                                                                        |
| [leconte](leconte.md)                      | Summit server POWER9 42 Cores (soon to retire)                    | Centos 8.4            | 6 Tesla V100 16 GB GPUs                                                |
| [lewis](lewis.md)                          | Desktop embedded system development                               | Ubuntu 24.04          |                                                                        |
| [maxwell](maxwell.md)                      | AMD EPYC 7763 2\*64\*2-core 1 TB                                  | Ubuntu 24.04          | 4 \* Nvidia A100, 4 \* AMD MI100                                       |
| [mcmurdo](mcmurdo.md)                      | Desktop embedded system development                               | Ubuntu 22.04          | Snapdragon 855 & PolarFire SoC (retiring)                              |
| [milan0](milan.md)                         | AMD EPYC 7513 (Milan) 2x32-core 1 TB                              | Ubuntu 24.04          | 2 \* Nvidia A100                                                       |
| [milan1](milan.md)                         | AMD EPYC 7513 (Milan) 2x32-core 1 TB                              | Ubuntu 24.04 or other | 2 Groq AI accelerators                                                 |
| [milan2](milan.md)                         | AMD EPYC 7513 (Milan) 2x32-core 1 TB                              | Ubuntu 24.04 or other | 8 (7 working) Nvidia Tesla V100-PCIE-32GB GPUs                         |
| [milan3](milan.md)                         | AMD EPYC 7513 (Milan) 2x32-core 1 TB                              | Ubuntu 22.04 or other | General Use                                                            |
| [minim1](minim1.md)                        | Apple M1 Desktop                                                  | OSX (current)         | Cross Compile and CI/CD                                                |
| [minim3](minim3.md)                        | Apple M3 Desktop                                                  | OSX (current)         | Cross Compile and CI/CD                                                |
| [oswald](oswald.md)                        | Oswald head node                                                  | Ubuntu 24.04          | General Use                                                            |
| [oswald00](oswald.md)                      | Intel Xeon E5-2683 v4 (Haswell) 2x16-core 256 GB                  | Ubuntu 24.04          | Tesla P100 & Nallatech FPGA                                            |
| [oswald02](oswald.md)                      | Intel Xeon E5-2683 v4 (Haswell) 2x16-core 256 GB                  | Ubuntu 24.04          | Tesla P100 & Nallatech FPGA                                            |
| [oswald03](oswald.md)                      | Intel Xeon E5-2683 v4 (Haswell) 2x16-core 256 GB                  | Ubuntu 24.04          | Tesla P100 & Nallatech FPGA                                            |
| [pcie](pcie.md)                            | Intel Xeon Gold 6130 CPU (Skylake) 32-core 192 GB                 | Ubuntu 24.04          | <p>Xylinx U250<br>Nalllatech Stratix 10<br>Tesla P100<br>Groq Card</p> |
| [pharaoh](triple-crown.md#pharaoh)         | Triple Crown AMD EPYC 7742 (Rome) 2x64-core 1 TB                  | Ubuntu 24.04          |                                                                        |
| [radeon](radeon.md)                        | Intel 4 Core 64 GB                                                | Ubuntu 24.04          | AMD Vega20 Radeon VII GPU                                              |
| [secretariat](triple-crown.md#secretariat) | Triple Crown AMD EPYC 7742 (Rome) 2x64-core 1 TB                  | Ubuntu 24.04          | Bluefield 2 NIC/DPU                                                    |
| [thunderx](thunderx.md)                    | ARM Cavium ThunderX2 Server 128 GB                                | Ubuntu 24.04          | ARM development/cross compilation                                      |
| [xavier\[1-3\]](xavier.md)                 | Nvidia Jetson AGX                                                 | Ubuntu                | Volta GPU                                                              |
| [xavier\[4-5\]](xavier.md)                 | Nvidia Jetson AGX Orin                                            | Ubuntu                | Ampere GPU (not deployed)                                              |
| [zenith](zenith.md)                        | AMD Ryzen Threadripper 3970X (Castle Peak) 32-core 132 GB         | Ubuntu 24.04          | <p>Nvidia GTX 3090<br>AMD Radeon RX 6800</p>                           |
| [zenith2](zenith.md)                       | AMD Ryzen Threadripper 3970X (Castle Peak) 32-core 132 GB         | Ubuntu 24.04          | <p>Nvidia GTX 5090<br>Various Embedded FPGA devboards</p>              |

## New Systems and Devices to be Deployed

- 2 Snapdragon HDK & Display
- Intel ARC GPU
- Achronix FPGA
- AGX Orin Developer Kits

## Accelerator Highlights

| Accelerator Name                         | Host(s)                  |
| ---------------------------------------- | ------------------------ |
| AMD Radeon VII GPU                       | radeon                   |
| AMD MI60 GPU                             | explorer                 |
| AMD MI100 GPU                            | cousteau, maxwell        |
| AMD Mi300a GPU                           | faraday                  |
| [Groq](../quick-start-guides/groq.md)    | milan1                   |
| Nvidia A100 GPU                          | milan0, maxwell          |
| Nvidia P100 GPU                          | pcie                     |
| Nvidia V100 GPU                          | equinox, leconte, milan2 |
| Nvidia H100 GPU                          | hudson                   |
| Nvidia Jetson                            | xavier                   |
| [Qualcomm Snapdragon 855](snapdragon.md) | amundsen, mcmurdo        |
| Intel Stratix 10 FPGA                    | pcie                     |
| Xilinx Zynq ZCU 102                      | n/a                      |
| Xilinx Zynq ZCU 106                      | n/a                      |
| Xilinx Alveo U250                        | pcie                     |
| Xilinx Alveo U280                        | milan3                   |
| 2 Ettus x410 SDRs                        | marconi                  |
| Nvidia Geforce RTX 5090 GPU              | zenith2                  |

## Unique Architecture Highlights

| Accelerator Name                  | Host(s)       |
| --------------------------------- | ------------- |
| Intel Optane DC Persistent Memory | apachepass    |
| Emu Technology CPU                | [emu](emu.md) |
| Cavium CPU                        | thunderx      |

## Other Equipment

- RTP164 High Performance Oscilloscope

## Primary Usage Notes

### Access Host (Login)

Login is the node use to access ExCL and to proxy into and out of the worker nodes. It is not to be used for computation but for accessing the compute notes. The login node does have ThinLinc installed and can also be used for graphical access and more performance x11 forwarding from an internal node. See [ThinLinc Quickstart](../quick-start-guides/thinlinc.md).

| Host  | Base Resources  | Specialized Resources | Notes                                |
| ----- | --------------- | --------------------- | ------------------------------------ |
| login | 4 core 16 Gi vm | -                     | login node - not for computation, TL |

### General Interactive Login Use

These nodes can be access with ssh, and are available for general interactive use.

| Host        | Base Resources  | Specialized Resources                        | Notes                                                          |
| ----------- | --------------- | -------------------------------------------- | -------------------------------------------------------------- |
| oswald      | 16 Core 64 Gb   | -                                            |                                                                |
| oswald00    | 32 core 256 Gi  | NVIDIA P100, FPGA @                          |                                                                |
| oswald02    | 32 core 256 Gi  | NVIDIA P100, FPGA @                          |                                                                |
| oswald03    | 32 core 256 Gi  | NVIDIA P100, FPGA @                          |                                                                |
| maxwell     | 256 Core 1 Ti   | NVIDIA A100 (4), AMD MI100 (4)               | Will occasionally be single user for performance analysis      |
| milan0      | 128 Core 1 Ti   | NVIDIA A100 (2)                              | Slurm                                                          |
| milan1      | 128 Core 1 Ti   | Groq AI Accelerator (2)                      | Slurm                                                          |
| milan2      | 128 Core 1 Ti   | NVIDIA V100 (8-1)                            | Only 7 of the GPUs are working.                                |
| milan3      | 128 Core 1 Ti   | Xlinx U280                                   | Slurm                                                          |
| excl-us00   | 32 Core 192 Gi  | -                                            | Not available pending disposition                              |
| excl-us01   | 32 Core 192 Gi  | -                                            | Not available pending disposition                              |
| excl-us03   | 32 Core 192 Gi  | -                                            | Not available pending disposition                              |
| secretariat | 256 Core 1 Ti   | -                                            | Slurm                                                          |
| affirmed    | 256 Core 1 Ti   | -                                            | Slurm                                                          |
| pharaoh     | 256 Core 1 Ti   | -                                            | Slurm                                                          |
| justify     | 256 Core 1 Ti   | -                                            | Slurm                                                          |
| hudson      | 192 Core 1.5 Ti | NVIDIA H100 (2)                              | Will occasionally be single user for performance analysis      |
| faraday     |                 | AMD Mi300a (4)                               | Will occasionally be single user for performance analysis      |
| docker      | 20 Core 96 Gi   | -                                            | Configured for Docker general use with enhanced image storage  |
| pcie        | 32 Core 196 Gi  | NVIDIA P100, FPGA @                          | TL, No hyperthreading, passthrough hypervisor for accelerators |
| lewis       | 20 Core 48 Gi   | NVIDIA T1000, U250                           | TL                                                             |
| clark       | 20 Core 48 Gi   | NVIDIA T1000                                 | TL                                                             |
| zenith      | 64 core 128 Gi  | NVIDIA GeForce RTX 3090 @                    | TL                                                             |
| radeon      | 8 Core 64 Gi    | AMD Radeon VII                               |                                                                |
| explorer    | 256 Core 512 Gi | AMD M60 (2)                                  |                                                                |
| cousteau    | 48 Core 256 Gi  | AMD M100 (2)                                 |                                                                |
| leconte     | 168 Core 602 Gi | NVIDIA V100 * 6                              | PowerPC (Summit)                                               |
| Zenith      | 32 Core 132 Gi  | <p>Nvidia GTX 3090<br>AMD Radeon RX 6800</p> | TL                                                             |
| Zenith2     | 32 Core 256 Gi  | <p>Nvidia GTX 5090<br>Various Embedded FPGA devboards</p> | TL                                                             |

Notes:
 - All of the general compute resources have hyperthreading enabled unless otherwise stated.. This can be changed on a per request basis.
 - TL: Thinlinc enabled. Need to use `login` as a jump host for resources other than `login`. See [ThinLinc Quickstart](../quick-start-guides/thinlinc.md)
 - Slurm: Node is added to a slurm partition and will likely be used for running slurm jobs. Try to make sure your interactive use does not conflict with any active Slurm jobs.
     - Most of the general compute resources are Slurm-enabled, to allow queuing of larger-scale workloads. `excl-help@ornl.gov` for specialized assistance. Only the systems that are heavily used for running Slurm jobs are marked “Slurm” above.

### Graphical session use via ThinLinc

- `login` — not for heavy computation
- `zenith`
- `zenith2`
- `clark`
- `lewis`
- `pcie`
- `intrepid`
- `spike`

### Slurm for Large Jobs

- Triple Crown — Dedicated Slurm runners.
  - `affirmed`
  - `justify`
  - `secretariat`
  - `pharaoh`

- Milan — Additional Slurm Resources with other shared use.
  - `milan0`
  - `milan1`
  - `milan3`

- Others — Shared slurm runners with interactive use.
  - `milan[0-3]`
  - `cousteau`
  - `excl-us03`
  - `explorer`
  - `oswald`
  - `oswald[00, 02-03]`

### Gitlab Runner Specialized Nodes

- `slurm-gitlab-runner` — Gitlab Runner for launching slurm jobs.
- `docker` — for docker runner jobs.
- `devdoc` — for internal development documentation building and hosting.

Note: any node can be used as a CI runner on request. See [GitLab Runner Quickstart](../quick-start-guides/gitlab-ci.md) and [GitHub Runner Quickstart](../quick-start-guides/github-ci.md). The above systems have a dedicated or specialized use with CI.

### Docker

- `docker` — Node with docker installed.

### Specialized usage and reservations

| Host | Specialized Usage | Reserved? |
| --- | --- | --- |
| dragon (vm) | Siemens EDA Tools | task-reserved |
| devdocs (vm) | Internal development documentation building and hosting | task-reserved |
| spike (vm) | `pcie` vm with FPGA and GPU passthrough access | task-reserved |
| lewis | U250 | RISC-V Emulation using U250 | - |
| slurm-gitlab-runner | slurm integration with gitlab-runner | task-reserved |
| docker | slurm-integration with gitlab runner for containers | reserved for container use |

Notes:
 - task-reserved: reserved for specialized tasks, not for project

## Infrastructure Systems

| Host Name               | Description                  | OS         |
| ----------------------- | ---------------------------- | ---------- |
| hyp00 (hypervisor only) | AMD 96 Core 384 Gi Memory    | Rocky 10   |
| hyp01 (hypervisor only) | AMD 96 Core 384 Gi Memory    | Rocky 10   |
| fs01 NFS file server    | Intel 5317 48 Core 512 Gi    | RHEL 9     | 
| fs00 NFS HA file server | Intel E5-2864 56 Core 128 Gi | Rocky 9    |
