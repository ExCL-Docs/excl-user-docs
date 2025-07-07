---
description: The recommended way to install Conda and Spack.
---
# Conda and Spack Installation

This guide goes over the recommended way to install [Conda](https://docs.conda.io/en/latest/) and [Spack](https://spack-tutorial.readthedocs.io/en/latest/) in ExCL. If you are already familiar with the Conda and Spack installation process, then these tools can be installed to their default locations. One recommendation is to store the `environment.yml` and `spack.yaml` files in your git repositories to make it easy to recreate the Conda and Spack environments required for that project. The remainder of this page goes over the installation in more detail.

## Installing Conda

{% hint style="danger" %}
With recent changes to the Conda license, we are unable to use the default conda channel without a paid license. You can still use conda/miniconda/miniforge/etc with the `conda-forge` repository, but you must change it from using the `default` repository. See [Transitioning from defaults | conda-forge | community-driven packaging for conda](https://conda-forge.org/docs/user/transitioning_from_defaults/) and [Saying Goodbye to Anaconda?. Finding a replacement for Conda | by Robert McDermott | Medium](https://robert-mcdermott.medium.com/saying-goodbye-to-anaconda-91c18ddf89bb) for some additional information. The recommended approach is now to use [venv](https://docs.python.org/3/library/venv.html), [uv](https://docs.astral.sh/uv/), or [Pixi](https://pixi.sh/latest/) for managing python environments. These approaches work better and avoid the license issues. See also [Python | ExCL User Docs](https://docs.excl.ornl.gov/quick-start-guides/python) for more information on how to get started with Python. If you still want to use `conda`, the recommended approach is to install Miniforge from [https://conda-forge.org/](https://conda-forge.org/). To prevent unintentional use of the default conda channel, we block requests to `https://repo.anaconda.com/pkgs`.
{% endhint %}

See [conda-forge | download](https://conda-forge.org/download/) for the latest installation instructions. Miniforge is the recommended version of conda since its a minimal base install which defaults to using conda-forge packages.

```bash
# Download the installer
wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh

# Run the installer
bash Miniforge3-Linux-x86_64.sh
```

Follow the prompts on the installer screens. Accept the license agreements. *(Optional) Specify `/home/$USER/conda` as the installation location.* Choose if you want the installer to initialize Miniforge.

### Improving Conda Environment Solver Performance

To improve the performance of the Conda environment solver, you can use the `conda-libmamba-solver` plugin which allows you to use `libmamba`, the same `libsolv`-powered solver used by [mamba](https://mamba.readthedocs.io/en/latest/index.html) and [micromamba](https://mamba.readthedocs.io/en/latest/user_guide/micromamba.html), directly in `conda`.

The quick start guide is below.

```bash
conda update -n base conda
conda install -n base conda-libmamba-solver
conda config --set solver libmamba
```

See [Anaconda | A Faster Solver for Conda: Libmamba](https://www.anaconda.com/blog/a-faster-conda-for-a-growing-community) and [Getting started — conda-libmamba-solver](https://conda.github.io/conda-libmamba-solver/getting-started/) for more information.

## Installing Spack

```bash
# Install spack by checking out the right branch to /home
git clone https://github.com/spack/spack /home/$USER/spack
cd /home/$USER/spack
git checkout releases/latest # or release/v0.16

# Install a spack compiler to use as the default
spack install gcc@9.3.0 
spack compiler add $(spack location -i gcc@9.3.0)

# Add Spack to bashrc.
cat >> ~/.bashrc << 'EOL'
# Setup Spack
if [ -f "/home/$USER/spack/share/spack/setup-env.sh" ]; then
   source /home/$USER/spack/share/spack/setup-env.sh
fi
EOL
```
