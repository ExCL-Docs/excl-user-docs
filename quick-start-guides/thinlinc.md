---
description: Getting started with ThinLinc.
---
# ThinLinc

The login node has [ThinLinc](https://www.cendio.com/thinlinc/what-is-thinlinc) install and can be accessed at [https://login.excl.ornl.gov:300](https://login.excl.ornl.gov:300). Since this node is public facing, it is the easiest to access with ThinLinc.

In addition to the login node, multiple systems including the [virtual systems](vitis.md#virtual-systems) have [ThinLinc](https://www.cendio.com/thinlinc/what-is-thinlinc) installed, which makes it easier to run graphical applications. To access ThinLinc you need to use as socks proxy to forward traffic to the ExCL network or port forwarding of port 22 to use the ThinLinc client.

For better keyboard shortcut support and to prevent the browser from triggering the shortcuts, I recommend installing [Open-as-Popup](https://chrome.google.com/webstore/detail/open-as-popup/ncppfjladdkdaemaghochfikpmghbcpc).

{% hint style="warning" %}
**Reminder**: You will need to re-do step 1 in [Setup FoxyProxy](https://docs.excl.ornl.gov/quick-start-guides/excl-remote-development#setup-foxyproxy) each time you want to connect to ExCL to form the Dynamic Proxy tunnel via SSH to the ExCL network.
{% endhint %}

{% hint style="warning" %}
If you run into a "ThinLinc login failed. (No agent server was available)" error, then login to the node with ssh. This will mount your home directory and resolve the ThinLinc error.\
![](../.gitbook/assets/image.png)
{% endhint %}

## Systems Availible

| Hostname                                       | URL                                                                      |
| ---------------------------------------------- | ------------------------------------------------------------------------ |
| [Firefly](https://firefly.ftpn.ornl.gov:300)   | [https://Firefly.ftpn.ornl.gov:300](https://firefly.ftpn.ornl.gov:300)   |
| [Intrepid](https://intrepid.ftpn.ornl.gov:300) | [https://Intrepid.ftpn.ornl.gov:300](https://intrepid.ftpn.ornl.gov:300) |
| [Tardis](https://tardis.ftpn.ornl.gov:300)     | [https://Tardis.ftpn.ornl.gov:300](https://tardis.ftpn.ornl.gov:300)     |
| [Polarden](https://polarden.ftpn.ornl.gov:300) | [https://Polarden.ftpn.ornl.gov:300](https://polarden.ftpn.ornl.gov:300) |
| [Zenith](https://zenith.ftpn.ornl.gov:300)     | [https://Zenith.ftpn.ornl.gov:300](https://zenith.ftpn.ornl.gov:300)     |
| [Zenith2](https://zenith2.ftpn.ornl.gov:300)     | [https://Zenith2.ftpn.ornl.gov:300](https://zenith2.ftpn.ornl.gov:300)     |
| [Lewis](https://lewis.ftpn.ornl.gov:300)       | [https://Lewis.ftpn.ornl.gov:300](https://lewis.ftpn.ornl.gov:300)       |
| [Clark](https://clark.ftpn.ornl.gov:300)       | [https://Clark.ftpn.ornl.gov:300](https://clark.ftpn.ornl.gov:300)       |
| [Pcie](https://pcie.ftpn.ornl.gov:300)         | [https://Pcie.ftpn.ornl.gov:300](https://pcie.ftpn.ornl.gov:300)         |
| [Aries](https://aries.ftpn.ornl.gov:300)       | [https://Aries.ftpn.ornl.gov:300](https://aries.ftpn.ornl.gov:300)       |
| [Bonsai](https://bonsai.ftpn.ornl.gov:300)     | [https://Bonsai.ftpn.ornl.gov:300](https://bonsai.ftpn.ornl.gov:300)     |
| [Hudson](https://hudson.ftpn.ornl.gov:300)     | [https://Hudson.ftpn.ornl.gov:300](https://hudson.ftpn.ornl.gov:300)     |

{% hint style="info" %}
The URL will only work once the SOCKS proxy is set up.\
[FoxyProxy](https://docs.excl.ornl.gov/quick-start-guides/excl-remote-development#setup-foxyproxy) can be used to automatically set up SOCKS proxy forwarding.
{% endhint %}

## Accessing ThinLinc through the web interface

1. [Setup FoxyProxy](https://docs.excl.ornl.gov/quick-start-guides/excl-remote-development#setup-foxyproxy) and make sure to have the SOCKS dynamic proxy running.
2. Connect to the ThinLinc server using the links above.

## Accessing ThinLinc through ThinLinc Client

This approach is recommended if you need better keyboard forwarding support for keyboard shortcuts that are not working with the Web client. The web client approach is easier to use and enables connecting to multiple systems at a time.

If the system is directly accessible (for example login.excl.ornl.gov), then you can specify the system and connect directly.

If the system is an internal node, then local port forwarding must be used. The steps to setting this up are as follows.

1. Forward port 22 from the remote system to your local system through login. On Linux or macOS

    ```
     $ ssh -L <localport>:<hostname>:22 <Username>@login.excl.ornl.gov
    ```

    On windows use ssh via powershell, MobaSSHTunnel, Visual Studio Code, or putty to forward port 22. See [Jupyter Quickstart](jupyter-quick-start.md) for more information on port forwarding in windows.
2. Add alias in hosts file for the remote node. This is needed because of how ThinLinc establishes the remote connected. On Linux this host file is `/etc/hosts`. On windows the file is `C:\Windows\System32\drivers\etc\hosts`.
   Host file:
    ```
    127.0.0.1 <hostname>
    ::1       <hostname>
    ```
3. Launch the ThinLinc Client.
4. In the options, specify the SSH port to be `<localport>`.
5. Specify the Server, Username, and credentials.
6. Connect to the server with "Connect".

## Potential Issues you may encounter

If you use Gnome and do not have access to the module command when you start a terminal session over ThinLinc web, then your terminal session may not be configured as a login session. To resolve

1. Right click on the terminal icon on the left side of your screen
2. In Preferences -> Unnamed, make sure `Run command as a login shell` is checked.

You will then get login processing (including sourcing the /etc/profiles.d files) and so the module command will now be present.
