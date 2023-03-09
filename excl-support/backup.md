# Backup

{% hint style="danger" %}
ExCL does not have operational backups. Please store important files in source control, for example using git.
{% endhint %}

ExCL has disaster recovery backups, but it does not have operational backups. For disaster recovery,  `/home` is backed up to tape nightly. Therefore if you have large files which do not need disaster recovery, please store them in` /noback/<userid>/`.
