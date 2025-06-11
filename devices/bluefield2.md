
# Nvidia BlueField 2 DPUs

These card are currently installed on Secretariat and Affirmed, but will eventually be moved to take advantage of GPUs installed elsewhere.

## Software installation

All DOCA, embedded and BSP software was updated in September 2023, using the following:

 *  doca-host-repo-ubuntu2204_2.2.0-0.0.3.2.2.0080.1.23.07.0.5.0.0_amd64.deb
 *  doca-dpu-repo-ubuntu2204-local_2.2.0080-1.23.07.0.5.0.0.bf.4.2.0.12855.2.23.prod_arm64.deb
 * DOCA_2.2.0_BSP_4.2.0_Ubuntu_22.04-2.23-07.prod.bfb

Reference: https://docs.nvidia.com/doca/sdk/installation-guide-for-linux/index.html#manual-bluefield-image-installation

Devices are available and connected to each other via 100Gb IB across an IB switch.   
