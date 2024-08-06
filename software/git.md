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

## Git SSH Access

ssh can be used to clone repositories on the login node. In order to clone repositories on the internal nodes, the ssh config needs to be changed to use the login node as a proxy jump. Here is an example ssh config with jump proxies to code.ornl.gov, bitbucket.org, and github.com.

```config
Host code.ornl.gov bitbucket.org github.com
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
