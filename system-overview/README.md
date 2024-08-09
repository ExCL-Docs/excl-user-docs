---
description: Overview of ExCL Systems
cover: ../.gitbook/assets/systems-image.jpg
coverY: 0
---
# System Overview

## ExCL Server List with Accelerators

| Host Name                                  | Description                                                      | OS                    | Accelerators or other special hardware                                 |
| ------------------------------------------ | ---------------------------------------------------------------- | --------------------- | ---------------------------------------------------------------------- |
| [affirmed](triple-crown.md#affirmed)       | Triple Crown AMD EPYC 7742 (Rome) 2x64-core 1 TB                 | Ubuntu 22.04          | <p>Bluefield 2 </p><p>NIC/DPUs</p>                                     |
| [amundsen](amundsen.md)                    | Desktop embedded system development                              | Ubuntu 20.04          | Snapdragon 855 (desktop retiring)                                      |
| [apachepass](apachepass.md)                | ApachePass memory system                                         | Centos 7.9            | 375 GB Apachepass memory                                               |
| [clark](clark.md)                          | Desktop embedded system development                              | Ubuntu 22.04          | Intel A770 Accelerator                                                 |
| [cousteau](cousteau.md)                    | AMD EPYC 7272 (Rome) 2x12-core 256 GB                            | Ubuntu 22.04          | 2 AMD MI100 32 GB GPUs                                                 |
| [docker](docker.md) (quad03)               | Intel 20 Core Server 96 GB                                       | Ubuntu 20.04          | Docker development environment                                         |
| [equinox](equinox.md)                      | DGX Workstation Intel Xeon E5-2698 v4 (Broadwell) 20-core 256 GB | Ubuntu 22.04          | 4 Tesla V100-DGXS 32 GB GPUs                                           |
| [explorer](explorer.md)                    | AMD EPYC 7702 (Rome) 2x64-core 512 GB                            | Ubuntu 22.04          | 2 AMD MI60 32 GB GPUs                                                  |
| [hudson](hudson.md)                        | AMD EPYC 9454 (Genoa) 2x48-core 1.5 TB                           | Ubuntu 22.04          | 2 Nvidia H100s                                                         |
| [justify](triple-crown.md#justify)         | Triple Crown AMD EPYC 7742 (Rome) 2x64-core 1 TB                 | Centos 7.9            |                                                                        |
| [leconte](leconte.md)                      | Summit server POWER9 42 Cores                                    | Centos 8.4            | 6 Tesla V100 16 GB GPUs                                                |
| [lewis](lewis.md)                          | Desktop embedded system development                              | Ubuntu 22.04          |                                                                        |
| [mcmurdo](mcmurdo.md)                      | Desktop embedded system development                              | Ubuntu 20.04          | Snapdragon 855 & PolarFire SoC (retiring)                              |
| [milan0](milan.md)                         | AMD EPYC 7513 (Milan) 2x32-core 1 TB                             | Ubuntu 22.04          | 2 \* Nvidia A100                                                       |
| [milan1](milan.md)                         | AMD EPYC 7513 (Milan) 2x32-core 1 TB                             | Ubuntu 22.04 or other | 2 Groq AI accelerators                                                 |
| [milan2](milan.md)                         | AMD EPYC 7513 (Milan) 2x32-core 1 TB                             | Ubuntu 22.04 or other | 8 Nvidia Tesla V100-PCIE-32GB GPUs                                     |
| [milan3](milan.md)                         | AMD EPYC 7513 (Milan) 2x32-core 1 TB                             | Ubuntu 22.04 or other | General Use                                                            |
| [minim1](minim1.md)                        | Apple M1 Desktop                                                 | OSX                   |                                                                        |
| [oswald00](oswald.md)                      | Intel Xeon E5-2683 v4 (Haswell) 2x16-core 256 GB                 | Centos 7.9            | Tesla P100 & Nallatech FPGA                                            |
| [oswald02](oswald.md)                      | Intel Xeon E5-2683 v4 (Haswell) 2x16-core 256 GB                 | Centos 7.9            | Tesla P100 & Nallatech FPGA                                            |
| [oswald03](oswald.md)                      | Intel Xeon E5-2683 v4 (Haswell) 2x16-core 256 GB                 | Centos 7.9            | Tesla P100 & Nallatech FPGA                                            |
| [pcie](pcie.md)                            | Intel Xeon Gold 6130 CPU (Skylake) 32-core 192 GB                | Ubuntu 22.04          | <p>Xylinx U250<br>Nalllatech Stratix 10<br>Tesla P100<br>Groq Card</p> |
| [pharoah](triple-crown.md#pharoah)         | Triple Crown AMD EPYC 7742 (Rome) 2x64-core 1 TB                 | Centos 7.9            |                                                                        |
| [radeon](radeon.md)                        | Intel 4 Core 64 GB                                               | Ubuntu 22.04          | AMD Vega20 Radeon VII GPU                                              |
| [secretariat](triple-crown.md#secretariat) | Triple Crown AMD EPYC 7742 (Rome) 2x64-core 1 TB                 | Ubuntu 22.04          | Bluefield 2 NIC/DPU                                                    |
| [thunderx](thunderx.md)                    | ARM Cavium ThunderX2 Server 128 GB                               | Centos Stream 8       |                                                                        |
| [xavier\[1-3\]](xavier.md)                 | Nvidia Jetson AGX                                                | Ubuntu                | Volta GPU                                                              |
| [xavier\[4-5\]](xavier.md)                 | Nvidia Jetson AGX Orin                                           | Ubuntu                | Ampere GPU (not deployed)                                              |
| [zenith](zenith.md)                        | AMD Ryzen Threadripper 3970X (Castle Peak) 32-core 132 GB        | Ubuntu 22.04          | <p>Nvidia GTX 3090<br>AMD Radeon RX 6800</p>                           |

## New Systems and Devices to be Deployed

* 2 Snapdragon HDK & Display
* Intel ARC GPU
* Achronix FPGA
* AGX Orin Developer Kits
* Xilinx U280
* 2 Ettus x410 high-performance, multi-channel, Zynq US+ RFSoC based software defined radio (SDR)

## Accelerator Highlights

| Accelerator Name                         | Host(s)                  |
| ---------------------------------------- | ------------------------ |
| AMD Radeon VII GPU                       | radeon                   |
| AMD MI60 GPU                             | explorer                 |
| AMD MI100 GPU                            | cousteau                 |
| [Groq](../quick-start-guides/groq.md)    | milan\[1-2]              |
| Nvidia P100 GPU                          | pcie                     |
| Nvidia V100 GPU                          | equinox, leconte, milan2 |
| Nvidia Jetson                            | xavier                   |
| [Qualcomm Snapdragon 855](snapdragon.md) | amundsen, mcmurdo        |
| Intel Stratix 10 FPGA                    | pcie                     |
| Xilinx Zynq ZCU 102                      | n/a                      |
| Xilinx Zynq ZCU 106                      | n/a                      |
| Xilinx Alveo U250                        | pcie                     |

## Unique Architecture Highlights

| Accelerator Name                  | Host(s)       |
| --------------------------------- | ------------- |
| Intel Optane DC Persistent Memory | apachepass    |
| Emu Technology CPU                | [emu](emu.md) |
| Cavium CPU                        | thunderx      |

## Other Equipment

* RTP164 High Performance Oscilloscope

## Primary Usage Notes

### General Interactive Login Use

### Graphical Login use via ThinLinc

- `login` — not for heavy jobs.
- `zenith`
- `clark`
- `lewis`
- `pcie`
- `intrepid`

### Slurm for Large Jobs

- Triple Crown — Dedicated Slurm runners.
    - `affirmed`
    - `justify`
    - `secretariat`
    - `pharaoh`
- Others — Shared with interactive use.
    - `milan[0-3]`
    - `cousteau`
    - `excl-us03`
    - `explorer`
    - `oswald`
    - `oswald[00, 02-03]`

### Gitlab Runner

### Docker

- `docker`

### Specialized Use

- `dragon` — Siemens EDA Tools.

### Project-based Use

- `lewis` — RISC-V emulation using U250.

## Infrastructure Systems

| Host Name              | Description                         | OS         |
| ---------------------- | ----------------------------------- | ---------- |
| excl-us00              | Intel 16 Core Utility Server 196 GB |            |
| excl-us01 (hypervisor) | Intel 16 Core Utility Server 196 GB |            |
| excl-us03              | Intel 16 Core Utility Server 196 GB |            |
| oswald                 | Intel 16 Core 128 GB utility server | Centos 7.9 |
| quad00                 | Intel 20 Core 96 GB utility server  | Centos 7.9 |
| quad01                 | Intel 20 Core 96 GB utility server  | Centos 7.9 |
| quad02                 | Intel 20 Core 96 GB utility server  | Centos 7.9 |

# Test

{% raw %}
<html>
<body>

<style>
.markmap > svg {
  width: 100%;
  height: 300px;
}
</style>

<div class="markmap">

# ExCL

## Systems

## Services

## Quickstart

</div>
</body>
<script src="https://cdn.jsdelivr.net/npm/markmap-autoloader"></script>
</html>
{% endraw %}
