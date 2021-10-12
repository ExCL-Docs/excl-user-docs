# Compilers

Compilers are, in general, maintained from a central NFS repository, and made accessible via the module command (from Lmod). For example

```
quad03:~$ module load gnu
hsm@quad03:~$ module avail

-------------------- /auto/software/modules/x86_64/modulefiles ---------------------
   gnu/8.3.0          intel/system_studio_2019    pgi/pgi-nollvm
   gnu/9.1.0 (L,D)    pgi/pgi-llvm                pgi/pgi/19.4

---------------------- /usr/share/lmod/lmod/modulefiles/Core -----------------------
   lmod    settarg

  Where:
   L:  Module is loaded
   D:  Default Module
```

If you do not load a module, you will get the default compiler as delivered by the operating system vendor (4.8.5 on some systems). If you `module load gnu` you will currently get 9.1.0, as it is the default. If you need 8.3.0, you need to `module load gnu/8.3.0`. Note that documentation details with respect to compiler availability and versions will not necessarily be kept up to date; the system itself is authoritative.

Some compilers (notably xlc) cannot be installed on nfs, so if they are availble they will show up in a different module directory. The same module commands can be used.

Additional compilers can be installed on request to [excl-help@ornl.gov](mailto:excl-help@ornl.gov). Maintaining multiple Gnu suites is straightforward, less so for other tool suites.

On Leconte, the gnu, xlc, and pgi suites are installed.

Additional compilers and tools can also be installed using [Spack](https://spack.readthedocs.io/en/latest/).
