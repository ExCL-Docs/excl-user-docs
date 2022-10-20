---
description: Getting started with ThinLinc.
---
# Accessing ThinLinc

The login node has [ThinLinc](https://www.cendio.com/thinlinc/what-is-thinlinc) install and can be accessed at <https://login.excl.ornl.gov:300>. Since this node is public facing, it is the easiest to access with ThinLinc.

In addition to the login node, multiple systems including the [virtual systems](vitis.md#virtual-systems) have [ThinLinc](https://www.cendio.com/thinlinc/what-is-thinlinc) installed, which makes it easier to run graphical applications. To access ThinLinc you need to use port forwarding to forward the ThinLinc ports. The ThinLinc web interface uses the port in the table below and the ThinLinc client uses port 22.

## Ports Used

| Hostname | Port |
|----------|------|
| Firefly  | 3200 |
| Intrepid | 3201 |
| Tardis   | 3202 |
| Polarden | 3203 |
| Zenith   | 3204 |
| Lewis    | 3205 |
| Clerk    | 3206 |
| pcie     | 3207 |

## Accessing ThinLinc through the web interface

1.  Forward port 3200 from the VM to your local system through login.\
    On Linux or macOS

    ```
     $ ssh -L 3200:<VM Name>:3200 <Username>@login.excl.ornl.gov
    ```

    On windows use MobaSSHTunnel or Visual Studio Code to forward port 3200. See [Jupyter Quickstart](jupyter-quick-start.md) for more information on port forwarding in windows.
2. Connect the forwarded port using a web browser. `https://localhost:3200`

## Accessing ThinLinc through ThinLinc Client

This approach is not as recommended as you can't forward 22 if you are running an ssh server.

1.  Forward port 22 from the VM to your local system through login. On Linux or macOS

    ```
     $ ssh -L 22:<VM Name>:22 <Username>@login.excl.ornl.gov
    ```

    On windows use MobaSSHTunnel or Visual Studio Code to forward port 22. See [Jupyter Quickstart](jupyter-quick-start.md) for more information on port forwarding in windows.
2. Launch the ThinLinc Client.
3. Connect to the server with "Connect".