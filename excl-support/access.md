# Access to ExCL

To become authorized to access ExCL facilities, please apply at [https://www.excl.ornl.gov/accessing-excl/](https://www.excl.ornl.gov/accessing-excl/). You have the option of using your ORNL (ucams) account if you have one, or creating an xcams (external user) account if you wish.

{% hint style="danger" %}
**New Initial MFA Setup Step**: MFA is now required for our systems when connecting from external networks. There is a new first-time setup step to set up a one-time password (OTP) generator using a QR code. See [one-time multi-factor authentication setup](https://docs.excl.ornl.gov/excl-support/access#one-time-multi-factor-authentication-setup).

This QR code does not render properly if you try logging in via ThinLinc or VS Code, so the first external login to set this up, should be done with standard SSH via a standard terminal.
{% endhint %}

## One-time multi-factor authentication setup

1. Access login.excl.ornl.gov via ssh.
2. Receive a QR prompt.
3. Configure your favorite multi-factor authenticator (Google/Microsoft/Duo/2FAS Auth/FreeOTP) using the QR prompt.
4. Use the authenticator-generated single-use time-limited key as your OTP into ExCL after completing the password prompt.

{% hint style="warning" %}
**Caution:** The QR code will only be shown once. If you miss it, you will need to [reach out](https://www.excl.ornl.gov/support-request/) for a reset, which goes in a separate ticketing system and could have delays.
{% endhint %}

{% hint style="warning" %}
There are known issues with the QR code generation and various methods of logging in. Please use a regular SSH terminal session to log in so that the QR code is rendered correctly. The suggestion is to use a Linux terminal, cmd line, powershell, or WSL from Windows, or the mac terminal or iTerm.o
{% endhint %}

{% hint style="info" %}
If you have SSH keys set up already, you will not see the QR code but will connect like normal. So, to get to the password and QR prompt run:  

```bash
ssh -o PubkeyAuthentication=no -o PreferredAuthentications=keyboard-interactive <username>@login-excl.ornl.gov
```
  
replacing `<username>` with your correct ExCL username.
{% endhint %}

## Regular access

Once you have access, you have a couple of options.

- login.excl.ornl.gov runs an SSH Server and you can connect to the login node with `ssh <username>@login.excl.ornl.gov`.
- There is a limited number of [ThinLinc](https://www.cendio.com/thinlinc/what-is-thinlinc) licenses available. Thinlinc (Xfce Desktop) can be accessed at [https://login.excl.ornl.gov:300](https://login.excl.ornl.gov:300) for HTML5 services, and ThinLinc clients can use login.excl.ornl.gov as their destination. ThinLinc clients can be downloaded without cost from [https://www.cendio.com/thinlinc/download](https://www.cendio.com/thinlinc/download). ThinLinc provides much better performance than tunneling X over SSH. A common strategy is to access login.excl.ornl.gov via ThinLinc and then use X11 forwarding to access GUIs running on other nodes.

Notes:
- Using an SSH key instead of a password to connect to ExCL is highly recommended. See [How to get start with SSH keys](../software/git.md#ssh-keys-for-authentication). SSH keys are more secure than passwords, and you are less likely to accidentally get banned from multiple incorrect login attempts when using SSH Keys to authenticate. If you get blocked, you can [open a help ticket](https://www.excl.ornl.gov/support-request/) with your IP address to get removed from the block list.
- If you use a passphrase with your SSH key (recommended for security), you should also set up an SSH Agent to load the SSH key. An SSH Agent allows you to enter your passphrase once for the session without needing to enter your passphrase many times. The VS Code documentation is well written for setting up this SSH Agent on a variety of platforms; see [Visual Studio Code Remote Development Troubleshooting Tips and Tricks](https://code.visualstudio.com/docs/remote/troubleshooting#_setting-up-the-ssh-agent).
- It is recommended to use a terminal multiplexer like [tmux](https://github.com/tmux/tmux/wiki) or [screen](https://www.gnu.org/software/screen/). These tools keep your session active and can be reattached to if you loose network connection. They also allow you to open multiple windows or split panels.

{% hint style="success" %}
**Next Steps:** Get started with recommended practices by following the [ExCL Remote Development](../quick-start-guides/excl-remote-development.md) quick start guide.
{% endhint %}

## Add SSH Public Key to ExCL’s Authorized Keys

You can manually copy the key if already on ExCL. For example
```bash
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
```

Or you can you `ssh-copy-id` to copy your local systems key to ExCL.
```bash
ssh-copy-id login.excl.ornl.gov
```

# Login Server Quotas

The ExCL Login Server has per-user resource limits to prevent individual sessions or processes from consuming too many GPU or memory resources, that could negatively impact others.

Each user is now limited to the following aggregate resources across all processes running under their login sessions:

- **CPU:** 1 CPU core worth of aggregate CPU time
- **Maximum memory:** 1.5 GiB
- **Maximum swap:** 512 MiB

This new limit does mean that a VS Code server with extensions will no longer be able to run on the login node. For information on how to directly connect to a worker node using VS Code, see [Visual Studio Code | ExCL User Docs](https://docs.excl.ornl.gov/quick-start-guides/visual-studio-code).

Users can check their current resource usage and the counts of the number of times they have exceeded their RAM resource limit with:

```bash
login-quota-check
```
