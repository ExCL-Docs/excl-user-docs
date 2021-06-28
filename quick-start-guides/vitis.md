# Vitis FPGA Development

[ExCl](https://docs.excl.ornl.gov) → [User Documentation](../) → [Vitis FPGA Development](vitis.md)

## Vitis Development Tools

This page covers how to access the Vitis development tools available in ExCL. The available FPGAs are listed in section [FPGAs](vitis.md#fpgas). The available systems with the Vitis toolchain installed are listed in section [Systems with the Vitis Toolchain](vitis.md#systems-with-the-vitis-toolchain). See [Quickstart](vitis.md#quickstart) to get started. The [virtual systems](vitis.md#virtual-systems) have [ThinLinc](https://www.cendio.com/thinlinc/what-is-thinlinc) installed, which makes it easier to run graphical applications. See section [Accessing ThinLinc](vitis.md#accessing-thinlinc) to get started.

### FPGAs

| FPGA | Host System |
| :--- | :--- |
| [Alveo U250](https://www.xilinx.com/products/boards-and-kits/alveo/u250.html) | pcie |

### Systems with the Vitis Toolchain

#### Physical Systems

| Name | Tool Chain | Source File | Platform Name |
| :--- | :--- | :--- | :--- |
| pcie | Vitis 2020.1 | ~7ry/vitis-2020.1.source | xilinx\_u250\_xdma\_201830\_2 |

#### Virtual Systems

| Name | Tool Chain | Host | Source File | Platform Name |
| :--- | :--- | :--- | :--- | :--- |
| tardis | Vitis 2020.1 | pcie | ~7ry/vitis-tardis.source | xilinx\_u250\_xdma\_201830\_2 |
| firefly | Vitis 2020.2 | pcie | ~7ry/vitis-2020.2.source | xilinx\_u250\_gen3x16\_xdma\_3\_1\_202020\_1 |
| serenity | Vitis 2020.2 | justify | ~7ry/vitis-2020.2.source | xilinx\_u250\_gen3x16\_xdma\_3\_1\_202020\_1 |

### Quickstart

1. Log in to a system with the Vitis toolchain from the login node. See [Systems](vitis.md#systems-with-the-vitis-toolchain). For example `ssh pcie`.
2. Source the `Source File` in the system table to load the correct Vitis toolchain environment variables. For example `$ source ~7ry/vitis-2020.1.source`.
3. To run on hardware, contact Aaron Young.

### Accessing ThinLinc

The [virtual systems](vitis.md#virtual-systems) have [ThinLinc](https://www.cendio.com/thinlinc/what-is-thinlinc) installed, which makes it easier to run graphical applications. To access ThinLinc you need to use port forwarding to forward the ThinLinc ports. The ThinLinc web interface uses port 3000 and the ThinLinc client uses port 22.

#### Accessing ThinLinc through the web interface

1. Forward port 3000 from the VM to your local system through login.  
   On Linux or macOS

   ```text
    $ ssh -L 3000:<VM Name>:3000 <Username>@login.excl.ornl.gov
   ```

   On windows use MobaSSHTunnel or Visual Studio Code to forward port 3000. See [Jupyter Quickstart](jupyter-quick-start.md) for more information on port forwarding in windows.

2. Connect the forwarded port using a web browser. `https://localhost:3000`

#### Accessing ThinLinc through ThinLinc Client

This approach is not as recommended as you can't forward 22 if you are running an ssh server.

1. Forward port 22 from the VM to your local system through login. On Linux or macOS

   ```text
    $ ssh -L 22:<VM Name>:22 <Username>@login.excl.ornl.gov
   ```

   On windows use MobaSSHTunnel or Visual Studio Code to forward port 22. See [Jupyter Quickstart](jupyter-quick-start.md) for more information on port forwarding in windows.

2. Launch the ThinLinc Client.
3. Connect to the server with "Connect".

