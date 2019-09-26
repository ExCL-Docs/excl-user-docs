

ExCL reserves the first Tuesday of every month for systems maintenance.  This may result in complete inaccessibility during business hours.  Every effort will be made to minimize the scope, duration, and effect of maintenance activities.

If an outage will affect urgent projects (i.e., with impending deadlines) please email excl-help@ornl.gov as soon as possible.

### Maintenenace Outage Tuesday October 1, 2019

On Tuesday October 1, there will be a short ExCL outage at 10 AM.  At this
time the following work will be done:

 *  File services (fs00) will be halted.   The home directories will have a final rsync to a partition with snapshots turned on.   When done file services will be reexported.  During this time any access to home directory trees is likely to hang or fail.

 *  Update all infrastructure systems to CentOS 7.7  (mostly done, will just need reboots).  This includes login.excl.ornl.gov (so login/thinlinc sessions will be terminated).

 *  leconte will be updated at this time (necessitating a reboot)

It is anticipated that all work will be competed by 11 AM.


### JICS 116 Computer Room Power Outage Friday October 18, 2019

There is a JICS 116 power outage scheduled for October 18 from 8am until approximately 3pm to change some breakers and add power whips to two of the room PDUs to power UT racks. 

Power will be removed from affected systems starting at 5:30 PM Thursday night.

Only the following systems will be affected: 

  * oswald
  * oswald0[0-3]
  * DGX Workstation (equinox)
  * emu
  * kold[0-3]
  * amundsen
  * mcmurdo

No core services (other than centralized logging) will be affected.



