---
description: Getting Started with Python in ExCL with best practice recommendations.
---
# Python Quick Start

This page covers a few recommendations and tips for getting started with Python in ExCL following best practices for packaging python projects and using virtual environments. There are many different ways to structure and package python projects and various tools that work with python, so this page is not meant to be comprehensive but to provide a few recommendations for getting started.

## Python Virtual Environments with venv

Using virtual environments is the recommended way to isolate Python dependencies and ensure compatibility across different projects. Virtual environments prevent conflicts between packages required by different projects and simplify dependency management. The goal with isolated, project specific python environments is to avoid the situation found in <https://xkcd.com/1987/>.

![xkcd 1987 - Python Environment](https://imgs.xkcd.com/comics/python_environment.png)

If you are a using the [fish shell](https://fishshell.com/), the simple function show below is a wrapper around venv to activate a python virtual environment if one already exists in `.venv` in the current directory or create a new virtual environment and activate it if one does not already exist.

```fish
function pvenv --wraps='python3 -m venv --upgrade-deps venv' --description 'Create and activate a python virtual environment in .venv with updated pip and prompt set to the folder\'s name'
   if test -e .venv/bin/activate.fish
      echo Using existing `.venv`.
      source .venv/bin/activate.fish
   else
      echo Creating new `.venv`.
      python3 -m venv --upgrade-deps --prompt (basename $PWD) .venv $argv; and source .venv/bin/activate.fish;
   end
end
```

This `pvenv` function is already configured system wide for fish on ExCL systems.

To create the virtual environment without using the wrapper function is also easy.

In bash:
```bash
python3 -m venv --upgrade-deps --prompt $(basename $PWD) .venv
source .venv/bin/activate
```

In fish:
```fish
python3 -m venv --upgrade-deps --prompt (basename $PWD) .venv
source .venv/bin/activate.fish
```

Here is the usage of venv which explains what the various flags do. From [venv — Creation of virtual environments — Python 3.13.1 documentation](https://docs.python.org/3/library/venv.html).

```txt
usage: venv [-h] [--system-site-packages] [--symlinks | --copies] [--clear]
            [--upgrade] [--without-pip] [--prompt PROMPT] [--upgrade-deps]
            [--without-scm-ignore-files]
            ENV_DIR [ENV_DIR ...]

Creates virtual Python environments in one or more target directories.

positional arguments:
  ENV_DIR               A directory to create the environment in.

options:
  -h, --help            show this help message and exit
  --system-site-packages
                        Give the virtual environment access to the system
                        site-packages dir.
  --symlinks            Try to use symlinks rather than copies, when
                        symlinks are not the default for the platform.
  --copies              Try to use copies rather than symlinks, even when
                        symlinks are the default for the platform.
  --clear               Delete the contents of the environment directory
                        if it already exists, before environment creation.
  --upgrade             Upgrade the environment directory to use this
                        version of Python, assuming Python has been
                        upgraded in-place.
  --without-pip         Skips installing or upgrading pip in the virtual
                        environment (pip is bootstrapped by default)
  --prompt PROMPT       Provides an alternative prompt prefix for this
                        environment.
  --upgrade-deps        Upgrade core dependencies (pip) to the latest
                        version in PyPI
  --without-scm-ignore-files
                        Skips adding SCM ignore files to the environment
                        directory (Git is supported by default).

Once an environment has been created, you may wish to activate it, e.g. by
sourcing an activate script in its bin directory.
```

The virtual environment can be exited with `deactivate`.

## Creating a Python Project in using the Hatch build system with CI support

[Python Project Template](https://code.ornl.gov/7ry/python-project-template) provides a template for creating a python project using the hatch build system with CI support using ORNL's GitLab instance, complete with development documentation, linting, commit hooks, and editor configuration.

Steps to use the template:

1. [Fork the respository.](https://code.ornl.gov/7ry/python-project-template/-/forks/new)
2. Run `setup_template.sh` to setup the template for the new project.
3. Remove `setup_template.sh`

See [Python Project Template Documentation](https://devdocs.ornl.gov/7ry/python-project-template/) for details on the template.

## Using UV to create a python virtual environment with a specific version of python.

When a specific version of python is required, [uv](https://github.com/astral-sh/uv) can be used to create a virtual environment with the specific version of python.

```shell
uv venv --python <version>
```

For example:

```shell
uv venv --python 3.11
```

Use the command below to see the available python versions.

```shell
uv python list
```

See [astral-sh/uv - python management](https://github.com/astral-sh/uv?tab=readme-ov-file#python-management) and [uv docs - installing a specific version](https://docs.astral.sh/uv/guides/install-python/#installing-a-specific-version) for details.
