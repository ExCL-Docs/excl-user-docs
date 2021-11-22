# Backup

{% hint style="danger" %}
ExCL does not have operational backups. Please store important files in source control, for example using git.
{% endhint %}

ExCL has disaster recovery backups, but it does not have operational backups. For disaster recovery,  `/home` is backed up to tape on reboot. Therefore if you have large files which do not need disaster recovery, please store them in` /noback/<userid>/`. If access to the disaster recovery backups is required, our contact at ITSD is Patti Clark. She will require the dates that the files were known to exist and a full path to the files.
