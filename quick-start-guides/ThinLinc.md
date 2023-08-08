---
description: Getting started with ThinLinc.
---

# ThinLinc

The login node has [ThinLinc](https://www.cendio.com/thinlinc/what-is-thinlinc) install and can be accessed at [https://login.excl.ornl.gov:300](https://login.excl.ornl.gov:300). Since this node is public facing, it is the easiest to access with ThinLinc.

In addition to the login node, multiple systems including the [virtual systems](vitis.md#virtual-systems) have [ThinLinc](https://www.cendio.com/thinlinc/what-is-thinlinc) installed, which makes it easier to run graphical applications. To access ThinLinc you need to use as socks proxy to forward traffic to the ExCL network or port forwarding of port 22 to use the ThinLinc client.

For better keyboard shortcut support and to prevent the browser from triggering the shortcuts, I recommend installing [Open-as-Popup](https://chrome.google.com/webstore/detail/open-as-popup/ncppfjladdkdaemaghochfikpmghbcpc).

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
| [Lewis](https://lewis.ftpn.ornl.gov:300)       | [https://Lewis.ftpn.ornl.gov:300](https://lewis.ftpn.ornl.gov:300)       |
| [Clark](https://clark.ftpn.ornl.gov:300)       | [https://Clark.ftpn.ornl.gov:300](https://clark.ftpn.ornl.gov:300)       |
| [Pcie](https://pcie.ftpn.ornl.gov:300)         | [https://Pcie.ftpn.ornl.gov:300](https://pcie.ftpn.ornl.gov:300)         |
| [Aries](https://aries.ftpn.ornl.gov:300)       | [https://Aries.ftpn.ornl.gov:300](https://aries.ftpn.ornl.gov:300)       |
| [Bonsai](https://bonsai.ftpn.ornl.gov:300)     | [https://Bonsai.ftpn.ornl.gov:300](https://bonsai.ftpn.ornl.gov:300)     |

{% hint style="info" %}
The URL will only work once the SOCKS proxy is set up.\
FoxyProxy can be used to automatically set up SOCKS proxy forwarding.
{% endhint %}

## Accessing ThinLinc through the web interface

1.  Launch SOCKS dynamic proxy forwarding to the login node.\
    On Linux or macOS, for example

    ```
     $ ssh -D 9090 <Username>@login.excl.ornl.gov
    ```

    or in the ssh config add

    ```
    DynamicForward 9090
    ```

    On windows use MobaSSHTunnel to setup Dynamic Forwarding. See [Jupyter Quickstart](jupyter-quick-start.md) for more information on port forwarding in windows.
2.  Setup FoxyProxy\
    Install the FoxyProxy [Chrome extension](https://chrome.google.com/webstore/detail/foxyproxy-standard/gcknhkkoolaabfmlnjonogaaifnjlfnp) or [Firefox extension](https://addons.mozilla.org/en-US/firefox/addon/foxyproxy-standard/).

    Setup FoxyProxy by adding a new proxy for localhost on port 9090. Then add the regular expression URL pattern `.*\.ftpn\.ornl\.gov` to forward ThinLinc traffic to ExCL.
3. Connect to the ThinLinc server using the links above.

## Accessing ThinLinc through ThinLinc Client

This approach is not as recommended as you can't forward a privileged port (i.e., 22) if you are running an ssh server. Also this approach no longer works to access internal nodes. You can still use the client to connect to the login node, but not internal nodes.

1.  Forward port 22 from the remote system to your local system through login. On Linux or macOS

    ```
     $ ssh -L 22:<hostname>:22 <Username>@login.excl.ornl.gov
    ```

    On windows use MobaSSHTunnel or Visual Studio Code to forward port 22. See [Jupyter Quickstart](jupyter-quick-start.md) for more information on port forwarding in windows.
2. Launch the ThinLinc Client.
3. Connect to the server with "Connect".

## Potential Issues you may encounter

If you use Gnome and do not have access to the module command when you start a terminal session over ThinLinc web, then your terminal session may not be configured as a login session. To resolve

1. Right click on the terminal icon on the left side of your screen
2. In Preferences -> Unnamed, make sure `Run command as a login shell` is checked.

You will then get login processing (including sourcing the /etc/profiles.d files) and so the module command will now be present.
