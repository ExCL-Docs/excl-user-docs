# emu.ftpn.ornl.gov - EMU Chick

## Description
![Emu System Overview](images/emu-overview.png?raw=true "Emu System Overview")

EMU-Chick System is composed of 8x nodes that are connected via RapidIO Interconnect.

Each node has:
* 8x nodelets, array of DRAMs
* A stationary core (SC)
* Migration engine, PCI-Express interfaces, and an SSD. 
* 64-byte channel 64GB of DRAM, divided into eight 8-byte narrow-channel-DRAMs (NC-DRAM

Each nodelet has: 
* 2x Gosamer cores (GC)
* 64 concurrent in-order, single-issue hardware threads




## Contact
* excl-help@ornl.gov


## Usage

Key-based ssh login from login.excl.ornl.gov.   If you can't log in
you do not have access.  If you should have access please contact
excl-help@ornl.gov.

The development environment is on emu-gw; please log in there to build 
your applications.   emu and emu-gw mount home directories, so you should
have no difficulty accessing your projects.   Please use `$HOME` (or `${HOME}`)
as your home directory in scripts, as the mount location of 
your home directory may change.

Please send assistance requests to excl-help@ornl.gov.


## Other Resources

This document will be updated with dditional documentation references 
and user information as it becomes available.
will 

