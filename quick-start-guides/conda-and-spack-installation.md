---
description: The recommended way to install Conda and Spack.
---

# Conda and Spack Installation

This guide goes over the recommended way to install [Conda ](https://docs.conda.io/en/latest/)and [Spack ](https://spack-tutorial.readthedocs.io/en/latest/)in ExCL. If you are already familiar with the Conda and Spack installation process, then the main takeaway is to install both packages in `/noback/<userid>` since the installations can become quite large \(&gt;50GB\) and they typically do not need to be backed up. Another recommendation is to store the `environment.yml` and `spack.yaml` files in your git repositories to make it easy to recreate the Conda and Spack environments required for that project. The remainder of this page goes over the installation in more detail.

### Installing Conda

See the [Conda Docs](https://docs.conda.io/en/latest/miniconda.html#linux-installers) for the latest installation instructions. I install Miniconda instead of Anaconda since I do not require the 3GB of included packages that come with Anaconda and I will be installing my own packages anyways.

```bash
# Download the installer
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh

# Run the installer
bash Miniconda3-latest-Linux-x86_64.sh
```

Follow the prompts on the installer screens. Accept the license agreements. **Specify `/noback/$USER/conda` as the installation location.** Choose if you want the installer to initialize Miniconda.

### Installing Spack

```bash
# Install spack by checking out the right branch to /noback
git clone https://github.com/spack/spack /noback/$USER/spack
cd /noback/$USER/spack
git checkout releases/latest # or release/v0.16

# Install a spack compiler to use as the default
spack install git@9.3.0 
spack compiler add $(spack location -i gcc@9.3.0)

# Add Spack to bashrc.
cat >> ~/.bashrc << 'EOL'
# Setup Spack
if [ -f "/noback/$USER/spack/share/spack/setup-env.sh" ]; then
   source /noback/$USER/spack/share/spack/setup-env.sh
fi
EOL
```

