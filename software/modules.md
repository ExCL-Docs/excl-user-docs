---
description: Getting Started with Modules.
---
# Using Modules in ExCL

ExCL uses **Modules** to manage software environments efficiently. Modules allow users to load, unload, and switch between different software versions without modifying system paths manually. Please let us know if there is a software package you would like us to make available via a module.

## Loading a Module

To load a specific software module:

```bash
module load <module_name>
```

Example:

```bash
module load python/3.9
```

This makes Python 3.9 available for use.

You can also leave off the version number to load the default version.

Example:

```bash
module load python
```

## Listing Available Modules

To see all available modules:

```bash
module avail
```

## Checking Loaded Modules

To view currently loaded modules:

```bash
module list
```

## Unloading a Module

To remove a specific module:

```bash
module unload <module_name>
```

Example:

```bash
module unload python/3.9
```

## Switching Between Versions

To switch from one module version to another:

```bash
module swap <old_module> <new_module>
```

Example:

```bash
module swap gcc/9.3 gcc/10.2
```

## Resetting the Environment

To clear all loaded modules and reset to the default environment:

```bash
module purge
```

## ExCL-Utils

The `excl-utils` module contains common Rust CLI utilities. Load the module to see an updated list of the installed utilities. Additional Rust CLI utilities can be requested to be included in the module. These utilities are updated to the latest versions nightly.
