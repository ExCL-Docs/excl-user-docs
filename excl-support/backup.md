# Backup and Storage

See the [Cheat Sheet for a quick summary](https://docs.excl.ornl.gov/#excl-cheat-sheet).

## Backup

User files (home directories) are stored on an ZFS-based NFS server, and are generally available to all ExCL systems (there are exceptions for operational and security reasons; if you trip over something please let [excl-help@ornl.gov](mailto:excl-help@ornl.gov) know). The `/noback/<user>` facility is no longer supported and is not being created for new users accounts. Files already in the `/noback` hierarchy will not be affected; if you would like assistance in moving these files to your home directory please let [excl-help@ornl.gov](mailto:excl-help@ornl.gov) know.  Space available to /noback is limited.

{% hint style="danger" %}
While our file server, backup file server, and ORNL-provided tape backup are quite robust, ExCL does not have formally supported backups. Please store important files in source control, for example using git with gitlab or github. Important data (if any) should be duplicated elsewhere; contact excl-help@ornl.gov for assistance.
{% endhint %}

ExCL uses ZFS with snapshots. Zrepl (<https://zrepl.github.io/>) handles both automated snapshot generation and file system replication. Snapshots are taken hourly, and ExCL file systems are replicated to the back up (old FS00) fileserver.
The snapshot directory name format is `~/.zfs/snapshots/zrepl_yyyymmdd_hhmmss_000` (where the hour is in UCT not Eastern Daylight/Standard Time). The use of UCT in the snapshot name is a zrepl property to enable global replication consistency, and is not modifiable.  If you deleted or made a destructive modification to, say, `~/.bashrc` on, say,  June 11, 2024 at 3 PM, it should be available in `~/.zfs/snapshots/zrepl_20240611_185313_000/.bashrc`, and in earlier snapshots.

Snapshots take space for files that have changed or been deleted. They are automatically deleted as they age, so that hourlies are kept for 48 hours, one hourly from each day is kept for 30 days, and one hourly for each 30 day period is kept for 180 days. This policy can be modified on request. Snapshots are read only; you can copy files from them back into your home directory tree to restore them.

There is currently no file purge policy. Given that ExCL researchers take care of cleaning up files that are no longer in use, no change to this policy is foreseen. Files for inactive users are archived in a non-snapshot file system. While it is our intent to continue maintaining storage for inactive users, this policy may change in the future.

## Quotas

Refquotas are applied to the ZFS filesystems to avoid runaway storage usage.
A refquota limit applies only to your files, not to snapshot storage.
ZFS stores data in a (very fast) compressed format, so disk usage may appear to be
less than you expect.
Home and project subvolumes start with a refquota of 512G.  Users can request higher quotas via [excl-help@ornl.gov](mailto:excl-help@ornl.gov).
We can also help diagnose the cause of large storage use by providing a breakdown of file usage and helping clean up unneeded large files and snapshots.

## Local Storage

In addition to shared network storage, each system has a local `/scratch`
directory.  The size will vary from system to system, and some systems may 
have `/scratch2` in addition. A working space can be created with 
`mkdir /scratch$USER` if one is not already present.
This storage location is good for caching files on local host storage, 
for speeding up tasks which are storage IO bound, and performing tasks 
which fail on NFS storage (for example, Apptainer and embedded Linux builds).
If you require more scratch storage than is available contact
[excl-help@ornl.gov](mailto:excl-help@ornl.gov) as on newer systems there is 
often additional storage available that has not been allocated.
Similarly contact us if there is no /scratch or /scratch2 directory.
Since there is (currently) no purging policy, please clean up after you 
no longer need your scratch space.

{% hint style="danger" %}
`/scratch/` is not shared between nodes, not stored in raid, and not backed up in any way. However, this storage does not have any automatic purging policy (unlike `/tmp/`), so the files should persist as long as the storage doesn’t fill up and the drives don’t fail.
{% endhint %}
