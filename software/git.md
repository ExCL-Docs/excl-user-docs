# Git

Git \(code revision management system\) is installed on all ExCL systems on which it makes sense. Git operates as expected, except for external access.

If you require access to external git resources, you need to do a little more.

## HTTP or HTTPS access

For HTTP or HTTPS access, make sure you have the following environment variables  
\(they should be set by default, but may not be if you have altered your environment\)

```bash
http_proxy=http://proxy.ftpn.ornl.gov:3128
https_proxy=http://proxy.ftpn.ornl.gov:3128
```

The proxy server has access to the full Oak Ridge network \(open research only\).

## git protocol access

Some projects require git protocol access. This is done by proxying git requests through the ExCL proxy server, which has outgoing read-only access on port 9418. To configure your environment to make this work:

1\) Put the following file somewhere in your executable path:  
$ cat git-proxy

```bash
#!/bin/bash
socat - PROXY:proxy.ftpn.ornl.gov:$1:$2,proxyport=3128
```

2\) You may need to modify your executable path by adding this to your .bash\_profile

```bash
PATH=${PATH}:${HOME}/bin
```

If you have done so, you can put git-proxy ~/bin. Make sure you have modified its permissions so it is executable.

3\) Add the following line to your `~/.gitconfig` file

```text
[core]
    gitProxy = git-proxy
```

You should now be able to clone via the git protocol from a remote GitLab or GitHub instance.

If you get a complaint about not being able to find socat, send an email to [excl-help@ornl.gov](mailto:excl-help@ornl.gov), indicating which system it is, and I will address it as soon as I see it.

exception 160.91.186.123:_-&gt;_:9418 service.ftpn.ornl.gov. squid proxy configured to allow this.

## Git Config to convert Git SSH URLs to HTTPS

An alternative to setting up a proxy is to configure Git to convert Git URLs to HTTPS URLs by changing your global git config with the following commands.

```bash
git config --global url."https://bitbucket.org/".insteadOf git@bitbucket.org:
git config --global url."https://github.com/".insteadOf git@github.com:
```

