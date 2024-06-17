# Git

Git (code revision management system) is installed on all ExCL systems on which it makes sense. Git operates as expected, except for external access.

If you require access to external git resources, you need to do a little more.

## HTTP or HTTPS access

For HTTP or HTTPS access, make sure you have the following environment variables\
(they should be set by default, but may not be if you have altered your environment)

```bash
http_proxy=http://proxy.ftpn.ornl.gov:3128
https_proxy=http://proxy.ftpn.ornl.gov:3128
```

The proxy server has access to the full Oak Ridge network (open research only).

## git protocol access

Some projects require git protocol access. This is done by proxying git requests through the ExCL proxy server, which has outgoing read-only access on port 9418. To configure your environment to make this work:

1\) Put the following file somewhere in your executable path:\
$ cat git-proxy

```bash
#!/bin/bash
socat - PROXY:proxy.ftpn.ornl.gov:$1:$2,proxyport=3128
```

2\) You may need to modify your executable path by adding this to your .bash_profile

```bash
PATH=${PATH}:${HOME}/bin
```

If you have done so, you can put git-proxy \~/bin. Make sure you have modified its permissions so it is executable.

3\) Add the following line to your `~/.gitconfig` file

```
[core]
    gitProxy = git-proxy
```

You should now be able to clone via the git protocol from a remote GitLab or GitHub instance.

If you get a complaint about not being able to find socat, send an email to [excl-help@ornl.gov](mailto:excl-help@ornl.gov), indicating which system it is, and I will address it as soon as I see it.

exception 160.91.186.123:_->_:9418 service.ftpn.ornl.gov. squid proxy configured to allow this.

## Git config to convert Git SSH URLs to HTTPS

An alternative to setting up a proxy is to configure Git to convert Git URLs to HTTPS URLs by changing your global git config with the following commands.

```bash
git config --global url."https://bitbucket.org/".insteadOf git@bitbucket.org:
git config --global url."https://github.com/".insteadOf git@github.com:
```

## Git SSH Access

ssh can be used to clone repositories on the login node. In order to clone repositories on the internal nodes, the ssh config needs to be changed to use the login node as a proxy jump. Here is an example ssh config with jump proxies to code.ornl.gov, bitbucket.org, and github.com.

```config
Host code.ornl.gov
   HostName code.ornl.gov
   ProxyJump login

Host bitbucket.org
   HostName bitbucket.org
   ProxyJump login

Host github.com
   HostName github.com
   ProxyJump login
```

To configure git to always use ssh for code.ornl.gov repositories, use the config command below.

```bash
git config --global url."git@code.ornl.gov:".insteadOf https://code.ornl.gov/
```

## Setup Git access to [code.ornl.gov](https://code.ornl.gov)

The recommended approach to access `code.ornl.gov` is to use SSH. To do this, you need to generate an SSH key and add it to your GitLab account. The following steps will guide you through the process.

1. Generate an SSH key.

```bash
ssh-keygen
```

2. Add the SSH key to your GitLab account.

```bash
cat ~/.ssh/id_rsa.pub
```

3. Copy the output of the command and paste it into the SSH key section of your GitLab account settings.  
    ![code-ornl-user-preferences](../assets/code-ornl-user-preferences.png)   
    ![code-ornl-ssh-keys.png](../assets/code-ornl-ssh-keys.png)

4. If you are on an ExCL system and you have not already done so, configure your SSH client to use the login node as a jump proxy. See [Git SSH Access](#git-ssh-access) for more information.

If you use a passphrase with your SSH key (recommended for security), then you should also setup an SSH Agent to load the SSH key. This allows you to enter your passphrase once for the session without needing to enter your passphrase potentially many times for each git command. The VS Code documentation is well written for setting up this SSH Agent on a variety of platforms, see [Visual Studio Code Remote Development Troubleshooting Tips and Tricks](https://code.visualstudio.com/docs/remote/troubleshooting#_setting-up-the-ssh-agent).