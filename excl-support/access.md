# Access to ExCL

To become authorized to access ExCL facilities, please apply at [https://www.excl.ornl.gov/accessing-excl/](https://www.excl.ornl.gov/accessing-excl/). You have the option of using your ORNL (ucams) account if you have one, or creating an xcams (external user) account if you wish.

Once you have access you have a couple of options.

* login.excl.ornl.gov runs an SSH Server and you can connect to the login node with `ssh login.excl.ornl.gov`.
* There is a limited number of [ThinLinc](https://www.cendio.com/thinlinc/what-is-thinlinc) licenses available. Thinlinc (Xfce Desktop) can be accessed at [https://login.excl.ornl.gov:300](https://login.excl.ornl.gov:300) for HTML5 services, and ThinLinc clients can use login.excl.ornl.gov as their destination. ThinLinc clients can be downloaded without cost from [https://www.cendio.com/thinlinc/download](https://www.cendio.com/thinlinc/download). ThinLinc provides much better performance than tunneling X over SSH. A common strategy is to access login.excl.ornl.gov via ThinLinc and then use X11 forwarding to access GUIs running on other nodes.

Notes:
- Using an SSH key instead of a password to connect to ExCL is highly recommended. SSH keys are more secure than passwords, and you are less likely to accidentally get banned from multiple incorrect login attempts when using SSH Keys to authenticate. If you get blocked, you can send a help ticket to [excl-help@ornl.gov](mailto:excl-help@ornl.gov) with your IP address to get removed from the block list.
- If you use a passphrase with your SSH key (recommended for security), you should also set up an SSH Agent to load the SSH key. An SSH Agent allows you to enter your passphrase once for the session without needing to enter your passphrase potentially many times for each git command. The VS Code documentation is well written for setting up this SSH Agent on a variety of platforms; see [Visual Studio Code Remote Development Troubleshooting Tips and Tricks](https://code.visualstudio.com/docs/remote/troubleshooting#_setting-up-the-ssh-agent).
