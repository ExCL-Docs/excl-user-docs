---
description: Getting started with ExCL Remote Development.
---
# ExCL Remote Development

## Roadmap for Setup

If you are new to remote development on ExCL here is a roadmap to follow to set important settings and to get familiar with remote Linux development.

1. [Access ExCL](https://docs.excl.ornl.gov/excl-support/access)
2. Setup SSH: [SSH Keys for Authentication | ExCL User Docs](https://docs.excl.ornl.gov/software/git#ssh-keys-for-authentication)
    - Bonus: [SSH-Agent and SSH Forwarding](https://docs.excl.ornl.gov/software/git#ssh-agent-and-ssh-forwarding)
3. Setup Git
    1. [Git SSH Access | ExCL User Docs](https://docs.excl.ornl.gov/software/git#git-ssh-access)
    2. [Setup Git access to code.ornl.gov | ExCL User Docs](https://docs.excl.ornl.gov/software/git#setup-git-access-to-code.ornl.gov)
4. Setup VS Code Remote Explorer: [Visual Studio Code Remote Explorer | ExCL User Docs](https://docs.excl.ornl.gov/quick-start-guides/visual-studio-code#remote-explorer)
    - Important: Make sure to check the setting Remote.SSH: Lockfiles in Tmp.
5. [Setup FoxyProxy](https://docs.excl.ornl.gov/quick-start-guides/excl-remote-development#setup-foxyproxy). This enables access to [ThinLinc](https://docs.excl.ornl.gov/~/revisions/tgK4OWTltCS04RkJelGW/quick-start-guides/thinlinc) as well as any other web services running on ExCL systems.
6. Now you are ready to follow any of the other Quick-Start Guides.

## Setup FoxyProxy

1. Launch SOCKS dynamic proxy forwarding to the login node using dynamic forwarding with SSH.\
    On Linux or macOS, via the SSH flag `-D`

    ```
     $ ssh -D 9090 <Username>@login.excl.ornl.gov
    ```

    or in the ssh config add the `DynamicForward` option

    ```
    DynamicForward 9090
    ```

    On Windows, use MobaSSHTunnel to set up Dynamic Forwarding. See [Jupyter Quickstart](jupyter-quick-start.md) for more information on port forwarding in windows.
2. Setup FoxyProxy\
    Install the FoxyProxy [Chrome extension](https://chrome.google.com/webstore/detail/foxyproxy-standard/gcknhkkoolaabfmlnjonogaaifnjlfnp) or [Firefox extension](https://addons.mozilla.org/en-US/firefox/addon/foxyproxy-standard/).

    Setup FoxyProxy by adding a new proxy for localhost on port 9090. Then add the regular expression URL pattern `.*\.ftpn\.ornl\.gov.*` to forward ThinLinc traffic to ExCL. When available, make sure to check on the Proxy DNS option.

![Foxy Proxy Settings](/assets/foxyproxy-settings.png)

{% hint style="warning" %}
**Reminder**: You will need to re-do step 1 in [Setup FoxyProxy](https://docs.excl.ornl.gov/quick-start-guides/excl-remote-development#setup-foxyproxy) each time you want to connect to ExCL to form the Dynamic Proxy tunnel via SSH to the ExCL network.
{% endhint %}

{% hint style="warning" %}
**Note**: If you are on a Mac system, you will need to check on the proxy DNS setting for the ExCL proxy config.

![Foxy Proxy Proxy DNS Settings for Mac](/assets/foxyproxy-settings-mac.png)
{% endhint %}
