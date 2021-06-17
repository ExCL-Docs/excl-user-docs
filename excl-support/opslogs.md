# Operations Log

This documents system configurations changes and other things that might affect ExCL users on a day to day basis.

## Current Status

* quad02 allocated for deployment research; not available for computation

## November 10, 2020

Thunderx \(Cavium ThunderX2 ARM system\) restored to service. Configuration continuing due to problems encountered with Centos 8 and ARM combination \(particularly with respect to available software\).

## October 5, 2020

* radeon.ftpn.ornl.gov updated to Ubuntu 20.04 LTS.   
  * important note: users must be in the "render" group or 

    codes will segfault.

## October 2, 2020

* rocm reinstalled on radeon.ftpn.ornl.gov and explorer.ftpn.ornl.gov, tested

  using matrix test program [&lt;&lt;https://github.com/ROCm-Developer-Tools/HIP/tree/master/samples/2\_Cookbook/0\_MatrixTranspose](https://github.com/ORNL-ExCL/excl-user-docs/tree/5b0a2bac08c6595857ffaa414e0a315a8fdfa27c/%3C%3Chttps:/github.com/ROCm-Developer-Tools/HIP/tree/master/samples/2_Cookbook/0_MatrixTranspose/README.md)&gt;&gt;

## September 22, 2020

* Alveo 250 FPGA card deployed, with all attendant software.
* thunderx returned to service.  Let excl-help@ornl.gov know of any issues.

## September 4, 2020

* quad00 exhibited misbehaviour \(refusing root logins, even\). Rebooted at remote console, seems ok now. Most likely cause is NFS stack issues having to do with the fs00 issue on 9/1 \(based on syslog output\).
* quad02 returned to service -- will not be working on UEFI boot today.

## September 2, 2020

* Overnight: had spotty accessibility to home directories on login; fielded two reports. Problem appears to be timing of snapshot maintenance, and duration of time it takes to delete monthly snapshots.
  * Removed a few older snapshots
  * Began duplicating \(rsync\) home directores to a non-snapshotted file system. When this completes, will have a short outage to home directores to transition to new file system. This will not be for some days.

## September 1, 2020

* fs00 \(home directory and infrastructure fileserver\) networking changed from single 10gb to four bonded 10gb interfaces. Four is excessive, but the interfaces weren't getting used, so why not. Type 4 Bonding \(802.3ad\). [https://www.interserver.net/tips/kb/network-bonding-types-network-bonding/](https://www.interserver.net/tips/kb/network-bonding-types-network-bonding/)
* fs00 kernel update and reboot. Should have taken sixty seconds or so, but a logical valume rescan was forced. The logical volume containing the home directory took several hours. Service brought back up without loss.
* took quad02 offline, converted to UEFI boot, working on getting pxe booting going. Let excl-help@ornl.gov know if this impacts your workflow.

