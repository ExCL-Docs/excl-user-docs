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

1. Follow the [quickstart ](vitis.md#quickstart)to set up the [Vitis Environment](vitis.md#setting-up-the-vitis-environment).
2. Go through the [Vitis Getting Started Tutorials](https://github.com/Xilinx/Vitis-Tutorials/tree/master/Getting_Started).
3. Go through the [Vitis Hardware Accelerators Tutorials](https://github.com/Xilinx/Vitis-Tutorials/tree/master/Hardware_Accelerators).

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

## Building and Running FPGA Applications

Xilinx FPGA projects can be built using the [Vitis Compiler](https://www.xilinx.com/html_docs/xilinx2020_2/vitis_doc/buildingdevicebinary.html#ariaid-title2), the Vitis GUI, [Vitis HLS](https://www.xilinx.com/html_docs/xilinx2020_2/vitis_doc/buildingdevicebinary.html#xkj1541628747515), or [Vivado](https://www.xilinx.com/html_docs/xilinx2020_2/vitis_doc/buildingdevicebinary.html#ariaid-title6).

In general, I recommend using the Vitis compiler via the command line and scripts, because the workflow is easy to document, store in git, and run with GitLab CI. I recommend using Vitis HLS when trying to optimize kernel since it provides many profiling tools. See [Vitis HLS Tutorial](https://github.com/Xilinx/Vitis-Tutorials/blob/master/Getting_Started/Vitis_HLS/synth_and_analysis.md).

[Tutorials are available to learn how to use Vitis.](https://github.com/Xilinx/Vitis-Tutorials)

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

{% hint style="info" %}
TIP: Set up the command shell or window as described in [Vitis FPGA Development](vitis.md#setting-up-the-vitis-environment) prior to running the tools.
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
Note: In the [Vitis Examples](https://github.com/Xilinx/Vitis_Accel_Examples) you may see the addition of xcl2.cpp source file, and the `-I../libs/xcl2` include statement. These additions to the host program and `g++` command provide access to helper utilities used by the example code, but are generally not required for your own code.
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
TIP: The `v++` command can be used from the command line, in scripts, or a build system like `make`, and can also be used through the Vitis IDE as discussed in [Using the Vitis IDE](https://www.xilinx.com/html_docs/xilinx2020_2/vitis_doc/won1553474198838.html).
{% endhint %}

**See the** [**Vitis Documentation**](https://www.xilinx.com/html_docs/xilinx2020_2/vitis_doc/buildingdevicebinary.html#tvy1528754367816) **for more information.**

### **Analyzing the Build Results**

 The Vitis™ analyzer is a graphical utility that allows you to view and analyze the reports generated while building and running the application. It is intended to let you review reports generated by both the Vitis compiler when the application is built, and the Xilinx® Runtime \(XRT\) library when the application is run. The Vitis analyzer can be used to view reports from both the `v++` command line flow, and the Vitis integrated design environment \(IDE\). You will launch the tool using the `vitis_analyzer` command \(see [Vitis FPGA Development](vitis.md#setting-up-the-vitis-environment)\).

**See the** [**Vitis Documentation**](https://www.xilinx.com/html_docs/xilinx2020_2/vitis_doc/jfn1567005096685.html) **for more information.**

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







