# Backup and Storage

See the [Cheat Sheet for a quick summary](https://docs.excl.ornl.gov/#excl-cheat-sheet).

## Backup

User files (home directories) are stored on an ZFS-based NFS server, and are generally available to all ExCL systems (there are exceptions for operational and security reasons; if you trip over something please let [excl-help@ornl.gov](mailto:excl-help@ornl.gov) know). The `/noback/<user>` facility is no longer required and is not being created for new users accounts. Files already in the `/noback` hierarchy will not be affected; if you would like assistance in moving these files to your home directory please let [excl-help@ornl.gov](mailto:excl-help@ornl.gov) know.

{% hint style="danger" %}
While our file server and backup file server are quite robust, ExCL does not have formally supported backups. Please store important files in source control, for example using git. Important data (if any) should be duplicated elsewhere; contact excl-help@ornl.gov for assistance.
{% endhint %}

ExCL uses ZFS with snapshots. The homegrown scripts to manage snapshot and replication have been replaced by zrepl (<https://zrepl.github.io/>), which has much better handling of edge condition, and is overall much more reliable. Zrepl handles both automated snapshot generation and file system replication. Snapshots are taken hourly, and ExCL file systems are replicated to the back up (old FS00) fileserver.

In the past, snapshots have been available as `~/.zfs/snapshot/(hourly,daily,weekly)*`. These will continue to be available as they age out, then will simply disappear. The new snapshot format is `~/.zfs/snapshots/zrepl_yyyymmdd_hhmmss_000` where the hour is in UCT (not Eastern Daylight/Standard Time). The use of UCT in the snapshot name is a zrepl property to enable global replication consistency, and is not modifiable. If you deleted or made a destructive modification to, say, `~/.bashrc` on June 11, 2024 at 3 PM, it should be available in `~/.zfs/snapshots/zrepl_20240611_185313_000/.bashrc`, and in earlier snapshots.

Snapshots take space for files that have changed or been deleted. They are automatically deleted as they age, so that all hourlies are kept for 48 hours, one hourly from each day is kept for 30 days, and one hourly for each 30 day period is kept for 180 days. This policy can be modified on request. Snapshots are read only; you can copy files from them back into your home directory tree to restore them.  

There is currently no file purge policy. Given that ExCL researchers take care of cleaning up files that are no longer in use, no change to this policy is foreseen. Files for inactive users are archived in a non-snapshot file system. While it is our intent to continue maintaining storage for inactive users, this policy may change in the future.

## Quotas

Quotas are applied to the ZFS filesystems to avoid runaway storage usage.
Quotas set in ZFS are easy to view and can be created at any level in the filesystem.
These quotas apply to all storage used by the filesystem, including snapshots of the data.
Because of this, deleting files will not reduce disk usage until the snapshots age out.
ZFS is smart and only stores changes in data.
It also stores data in a compressed format, so your disk usage is less than your apparent amount.
Home and project directories start with 512G per directory, and users can request higher quotas via [excl-help@ornl.gov](mailto:excl-help@ornl.gov).
We can also help diagnose the cause of large storage use by providing a breakdown of file usage and helping clean up unneeded large files and snapshots.
Use of /scratch/$USER for large temporary build artifacts that can be local to a node and do not require snapshotting can reduce ZFS storage usage.

## Local Storage

In addition to the shared network NFS storage, each system has a local scratch space: `/scratch/`. Users can store files on the local drive in `/scratch/$USER/`. This storage location is good for caching files on a local hard drive. For speeding up tasks with faster storage and performing tasks which can’t be done on NFS storage. (For example, Apptainer and embedded Linux builds.)

{% hint style="danger" %}
`/scratch/` is not shared between nodes, not stored in raid, and not backed up in any way. However, this storage does not have any automatic purging policy (unlike `/tmp/`), so the files should persist as long as the storage doesn’t fill up and the drives don’t fail.
{% endhint %}

A working space can be created with `mkdir /scratch/$USER`. Since there is no purging policy, please clean up after you no longer need the scratch space.
If a system does not already have a `/scratch` space please open a ticket via [excl-help@ornl.gov](mailto:excl-help@ornl.gov)
