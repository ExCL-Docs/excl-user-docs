# Compilers

Compilers are, in general, maintained from a central NFS repository, and made accessible via the module command (from Lmod). For example

```
hsm@secretariat:~$ module load gnu
hsm@secretariat:~$ module avail

---------------- /usr/share/lmod/lmod/modulefiles ----------------
   Core/lmod/6.6    Core/settarg/6.6

------ /auto/software/swtree/ubuntu20.04/x86_64/modulefiles ------
   anaconda/3          git/2.38.0             julia/1.8.0
   cmake/3.22.5        gnu/10.2.0             llvm/8.0.1
   gcc/10.2.0          gnu/11.1.0             llvm/13.0.1
   gcc/11.1.0          gnu/11.3.0             llvm/14.0.0 (D)
   gcc/11.3.0          gnu/12.1.0    (L,D)
   gcc/12.1.0   (D)    hipsycl/0.9.2

  Where:
   L:  Module is loaded
   D:  Default Module

```

If you do not load a module, you will get the default compiler as delivered by the operating system vendor (4.8.5 on some systems). If you `module load gnu` you will currently get 12.1.0, as it is the default. If you need, say, 10.2.0, you need to `module load gnu/10.2.0`. Note that documentation details with respect to compiler availability and versions will not necessarily be kept up to date; the system itself is authoritative.

Some compilers (notably xlc and the nvhpc tool chain) cannot be installed on nfs, so if they are availble they will show up in a different module directory. The same module commands are used.

Additional compilers can be installed on request to [excl-help@ornl.gov](mailto:excl-help@ornl.gov). Maintaining multiple Gnu suites is straightforward, less so for other tool suites.

Additional compilers and tools can also be installed using [Spack](https://spack.readthedocs.io/en/latest/).
