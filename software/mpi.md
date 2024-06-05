---
description: Build and run MPI (Message Passing Interface) enabled codes on EXCL
---

# MPI

## Notes

- ExCL systems typically do not have InfiniBand setup. (Although if this is required, it can be added as needed.) This means that you could see HCOLL warnings/errors which state that no HCA device can be found. This happens since HPC-X enables HCOLL by default and HCOLL requires an InfiniBand adapter. You can disable HCOLL and get rid of these warnings/errors with the `-mca coll_hcoll_enable 0` flag for example: `mpirun -np 4 -mca coll_hcoll_enable 0 ./a.out`.


## Hello World built with nvhpc

```c
## mpi_hello_world.c

#include <mpi.h>
#include <stdio.h>

int main(int argc, char** argv) {
    // Initialize the MPI environment
    MPI_Init(NULL, NULL);

    // Get the number of processes
    int world_size;
    MPI_Comm_size(MPI_COMM_WORLD, &world_size);

    // Get the rank of the process
    int world_rank;
    MPI_Comm_rank(MPI_COMM_WORLD, &world_rank);

    // Get the name of the processor
    char processor_name[MPI_MAX_PROCESSOR_NAME];
    int name_len;
    MPI_Get_processor_name(processor_name, &name_len);

    // Print off a hello world message
    printf("Hello world from processor %s, rank %d out of %d processors\n",
           processor_name, world_rank, world_size);

    // Finalize the MPI environment.
    MPI_Finalize();
}
```

Load the Nvidia HPC SDK environment module
```bash
$ module load nvhpc-openmpi3
```

Verify the compiler path
```bash
$ which mpicc
/opt/nvidia/hpc_sdk/Linux_x86_64/24.5/comm_libs/openmpi/openmpi-3.1.5/bin/mpicc
```

Build the program
```bash
$ mpicc ./mpi_hello_world.c
```

Run the program with MPI
```bash
$ mpirun -np 4 -mca coll_hcoll_enable 0 ./a.out

--------------------------------------------------------------------------
[[63377,1],2]: A high-performance Open MPI point-to-point messaging module
was unable to find any relevant network interfaces:

Module: OpenFabrics (openib)
  Host: milan0

Another transport will be used instead, although this may result in
lower performance.

NOTE: You can disable this warning by setting the MCA parameter
btl_base_warn_component_unused to 0.
--------------------------------------------------------------------------
Hello world from processor milan0.ftpn.ornl.gov, rank 2 out of 4 processors
Hello world from processor milan0.ftpn.ornl.gov, rank 0 out of 4 processors
Hello world from processor milan0.ftpn.ornl.gov, rank 1 out of 4 processors
Hello world from processor milan0.ftpn.ornl.gov, rank 3 out of 4 processors
[milan0.ftpn.ornl.gov:2122196] 3 more processes have sent help message help-mpi-btl-base.txt / btl:no-nics
[milan0.ftpn.ornl.gov:2122196] Set MCA parameter "orte_base_help_aggregate" to 0 to see all help / error messages

```