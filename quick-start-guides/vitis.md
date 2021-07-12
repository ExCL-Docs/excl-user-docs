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
| torchwood | Vitis 2020.1 | justify | ~7ry/vitis-tardis.source | xilinx\_u250\_xdma\_201830\_2 |
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

### Using Vitis with the [Fish Shell](https://fishshell.com/)

To use the Vitis toolchain with the fish shell, create the file `~/.config/fish/functions/vitis_init.fish` with the following content. Then to initialize Vitis, you run the `vitis_init` function. This function will find the latest Vitis version installed on the system and setup its environment. \(Note: systems should only have one Vitis version installed.\)

```text
function vitis_init --description 'Setup Vitis paths'

   # Find the latest installed Vitis version as a default.
   if test -e /tools/Xilinx/Vitis
      set xilinx_version (ls /tools/Xilinx/Vitis | sort -r | head -n 1)
      set base tools
   else if test -e /opt/Xilinx/Vitis
      set xilinx_version (ls /opt/Xilinx/Vitis | sort -r | head -n 1)
      set base opt
   else
      echo "Could not find vitis installation"
      return 1
   end

   # Try to override Vitis version
   if test (count $argv) -eq 1
      set xilinx_version $argv[1]
   end

   echo "Initializing Vivado $xilinx_version in base /$base"

   # SDK
   # set -gx PATH /opt/Xilinx/SDK/$xilinx_version/bin /opt/Xilinx/SDK/$xilinx_version/gnu/microblaze/lin/bin /opt/Xilinx/SDK/$xilinx_version/gnu/arm/lin/bin /opt/Xilinx/SDK/$xilinx_version/gnu/microblaze/linux_toolchain/lin64_be/bin /opt/Xilinx/SDK/$xilinx_version/gnu/microblaze/linux_toolchain/lin64_le/bin /opt/Xilinx/SDK/$xilinx_version/gnu/aarch32/lin/gcc-arm-linux-gnueabi/bin /opt/Xilinx/SDK/$xilinx_version/gnu/aarch32/lin/gcc-arm-none-eabi/bin /opt/Xilinx/SDK/$xilinx_version/gnu/aarch64/lin/aarch64-linux/bin /opt/Xilinx/SDK/$xilinx_version/gnu/aarch64/lin/aarch64-none/bin /opt/Xilinx/SDK/$xilinx_version/gnu/armr5/lin/gcc-arm-none-eabi/bin /opt/Xilinx/SDK/$xilinx_version/tps/lnx64/cmake-3.3.2/bin $PATH

   # XRT
   set -gx XILINX_XRT /opt/xilinx/xrt
   set -gx LD_LIBRARY_PATH $XILINX_XRT/lib $LD_LIBRARY_PATH
   set -gx PATH $XILINX_XRT/bin $PATH
   set -gx PYTHONPATH $XILINX_XRT/python $PYTHONPATH

   # DocNav
   set -gx PATH /$base/Xilinx/DocNav $PATH

   # Vitis_HLS
   set -gx XILINX_HLS /$base/Xilinx/Vitis_HLS/$xilinx_version
   set -gx PATH /$base/Xilinx/Vitis_HLS/$xilinx_version/bin $PATH

   # Vivado
   set -gx PATH /$base/Xilinx/Vivado/$xilinx_version/bin $PATH

   # Vitis
   set -gx XILINX_VITIS /$base/Xilinx/Vitis/$xilinx_version
   set -gx PATH /$base/Xilinx/Vitis/$xilinx_version/bin /$base/Xilinx/Vitis/$xilinx_version/gnu/microblaze/lin/bin /$base/Xilinx/Vitis/$xilinx_version/gnu/arm/lin/bin /$base/Xilinx/Vitis/$xilinx_version/gnu/microblaze/linux_toolchain/lin64_le/bin /$base/Xilinx/Vitis/$xilinx_version/gnu/aarch32/lin/gcc-arm-linux-gnueabi/bin /$base/Xilinx/Vitis/$xilinx_version/gnu/aarch32/lin/gcc-arm-none-eabi/bin /$base/Xilinx/Vitis/$xilinx_version/gnu/aarch64/lin/aarch64-linux/bin /$base/Xilinx/Vitis/$xilinx_version/gnu/aarch64/lin/aarch64-none/bin /$base/Xilinx/Vitis/$xilinx_version/gnu/armr5/lin/gcc-arm-none-eabi/bin /$base/Xilinx/Vitis/$xilinx_version/tps/lnx64/cmake-3.3.2/bin /$base/Xilinx/Vitis/$xilinx_version/aietools/bin $PATH

   # Model_Composer
   set -gx PATH /$base/Xilinx/Model_Composer/2020.2/bin $PATH

   # Set Platform Repo Paths
   if test -e /opt/xilinx/platforms/xilinx_u250_gen3x16_xdma_3_1_202020_1/
      set -gx PLATFORM_REPO_PATHS /opt/xilinx/platforms/xilinx_u250_gen3x16_xdma_3_1_202020_1/
   else if test -e /opt/xilinx/platforms/xilinx_u250_xdma_201830_2/
      set -gx PLATFORM_REPO_PATHS /opt/xilinx/platforms/xilinx_u250_xdma_201830_2/
   end

   # Set Library Paths
   export LD_LIBRARY_PATH=/$base/Xilinx/Vitis/$xilinx_version/lib/lnx64.o:$LD_LIBRARY_PATH
end
```

