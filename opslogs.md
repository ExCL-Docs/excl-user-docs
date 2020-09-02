## ExCL Operations Log

This documents system configurations changes and other things that might affect ExCL users on a day to day basis.

# September 1, 2020

- fs00 (home directory and infrastructure fileserver) networking changed from single 10gb to four bonded 10gb interfaces.   Four is excessive, but the interfaces weren't getting used, so why not.    Type 4 Bonding (802.3ad).  https://www.interserver.net/tips/kb/network-bonding-types-network-bonding/

- fs00 kernel update and reboot.  Should have taken sixty seconds or so, but a logical valume rescan was forced.  The logical volume containing the home directory took several hours.   Service brought back up without loss.

