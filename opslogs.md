## ExCL Operations Log

<!---
https://www.markdownguide.org/extended-syntax
-->

This documents system configurations changes and other things that might affect ExCL users on a day to day basis.

# Currrent Status

- quad02 offline for UEFI investigation (part of the makeItSo initiative).

- thunderx offline for Centos 8 installation and authentication configuration. 

# September 2, 2020

- Overnight: had spotty accessibility to home directories on login; fielded two reports.   Problem appears to be timing of snapshot maintenance, and duration of time it takes to delete monthly snapshots.

    - Removed a few older snapshots

    - Began duplicating (rsync) home directores to a non-snapshotted file system.  When this completes, will have a short outage to home directores to transition to new file system.  This will not be for some days.


# September 1, 2020

- fs00 (home directory and infrastructure fileserver) networking changed from single 10gb to four bonded 10gb interfaces.   Four is excessive, but the interfaces weren't getting used, so why not.    Type 4 Bonding (802.3ad).  https://www.interserver.net/tips/kb/network-bonding-types-network-bonding/

- fs00 kernel update and reboot.  Should have taken sixty seconds or so, but a logical valume rescan was forced.  The logical volume containing the home directory took several hours.   Service brought back up without loss.

- took quad02 offline, converted to UEFI boot, working on getting pxe booting going.  Let excl-help@ornl.gov know if this impacts your workflow.

