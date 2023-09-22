# Placeholder for testing

# Nvidia BlueField 2 DPUs

These card are currently installed on Secretariat and Affirmed, but will eventually be moved to take advange of GPUs installed elsewhere.

## Software installation

All DOCA, embedded and BSP software was updated in September 2023, using the following:

 *  doca-host-repo-ubuntu2204_2.2.0-0.0.3.2.2.0080.1.23.07.0.5.0.0_amd64.deb
 *  doca-dpu-repo-ubuntu2204-local_2.2.0080-1.23.07.0.5.0.0.bf.4.2.0.12855.2.23.prod_arm64.deb
 * DOCA_2.2.0_BSP_4.2.0_Ubuntu_22.04-2.23-07.prod.bfb

Reference: https://docs.nvidia.com/doca/sdk/installation-guide-for-linux/index.html#manual-bluefield-image-installation

Using the following steps on the host

```
for f in $( dpkg --list | grep doca | awk '{print $2}' ); do echo $f ; apt remove --purge $f -y ; done
apt-get autoremove
dpkg -i doca-host-repo-ubuntu2204_2.2.0-0.0.3.2.2.0080.1.23.07.0.5.0.0_amd64.deb
apt-get update
apt install doca-runtime doca-sdk doca-tools
mst start
systemctl restart rshim
bfb-install --rshim /dev/rshim0 --bfb /tmp/DOCA_2.2.0_BSP_4.2.0_Ubuntu_22.04-2.23-07.prod.bfb  # takes quite a while
mlxfwreset -d /dev/mst/mt41686_pciconf0 --sync 1 -y reset
ssh ubuntu@192.168.100.2
dpu> sudo /opt/mellanox/mlnx-fw-updater/mlnx_fw_updater.pl --force-fw-update
```


