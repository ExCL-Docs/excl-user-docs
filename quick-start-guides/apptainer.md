[Apptainer/Singularity](https://apptainer.org/) is the most widely used container system for HPC. It is designed to execute applications at bare-metal performance while being secure, portable, and 100% reproducible. Apptainer is an open-source project with a friendly community of developers and users. The user base continues to expand, with Apptainer/Singularity now used across industry and academia in many areas of work.

[Apptainer](https://apptainer.org/docs/user/1.0/introduction.html) is a _container_ platform. It allows you to create and run containers that package up pieces of software in a way that is portable and reproducible. You can build a container using Apptainer on your laptop, and then run it on many of the largest HPC clusters in the world, local university or company clusters, a single server, in the cloud, or on a workstation down the hall. Your container is a single file, and you don’t have to worry about how to install all the software you need on each different operating system.

Apptainer allows for more secure containers than docker without the need for root access.

# Why use Apptainer?

From [Why you should use Apptainer vs Docker | Medium](https://medium.com/@dcat52/why-you-should-use-apptainer-21ef1fe7e0bb).

Apptainer allows you to:
1. Build on a personal computer with root or on a shared system with fakeroot.
2. Move images between systems easily.
3. Execute on a shared system without root.

Apptainer is designed for HPC:
1. Defaults to running as the current user
2. Defaults to mounting the home directory in /home/$USER
3. Defaults to running as a program (not background process)

Apptainer also has great support with Docker images.

# Systems with Apptainer installed

- docker
- zenith

Other systems can have Apptainer installed by request.

# Notes:

- Apptainer mounts `$HOME` ,  `/sys:/sys` ,  `/proc:/proc`,  `/tmp:/tmp`,  `/var/tmp:/var/tmp`,  `/etc/resolv.conf:/etc/resolv.conf`,  `/etc/passwd:/etc/passwd`, and `$PWD` by default and run in `~` by default. This means you can change files in your home directory by running with Apptainer. This is different from Docker which creates a container (overlay in Apptainer) by default for the application to run in. See [Bind Paths and Mounts](https://apptainer.org/docs/user/main/bind_paths_and_mounts.html).
- To mount another location when running Apptainer, use the `--bind` option. For example to mount `/noback` use `--bind /noback:/noback`. See [Bind Paths and Mounts](https://apptainer.org/docs/user/main/bind_paths_and_mounts.html).
- Admins can specify default bind points in `/etc/apptainer/apptainer.conf`. See [Apptainer Configuration Files](https://apptainer.org/docs/admin/main/configfiles.html#bind-mount-management)
- When creating a definition file, pay attention to the rules for each section. See [Definition Files](https://apptainer.org/docs/user/main/definition_files.html) For example:
    - `%setup` is a scriplet which runs outside the container and can modify the host. Use `${APPTAINER_ROOTFS}` to access the files in the Apptainer image.
    - Environment variables defined in `%environment` are available only after the build, so if you need access to them for the build, define them in the `%post` section.
- To use `--fakeroot` you must first have fakeroot configured for that user. This can be done with the command `sudo apptainer config fakeroot --add <user>`. See [User Namespaces & Fakeroot](https://apptainer.org/docs/admin/main/user_namespace.html)


## NFS Limitations

From <https://apptainer.org/docs/admin/main/installation.html#nfs>.

NFS filesystems support overlay mounts as a `lowerdir` only, and do not support user-namespace (sub)uid/gid mapping.
- Containers run from SIF files located on an NFS filesystem do not have restrictions.
- In setuid mode, you cannot use `--overlay mynfsdir/` to overlay a directory onto a container when the overlay (upperdir) directory is on an NFS filesystem. In non-setuid mode and fuse-overlayfs it is allowed but will be read-only.
- When using `--fakeroot` and `/etc/subuid` mappings to build or run a container, your `TMPDIR` / `APPTAINER_TMPDIR` should not be set to an NFS location.
- You should not run a sandbox container with `--fakeroot` and `/etc/subuid` mappings from an NFS location.
        
# Getting Started
- [Apptainer—Documentation](https://apptainer.org/docs/user/1.0/introduction.html)
- [Apptainer—Quickstart](https://apptainer.org/docs/user/main/quick_start.html)
- [Apptainer—Support for Docker and OCI Containers](https://apptainer.org/docs/user/1.0/docker_and_oci.html)
- [Apptainer—Running Services](https://apptainer.org/docs/user/1.0/running_services.html)
- [Apptainer—CLI Run](https://apptainer.org/docs/user/1.0/cli/apptainer_run.html?highlight=run)
- [Apptainer—Bind Paths and Mounts](https://apptainer.org/docs/user/main/bind_paths_and_mounts.html)
- [Apptainer—Definition Files](https://apptainer.org/docs/user/main/definition_files.html)
