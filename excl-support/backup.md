# Backup and Storage

User files (home directories) are stored on an ZFS-based NFS server, and are generally available to all ExCL systems (there are exceptions for operational and security reasons. If you trip over something please let [excl-help@ornl.gov](mailto:excl-help@ornl.gov) know). The `/noback/<user>` facility is no longer required and is not being created for new users accounts. Files already in the `/noback` hierarchy will not be affected; if you would like assistance in moving these files to your home directory please let [excl-help@ornl.gov](mailto:excl-help@ornl.gov) know.

{% hint style="danger" %}
While our file server and backup file server are quite robust, ExCL does not have formally supported backups. Please store important files in source control, for example using git.
{% endhint %}

ExCL uses ZFS file systems with snapshots. If you inadvertently delete or alter a file, you can cd into `~/.zfs/snapshot` and peruse the various snapshots (the names are largely self-explanatory), and copy any files out you need.

Hourly snapshots are kept for at least 48 hours; daily snapshots are kept for 14 days; weekly snapshots are kept for 8 weeks. All user filesystems are also duplicated to the older file server as a hedge against misfortune.

There is currently no file purge policy. Given that ExCL researchers take care of cleaning up files that are no longer in use, no change to this policy is forseen.
