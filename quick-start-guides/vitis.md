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

### First Steps

1. Follow the [quickstart](vitis.md#quickstart) to set up the [Setting Up the Vitis Environment](vitis.md#setting-up-the-vitis-environment).
2. Go through the [Vitis Getting Started Tutorials](https://github.com/Xilinx/Vitis-Tutorials/tree/master/Getting_Started).
3. Go through the [Vitis Hardware Accelerators Tutorials](https://github.com/Xilinx/Vitis-Tutorials/tree/master/Hardware_Accelerators).
4. Go through the [Vitis Accel Examples](https://github.com/Xilinx/Vitis_Accel_Examples).

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

To use the Vitis toolchain with the fish shell, create the file `~/.config/fish/functions/vitis_init.fish` with the following content. Then to initialize Vitis, you run the `vitis_init` function. This function will find the latest Vitis version installed on the system and set up its environment. \(Note: systems should only have one Vitis version installed.\)

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

## Building and Running FPGA Applications

Xilinx FPGA projects can be built using the [Vitis Compiler](https://www.xilinx.com/html_docs/xilinx2020_2/vitis_doc/buildingdevicebinary.html#ariaid-title2), the Vitis GUI, [Vitis HLS](https://www.xilinx.com/html_docs/xilinx2020_2/vitis_doc/buildingdevicebinary.html#xkj1541628747515), or [Vivado](https://www.xilinx.com/html_docs/xilinx2020_2/vitis_doc/buildingdevicebinary.html#ariaid-title6).

In general, I recommend using the Vitis compiler via the command line and scripts, because the workflow is easy to document, store in git, and run with GitLab CI. I recommend using Vitis HLS when trying to optimize kernel since it provides many profiling tools. See [Vitis HLS Tutorial](https://github.com/Xilinx/Vitis-Tutorials/blob/master/Getting_Started/Vitis_HLS/synth_and_analysis.md).

[Tutorials are available to learn how to use Vitis.](https://github.com/Xilinx/Vitis-Tutorials) In particular, this [Getting started with Vitis Tutorial](https://github.com/Xilinx/Vitis-Tutorials/blob/master/Getting_Started/Vitis/Part4.md) goes over the building and running of an example application.

**See the** [**Vitis Documentation**](https://www.xilinx.com/html_docs/xilinx2020_2/vitis_doc/xia1553473418160.html) **for more details on building and running FPGA applications.**

### Setting up the Vitis Environment

Vitis source scripts are provided for ExCL which are set up for the particular machine. Source corresponding `Source File` in the system table to load the correct Vitis toolchain environment variables. For example using the Bash:

```bash
source ~7ry/vitis-2020.2.source
```

If you want to use fish instead of bash, then see [Vitis FPGA Development](vitis.md#using-vitis-with-the-fish-shell).

**See the** [**Vitis Documentation**](https://www.xilinx.com/html_docs/xilinx2020_2/vitis_doc/settingupvitisenvironment.html#zks1565446519267) **for more details on setting up the Vitis Environment.**

### Build Targets

There are three build targets available when building an FPGA kernel with Vitis tools.

**See the** [**Vitis Documentation**](https://www.xilinx.com/html_docs/xilinx2020_2/vitis_doc/buildtargets1.html#rst1525720251890) **for more information.**

| Software Emulation | Hardware Emulation | Hardware Execution |
| :--- | :--- | :--- |
| Host application runs with a C/C++ or OpenCL™ model of the kernels. | Host application runs with a simulated RTL model of the kernels. | Host application runs with actual hardware implementation of the kernels. |
| Used to confirm functional correctness of the system. | Test the host / kernel integration, get performance estimates. | Confirm that the system runs correctly and with desired performance. |
| Fastest build time supports quick design iterations. | Best debug capabilities, moderate compilation time with increased visibility of the kernels. | Final FPGA implementation, long build time with accurate \(actual\) performance results. |

The designed build target is specified with the `-t` flag with `v++`.

### Building the Host Program

The host program can be written using either the native XRT API or OpenCL API calls, and it is compiled using the GNU C++ compiler \(`g++`\). Each source file is compiled to an object file \(`.o`\) and linked with the Xilinx runtime \(XRT\) shared library to create the executable which runs on the host CPU.

**See the** [**Vitis Documentation**](https://www.xilinx.com/html_docs/xilinx2020_2/vitis_doc/buildinghostprogram.html#asy1528754332783) **for more information.**

#### Compiling and Linking for x86

{% hint style="danger" %}
**Important:** Set up the command shell or window as described in [Setting Up the Vitis Environment](vitis.md#setting-up-the-vitis-environment) prior to running the tools.
{% endhint %}

Each source file of the host application is compiled into an object file \(.o\) using the `g++` compiler.

```bash
g++ ... -c <source_file1> <source_file2> ... <source_fileN>
```

The generated object files \(.o\) are linked with the Xilinx Runtime \(XRT\) shared library to create the executable host program. Linking is performed using the `-l` option.

```bash
g++ ... -l <object_file1.o> ... <object_fileN.o>
```

Compiling and linking for x86 follows the standard `g++` flow. The only requirement is to include the XRT header files and link the XRT shared libraries.

When compiling the source code, the following `g++` options are required:

* `-I$XILINX_XRT/include/`: XRT include directory.
* `-I$XILINX_VIVADO/include`: Vivado tools include directory.
* `-std=c++11`: Define the C++ language standard.

When linking the executable, the following g++ options are required:

* `-L$XILINX_XRT/lib/`: Look in XRT library.
* `-lOpenCL`: Search the named library during linking.
* `-lpthread`: Search the named library during linking.
* `-lrt`: Search the named library during linking.
* `-lstdc++`: Search the named library during linking.

{% hint style="info" %}
**Note:** In the [Vitis Examples](https://github.com/Xilinx/Vitis_Accel_Examples) you may see the addition of xcl2.cpp source file, and the `-I../libs/xcl2` include statement. These additions to the host program and `g++` command provide access to helper utilities used by the example code, but are generally not required for your own code.
{% endhint %}

### Building the Device Binary

The kernel code is written in C, C++, OpenCL™ C, or RTL, and is built by compiling the kernel code into a Xilinx® object \(XO\) file, and linking the XO files into a device binary \(XCLBIN\) file, as shown in the following figure.

![Vitis Build Process](../.gitbook/assets/vitis-build-process.png)

The process, as outlined above, has two steps:

1. Build the Xilinx object files from the kernel source code.
   * For C, C++, or OpenCL kernels, the `v++ -c` command compiles the source code into Xilinx object \(XO\) files. Multiple kernels are compiled into separate XO files.
   * For RTL kernels, the `package_xo` command produces the XO file to be used for linking. Refer to [RTL Kernels](https://www.xilinx.com/html_docs/xilinx2020_2/vitis_doc/devrtlkernel.html#qnk1504034323350) for more information.
   * You can also create kernel object \(XO\) files working directly in the Vitis™ HLS tool. Refer to [Compiling Kernels with the Vitis HLS](https://www.xilinx.com/html_docs/xilinx2020_2/vitis_doc/buildingdevicebinary.html#yzy1565965133810) for more information.
2. After compilation, the `v++ -l` command links one or multiple kernel objects \(XO\), together with the hardware platform XSA file, to produce the device binary XCLBIN file.

{% hint style="info" %}
**TIP:** The `v++` command can be used from the command line, in scripts, or a build system like `make`, and can also be used through the Vitis IDE as discussed in [Using the Vitis IDE](https://www.xilinx.com/html_docs/xilinx2020_2/vitis_doc/won1553474198838.html).
{% endhint %}

{% hint style="info" %}
**TIP:** The output directories of `v++` can be changed. See [Vitis Documentation](https://www.xilinx.com/html_docs/xilinx2020_2/vitis_doc/rol1532064542594.html). This is particularly helpful when you want to build multiple versions of the kernel in the same file structure. The [makefile example](vitis.md#example-makefile) shows an example of how to do this.
{% endhint %}

**See the** [**Vitis Documentation**](https://www.xilinx.com/html_docs/xilinx2020_2/vitis_doc/buildingdevicebinary.html#tvy1528754367816) **for more information.**

#### Compiling Kernels with the Vitis Compiler

{% hint style="danger" %}
**Important:** Set up the command shell or window as described in [Setting Up the Vitis Environment](vitis.md#setting-up-the-vitis-environment) prior to running the tools.
{% endhint %}

The first stage in building the xclbin file is to compile the kernel code using the Xilinx Vitis compiler. There are multiple `v++` options that need to be used to correctly compile your kernel. The following is an example command line to compile the `vadd` kernel:

```text
v++ -t sw_emu --platform xilinx_u200_xdma_201830_2 -c -k vadd \
-I'./src' -o'vadd.sw_emu.xo' ./src/vadd.cpp
```

The various arguments used are described below. Note that some of the arguments are required.

* `-t <arg>`: Specifies the build target, as discussed in [Build Targets](https://www.xilinx.com/html_docs/xilinx2020_2/vitis_doc/buildtargets1.html#rst1525720251890). Software emulation \(`sw_emu`\) is used as an example. Optional. The default is hw.
* `--platform <arg>`: Specifies the accelerator platform for the build. This is required because runtime features, and the target platform are linked as part of the FPGA binary. To compile a kernel for an embedded processor application, specify an embedded processor platform: `--platform $PLATFORM_REPO_PATHS/zcu102_base/zcu102_base.xpfm`.
* `-c`: Compile the kernel. Required. The kernel must be compiled \(`-c`\) and linked \(`-l`\) in two separate steps.
* `-k <arg>`: Name of the kernel associated with the source files.
* `-o'<output>.xo'`: Specify the shared object file output by the compiler. Optional.
* `<source_file>`: Specify source files for the kernel. Multiple source files can be specified. Required.

The above list is a sample of the extensive options available. Refer to [Vitis Compiler Command](https://www.xilinx.com/html_docs/xilinx2020_2/vitis_doc/vitiscommandcompiler.html#wrj1504034328013) for details of the various command-line options. Refer to [Output Directories of the v++ Command](https://www.xilinx.com/html_docs/xilinx2020_2/vitis_doc/rol1532064542594.html) to get an understanding of the location of various output files.

#### Linking the Kernels

{% hint style="danger" %}
**Important:** Set up the command shell or window as described in [Setting Up the Vitis Environment](vitis.md#setting-up-the-vitis-environment) prior to running the tools.
{% endhint %}

The kernel compilation process results in a Xilinx object \(XO\) file whether the kernel is written in C/C++, OpenCL C, or RTL. During the linking stage, XO files from different kernels are linked with the platform to create the FPGA binary container file \(.xclbin\) used by the host program.

Similar to compiling, linking requires several options. The following is an example command line to link the `vadd` kernel binary:

```text
v++ -t sw_emu --platform xilinx_u200_xdma_201830_2 --link vadd.sw_emu.xo \
-o'vadd.sw_emu.xclbin' --config ./connectivity.cfg
```

This command contains the following arguments:

* `-t <arg>`: Specifies the build target. Software emulation \(`sw_emu`\) is used as an example. When linking, you must use the same `-t` and `--platform` arguments as specified when the input \(XO\) file was compiled.
* `--platform <arg>`: Specifies the platform to link the kernels with. To link the kernels for an embedded processor application, you simply specify an embedded processor platform: `--platform $PLATFORM_REPO_PATHS/zcu102_base/zcu102_base.xpfm`
* `--link`: Link the kernels and platform into an FPGA binary file \(xclbin\).
* `<input>.xo`: Input object file. Multiple object files can be specified to build into the .xclbin.
* `-o'<output>.xclbin'`: Specify the output file name. The output file in the link stage will be an .xclbin file. The default output name is a.xclbin
* `--config ./connectivity.cfg`: Specify a configuration file that is used to provide `v++` command options for a variety of uses. Refer to [Vitis Compiler Command](https://www.xilinx.com/html_docs/xilinx2020_2/vitis_doc/vitiscommandcompiler.html#wrj1504034328013) for more information on the `--config` option.

{% hint style="info" %}
**TIP:** Refer to [Output Directories of the v++ Command](https://www.xilinx.com/html_docs/xilinx2020_2/vitis_doc/rol1532064542594.html) to get an understanding of the location of various output files.
{% endhint %}

Beyond simply linking the Xilinx object \(XO\) files, the linking process is also where important architectural details are determined. In particular, this is where the number of compute unit \(CUs\) to instantiate into hardware is specified, connections from kernel ports to global memory are assigned, and CUs are assigned to SLRs. The following sections discuss some of these build options.

### **Analyzing the Build Results**

The Vitis™ analyzer is a graphical utility that allows you to view and analyze the reports generated while building and running the application. It is intended to let you review reports generated by both the Vitis compiler when the application is built, and the Xilinx® Runtime \(XRT\) library when the application is run. The Vitis analyzer can be used to view reports from both the `v++` command line flow, and the Vitis integrated design environment \(IDE\). You will launch the tool using the `vitis_analyzer` command \(see [Setting Up the Vitis Environment](vitis.md#setting-up-the-vitis-environment)\).

**See the** [**Vitis Documentation**](https://www.xilinx.com/html_docs/xilinx2020_2/vitis_doc/jfn1567005096685.html) **for more information.**

### **Running Emulation**

TLDR: Create an `emconfig.json` file using `emconfigutil` and set `XCL_EMULATION_MODE` to `sw_emu` or `hw_emu` before executing the host program. The device binary also has to be built for the corresponding target.

**See the** [**Vitis Documentation**](https://www.xilinx.com/html_docs/xilinx2020_2/vitis_doc/runemulation1.html#btg1600442263101) **for more information.**

#### Running Emulation on Data Center Accelerator Cards

{% hint style="danger" %}
**Important:** Set up the command shell or window as described in [Setting Up the Vitis Environment](vitis.md#setting-up-the-vitis-environment) prior to running the tools.
{% endhint %}

1. Set the desired runtime settings in the xrt.ini file. This step is optional.  


   As described in [xrt.ini File](https://www.xilinx.com/html_docs/xilinx2020_2/vitis_doc/obl1532064985142.html), the file specifies various parameters to control debugging, profiling, and message logging in XRT when running the host application and kernel execution. This enables the runtime to capture debugging and profile data as the application is running. The `Emulation` group in the xrt.ini provides features that affect your emulation run.   
  
   **TIP:** Be sure to use the `v++ -g` option when compiling your kernel code for emulation mode.  

2. Create an emconfig.json file from the target platform as described in [emconfigutil Utility](https://www.xilinx.com/html_docs/xilinx2020_2/vitis_doc/nrj1570599837825.html). This is required for running hardware or software emulation.  


   The emulation configuration file, `emconfig.json`, is generated from the specified platform using the `emconfigutil` command, and provides information used by the XRT library during emulation. The following example creates the `emconfig.json` file for the specified target platform:

   ```text
   emconfigutil --platform xilinx_u200_xdma_201830_2
   ```

   In emulation mode, the runtime looks for the emconfig.json file in the same directory as the host executable, and reads in the target configuration for the emulation runs.  
  
   **TIP:** It is mandatory to have an up-to-date JSON file for running emulation on your target platform.  

3. Set the `XCL_EMULATION_MODE` environment variable to `sw_emu` \(software emulation\) or `hw_emu` \(hardware emulation\) as appropriate. This changes the application execution to emulation mode.  


   Use the following syntax to set the environment variable for C shell \(csh\):

   ```text
   setenv XCL_EMULATION_MODE sw_emu
   ```

   Bash shell:

   ```text
   export  XCL_EMULATION_MODE=sw_emu
   ```

   **IMPORTANT:** The emulation targets will not run if the `XCL_EMULATION_MODE` environment variable is not properly set.  

4. Run the application.  


   With the runtime initialization file \(xrt.ini\), emulation configuration file \(emconfig.json\), and the `XCL_EMULATION_MODE` environment set, run the host executable with the desired command line argument.  
  
   **IMPORTANT:** The INI and JSON files must be in the same directory as the executable.  


   For example:

   ```text
   ./host.exe kernel.xclbin
   ```

   **TIP:** This command line assumes that the host program is written to take the name of the xclbin file as an argument, as most Vitis examples and tutorials do. However, your application may have the name of the xclbin file hard-coded into the host program, or may require a different approach to running the application.

### Running the Application Hardware Build

TLDR: Make sure `XCL_EMULATION_MODE`  is unset. Use a node with the FPGA hardware attached.

**See the** [**Vitis Documentation**](https://www.xilinx.com/html_docs/xilinx2020_2/vitis_doc/lwu1600468728254.html) **for more information.**

{% hint style="info" %}
**TIP:** To use the accelerator card, you must have it installed as described in Getting Started with Alveo Data Center Accelerator Cards \([UG1301](https://www.xilinx.com/cgi-bin/docs/bkdoc?v=latest;k=accelerator-cards;d=ug1301-getting-started-guide-alveo-accelerator-cards.pdf)\).
{% endhint %}

1. Edit the xrt.ini file as described in [xrt.ini File](https://www.xilinx.com/html_docs/xilinx2020_2/vitis_doc/obl1532064985142.html).  
   ****

   This is optional, but recommended when running on hardware for evaluation purposes. You can configure XRT with the xrt.ini file to capture debugging and profile data as the application is running. To capture event trace data when running the hardware, refer to [Enabling Profiling in Your Application](https://www.xilinx.com/html_docs/xilinx2020_2/vitis_doc/profilingapplication.html#vfc1586356138757). To debug the running hardware, refer to [Debugging During Hardware Execution](https://www.xilinx.com/html_docs/xilinx2020_2/vitis_doc/debuggingapplicationskernels.html#hsr1538574456889).  
  
   **TIP:** Ensure to use the `v++ -g` option when compiling your kernel code for debugging.  

2. Unset the `XCL_EMULATION_MODE` environment variable.  **IMPORTANT:** The hardware build will not run if the `XCL_EMULATION_MODE` environment variable is set to an emulation target. 
3. For embedded platforms, boot the SD card.  
  
   **TIP:** This step is only required for platforms using Xilinx embedded devices such as Versal ACAP or Zynq UltraScale+ MPSoC.  


   For an embedded processor platform, copy the contents of the ./sd\_card folder produced by the `v++ --package` command to an SD card as the boot device for your system. Boot your system from the SD card.  

4. Run your application.  


   The specific command line to run the application will depend on your host code. A common implementation used in Xilinx tutorials and examples is as follows:

   ```text
   ./host.exe kernel.xclbin
   ```

{% hint style="info" %}
**TIP:** This command line assumes that the host program is written to take the name of the xclbin file as an argument, as most Vitis examples and tutorials do. However, your application can have the name of the xclbin file hard-coded into the host program, or can require a different approach to running the application.
{% endhint %}

### Example Makefile

A simple example Vitis project is available at [https://code.ornl.gov/7ry/add\_test](https://code.ornl.gov/7ry/add_test). This project can be used to test the Vitis compile chain and [Vitis HLS](https://www.xilinx.com/html_docs/xilinx2020_2/vitis_doc/gnq1597858079367.html)

The [makefile](https://code.ornl.gov/7ry/add_test/-/blob/main/Makefile) used by this project is an example of how to create a makefile to build an FPGA accelerated application.

```bash
HW_TARGET ?= sw_emu # [sw_emu, hw_emu, hw]
LANGUAGE ?= opencl # [opencl, xilinx]
VERSION ?= 1 # [1, 2, 3]

#HWC stands for hardware compiler
HWC = v++
TMP_DIR = _x/$(HW_TARGET)/$(LANGUAGE)/$(VERSION)
src_files = main_xilinx.cpp cv_opencl.cpp double_add.cpp
hpp_files = cv_opencl.hpp double_add.hpp
KERNEL_SRC = kernels/add_kernel_v$(VERSION).cl
COMPUTE_ADD_XO = $(HW_TARGET)/$(LANGUAGE)/xo/add_kernel_v$(VERSION).xo
XCLBIN_FILE = $(HW_TARGET)/$(LANGUAGE)/add_kernel_v$(VERSION).xclbin

ifeq ($(LANGUAGE), opencl)
    KERNEL_SRC = kernels/add_kernel_v$(VERSION).cl
else
    KERNEL_SRC = kernels/add_kernel_v$(VERSION).cpp
endif

.PHONY: all kernel
all: double_add emconfig.json $(XCLBIN_FILE)
build: $(COMPUTE_ADD_XO)
kernel: $(XCLBIN_FILE)

double_add: $(src_files) $(hpp_files)
    g++ -Wall -g -std=c++11 $(src_files) -o $@ -I../common_xlx/ \
    -I${XILINX_XRD}/include/ -L${XILINX_XRT}/lib/ -L../common_xlx -lOpenCL \
    -lpthread -lrt -lstdc++

emconfig.json:
    emconfigutil --platform xilinx_u250_gen3x16_xdma_3_1_202020_1 --nd 1

$(COMPUTE_ADD_XO): $(KERNEL_SRC)
    $(HWC) -c -t $(HW_TARGET) --kernel double_add --temp_dir $(TMP_DIR) \
    --config design.cfg -Ikernels -I. $< -o $@

$(XCLBIN_FILE): $(COMPUTE_ADD_XO)
    $(HWC) -l -t $(HW_TARGET) --temp_dir $(TMP_DIR) --config design.cfg \
    --connectivity.nk=double_add:1:csq_1 \
    $^ -I. -o $@

.PHONY: clean
clean:
    rm -rf double_add emconfig.json xo/ built/ sw_emu/ hw_emu/ hw/ _x *.log .Xil/
```

