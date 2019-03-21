# leconte.ftpn.ornl.gov - IBM GTW-8335 (Summit) node

## Description

This system is generally identical to the nodes (AC922 model 8335_GTW)
in the ORNL OLCF Summit system.  This system consists of

*  2 POWER9 (2.2 pvr 004e 1202) cpus, each with 22 cores and 
   4 threads per core.

*  6 Tesla V100-SXM2-16GB GPUs

*  606GiB memory

*  automounted home directory (on group NFS server)


## Contact
* excl-help@ornl.gov

## Usage

As currently configured this system is usable using conventional 
ssh logins (from login.excl.ornl.gov), with automounted home 
directories.  GPU access is currently cooperative; a scheduling
mechanism and scheduled access is in design.

The software is as delivered by the vendor, and may not be
satisfactory in all respects as of this writing.   The intent
is to provision a system that is as similar in all respects to
Summit, but some progress is required to get there.  This is to
be considered an early access machine.

Please send assistance requests to excl-admin@ornl.gov.

## GPU Performance

This system is still being refined with respect to cooling.
As of today, rather than running at the fully capable 300 watts
per GPU, GPU usage has been limited to 250 watts to prevent
overheating.   As cooling is improved, this will be changed back
to 300 watts with dynamic power reduction (with notification) as
required to protect the equipment. 

It is worth noting that this system had to be pushed quite hard
(six independent nbody problems, plus CPU stressors on all but 
8 threads) to trigger high temperature conditions.  These limits 
may not be encountered in actual use.

### Performance Information

GPU performance information can be viewed at 

https://graphite.ornl.gov:3000/d/000000058/leconte-gpu-statistics?refresh=30s&orgId=1

Request access by emailing excl-admin@ornl.gov.   This site still uses a self-signed certificate; a fix for that is in the works.

## Other Resources

* IBM 8335-GTW documentation: https://www.ibm.com/support/knowledgecenter/en/POWER9/p9hdx/8335_gtw_landing.htm
