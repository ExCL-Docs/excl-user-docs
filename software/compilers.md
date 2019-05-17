# ExCL compilers

Compilers are, in general, maintained from a central NFS repository, and made accessible via the module command (from Lmod).   For example

```
hsm@quad03:~/Garage$ module avail

---------------------------------------------- /auto/software/modules/x86_64/modulefiles ----------------------------------------------
   gnu/8.3.0    gnu/9.1.0 (D)    intel/system_studio_2019 (L)    pgi/19.4

------------------------------------------------ /usr/share/lmod/lmod/modulefiles/Core ------------------------------------------------
   lmod    settarg

  Where:
   L:  Module is loaded
   D:  Default Module
   ```

   on quad03 I have been using the intel compiler suite (L).   There are two (well three, actually) gnu compiler suites available.  If you do not load a module, you will get the default compiler as delivered by the operating system vendor (4.8.5 on some systems).  If you `module load gnu` you will currently get 9.1.0, as it is the default.  I fyou need 8.3.0, you need to `module load gnu/8.3.0`.

   Some compilers (notably xlc) cannot be installed on nfs, so if they are availble they will shw up in a different module directory.  The same module commands are used.

   
