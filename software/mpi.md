# MPI

## Notes

- ExCL systems typically do not have InfiniBand setup. (Although if this is required, it can be added as needed.) This means that you could see HCOLL warnings/errors which state that no HCA device can be found. This happens since HPC-X enables HCOLL by default and HCOLL requires an InfiniBand adapter. You can disable HCOLL and get rid of these warnings/errors with the `-mca coll_hcoll_enable 0` flag for example: `mpirun -np 4 -mca coll_hcoll_enable 0 ./a.out`.
