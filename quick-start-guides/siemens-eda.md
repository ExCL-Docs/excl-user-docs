---
description: Getting Started with Siemens EDA Tools.
---

# Siemens EDA

The EDA tools are installed on the system `dragon`. `dragon` can be access via ssh from the `login` node, via x11 forwarding from the login node's ThinLink, or directly via ThinLink with Foxy Proxy. See [ThinLinc Quickstart](ThinLinc.md) to get started with ThinLinc Setup. See [Accessing ExCL](../excl-support/access.md) for more details on logging in.

Ssh access:

```bash
ssh login.excl.ornl.gov
```

ThinLinc access to login:

[https://login.excl.ornl.gov:300](https://login.excl.ornl.gov:300)

ThinLinc access to dragon (Requires reverse proxy to be setup):

[https://dragon.ftpn.ornl.gov:300](https://dragon.ftpn.ornl.gov:300)

All of the tools are installed to `/opt/Siemens` and the tools can be set up with

```bash
source /opt/Siemens/setup.sh
```

Also, please join the `siemens-eda` slack channel in the ORNL CCSD slack.
