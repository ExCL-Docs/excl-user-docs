# Frequently encountered problems.

## I can't log in

There are two most likely sources of this problem

### Password won't work

The most frequent cause is having your visitor (non-ORNL internal password)
wrong, or having had it expire. See `https://xcams.ornl.gov` to address
this. If you are ORNL staff, a frequent cause is a failure to keep your
internal ORNL systems password up to date (UCAMS) or have missed required
training. ExCL makes the same check that any ORNL system makes as to
whether a password is valid or an account exists (you will not be able to
differentiate the two errors based on the login failure). This will look
like

```text
$ ssh login.excl.ornl.gov
hsm@login.excl.ornl.gov's password:
Permission denied, please try again.
```

### Too many login attempts from a given IP address

ExCL limits logins to five consecutive failures within a short period of time.
After that limit exceeded, login attempts from your IP address will be blocked.
This might look like

```text
$ ssh login.excl.ornl.gov
ssh: connect to host login.excl.ornl.gov port 22: Operation timed out
```

To have this addressed, report your IP address to `excl-help@ornl.gov`.
If you are on an ORNL network, you can use the usual native tools on
your system to find your IP address. If you are at home and on a network
using NAT (as most home networks do) use
[What Is My IP? Best Way To Check Your Public IP Address](https://www.whatismyip.com/)
to determine your public IPv4 address when external to the lab. Note that
this will not report the correct address if you are on an ORNL
(workstations or visitor) network.

## I can’t clone my git repo

The recommended approach for accessing git repositories in ExCL is to use the SSH protocol instead of the HTTPS protocol for private repositories and either protocol for public repositories. However, both approaches will work with the proper proxies, keys, applications passwords, and password managers in place.

To use the SSH protocol you must first setup SSH keys to the git website (i.e. GitLab, GitHub, and Bitbucket). See [Git - Setup Git access to code.ornl.gov | ExCL User Docs (ornl.gov)](https://docs.excl.ornl.gov/software/git#setup-git-access-to-code.ornl.gov) for details for how to do this for code.ornl.gov. The other Git Clouds have similar methods to add SSH keys to your profile.

Since the worker nodes are behind a proxy. You must setup an SSH jump host in your `.ssh/config` to access Git SSH servers. See [Git - Git SSH Access | ExCL User Docs (ornl.gov)](https://docs.excl.ornl.gov/software/git#git-ssh-access) to verify that you have set up the proper lines in your SSH Config.

## I need a newer version of pip

See [Python | ExCL User Docs](https://docs.excl.ornl.gov/quick-start-guides/python#python-virtual-environments-with-venv) for instructions on how to set up a Python virtual environment with the latest version of pip.

## I need a newer version of Python

See [Python | ExCL User Docs](https://docs.excl.ornl.gov/quick-start-guides/python#using-uv-to-create-a-python-virtual-environment-with-a-specific-version-of-python) for instructions on how to use UV to set up a Python virtual environment with a specific python version.

## I can't access git/web/whatever from within docker.

Docker does not pick up user environment variables when a container is started, nor does it pick up variables from the docker daemon.   These environment variables are required for Docker to access services outside of the ExCL environment (via a squid proxy).

This can be done by creating ~/.docker/config.json with the contents:

```json
{
 "proxies": {
   "default": {
     "httpProxy": "http://proxy.ftpn.ornl.gov:3128",
     "httpsProxy": "https://proxy.ftpn.ornl.gov:3128"
   }
 }
}
```


