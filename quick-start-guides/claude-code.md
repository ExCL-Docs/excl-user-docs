# Claude Code Quick Start

Claude Code is an agentic coding assistant that can read, edit, test, and debug code from a terminal. On ExCL systems, run Claude Code inside an isolated environment rather than directly from your normal home directory.

The ExCL Claude Code sandbox is available at:

> **Repository:** [https://code.ornl.gov/7ry/claude-hpc](https://code.ornl.gov/7ry/claude-hpc)

## Quickstart

Clone the repository and run Claude Code in three steps:

```bash
git clone git@code.ornl.gov:7ry/claude-hpc.git
cd claude-hpc
make install
```

Then launch Claude Code from any repository:

```bash
cd /path/to/repository
claude-hpc .
```

{% hint style="info" %}
To use Slurm commands (`squeue`, `sbatch`, etc.) or Lmod modules inside Claude, switch to the `slurm` branch before building:
```bash
git checkout slurm
```
{% endhint %}

## Recommended ExCL setup

Run Claude Code inside an Apptainer container with:

* A throwaway home directory
* Only the current repository bind-mounted
* No access to your real `~/.ssh`, `~/.aws`, `~/.kube`, `~/.docker`, or `~/.gnupg`
* Claude Code permissions (or Auto mode) as a second safety layer

While Claude Code includes its own permission system and command sandboxing, Anthropic notes that the built-in sandbox does not isolate every tool, MCP server, or hook. Running the entire Claude Code process inside an Apptainer container provides an additional security boundary while preserving a normal development workflow.

## Installation

Clone the repository:

```bash
git clone git@code.ornl.gov:7ry/claude-hpc.git
cd claude-hpc
```

### Build the container

The container definition is provided in `claude-code.def`.

Build the Claude Code image:

```bash
make build
```

The first build automatically creates the base image if it does not already exist.

To rebuild only the base image (system packages, LaTeX, ripgrep, etc.):

```bash
make build-base
```

### Install Claude Code

Install Claude Code into the persistent container home so it can update itself independently of the container image:

```bash
make install-claude
```

This sets the npm prefix to `~/.local` inside the persistent home and installs `@anthropic-ai/claude-code` there. Because the persistent home is writable, Claude Code can download and apply updates on its own without rebuilding the container.

To update Claude Code later, run `make install-claude` again, or let Claude Code update itself automatically.

### Install the launcher

Install the launcher script, copy the image, and install Claude Code into the persistent home:

```bash
make install
```

This installs:

* `claude-hpc` into `~/bin`
* the Apptainer image into `~/.containers/images` (copied with `rsync -ah --progress`)
* Claude Code into the persistent home via `make install-claude` (skipped if already installed)

## Running Claude Code

From the repository you want Claude to work on:

```bash
cd /path/to/repository
claude-hpc .
```

The launcher automatically:

* mounts the repository as `/work`
* uses a persistent isolated home located at

```text
~/.containers/homes/claude-hpc/home
```

* starts Claude Code inside the Apptainer sandbox

## Available Make Targets

The repository provides several convenience targets:

| Target            | Description                                                           |
| ----------------- | --------------------------------------------------------------------- |
| `make build`      | Build the Claude Code image (builds the base image if necessary)      |
| `make build-base` | Build the base image containing system tools                          |
| `make run`        | Run Claude Code                                                       |
| `make remote`     | Run Claude Code with `--remote-control`                               |
| `make danger`     | Run Claude Code with `--dangerously-skip-permissions`                 |
| `make shell`      | Open a Bash shell inside the container                                |
| `make install`    | Install the launcher and image                                        |
| `make install-claude` | Install Claude Code into the persistent home (user-updatable)     |
| `make install-uv` | Install `uv` into the persistent Claude home                          |
| `make show-home`  | Print the path to the persistent Claude home                          |
| `make clean-home` | Delete the persistent Claude home (reset authentication and settings) |

Override the working directory when using the make targets:

```bash
make run DIR=/path/to/repository
```

## First-time Login

The first time Claude Code starts, authenticate normally.

Authentication is stored inside the persistent container home rather than your real home directory.

```bash
claude-hpc .
```

## Recommended Workflow

For normal development:

```bash
claude-hpc .
```

or

```bash
make run
```

Claude can then inspect code, implement features, fix bugs, write documentation, generate tests, and perform code reviews.

## Remote Control Mode

To allow IDE integrations or other remote clients to control Claude Code, start it with:

```bash
claude-hpc . --remote-control
```

or

```bash
make remote
```

Because the container home persists between runs, remote clients can reconnect without re-authenticating.

## Dangerous Mode

Normally Claude Code asks for confirmation before performing potentially destructive actions.

To disable those prompts:

```bash
claude-hpc . --dangerously-skip-permissions
```

or

```bash
make danger
```

Only use this mode:

* inside the Apptainer sandbox
* on disposable branches or worktrees
* in repositories that do not contain sensitive credentials

Do **not** run:

```bash
claude --dangerously-skip-permissions
```

directly on the host.

## Working in a Temporary Worktree

For experimental changes:

```bash
git worktree add /tmp/claude-worktree feature
cd /tmp/claude-worktree
claude-hpc .
```

Review changes before merging:

```bash
git diff
git status
```

## Read-only Data Mounts

Reference datasets can be mounted read-only. When mounting from ExCL Shared project storage, always bind the specific subdirectory the agent needs rather than the entire project tree.

`claude-hpc` forwards extra arguments to Claude Code, not to apptainer, so additional bind mounts must be specified via the `APPTAINER_BINDPATH` environment variable, which apptainer merges with its own `--bind` flags automatically.

**Inline** — set the variable for a single run:

```bash
APPTAINER_BINDPATH="/auto/projects/<project>/datasets/my-dataset:/data:ro" \
  claude-hpc .
```

Multiple paths are comma-separated:

```bash
APPTAINER_BINDPATH="/auto/projects/<project>/datasets/foo:/data:ro,/auto/projects/<project>/configs/bar:/configs:ro" \
  claude-hpc .
```

**direnv** — automatically set the bind path whenever you enter the repository:

```bash
# .envrc
export APPTAINER_BINDPATH="/auto/projects/<project>/datasets/my-dataset:/data:ro"
```

For multiple directories, separate paths with a comma:

```bash
# .envrc
export APPTAINER_BINDPATH="\
/auto/projects/<project>/datasets/my-dataset:/data:ro,\
/auto/projects/<project>/configs/my-config:/configs:ro"
```

Then allow it once:

```bash
direnv allow
```

After that, `claude-hpc .` picks up the bind mount automatically in any shell that enters the directory.

Mount the narrowest subdirectory that satisfies the task. Do **not** bind `/auto/projects/<project>` or any other large shared tree when only a subdirectory is needed.

## What Not to Mount

Do **not** expose your real home directory or credential stores to the container.

Avoid mounting:

```text
~/.ssh
~/.aws
~/.kube
~/.docker
~/.config/gcloud
~/.gnupg
```

### ExCL Shared Project Storage

Do **not** mount the ExCL Shared project storage unless Claude actually needs to read files from it. Even then:

* Mount **read-only** (`:ro`) — never give the agent write access to shared storage.
* Mount only the **specific subdirectory** required, not the project root or any parent directory.
* Prefer copying or symlinking the specific files into your work directory when only a few files are needed.

| Scenario | Mount |
| -------- | ----- |
| Claude needs to inspect one dataset | `--bind "/auto/projects/<project>/datasets/foo:/data:ro"` |
| Claude needs to read a config file | copy the file into your repo; no bind needed |
| Claude is writing or building code | no shared-storage mount needed |

Mounting more than necessary increases blast radius if the agent misbehaves and increases the risk of accidental reads of unrelated project data.

## Recommended Commands

Normal development:

```bash
claude-hpc .
```

or

```bash
make run
```

Remote control:

```bash
make remote
```

Dangerous mode (sandbox only):

```bash
make danger
```

Temporary worktree:

```bash
git worktree add /tmp/claude-worktree feature
cd /tmp/claude-worktree
claude-hpc .
```

## Sub-Agents

Claude Code can spawn background sub-agents to handle tasks in parallel (for example, during multi-agent code review or long-running searches). Before exiting, stop any active agents through the Claude Code interface.

Pressing **Ctrl+C** will interrupt Claude and reveal whether any background agents are still running, but it does not stop them. You must explicitly stop each active agent before exiting to avoid leaving orphaned agent processes behind. Press **Ctrl+C** a second time to exit Claude Code.

## Best Practices

### Isolating uv virtual environments

If you use `uv` and work on the same repository both on the host and inside the container, `UV_PROJECT_ENVIRONMENT` needs to be set inside the container's persistent home so Claude creates its own `.venv` instead of reusing (or clobbering) the one from your host checkout. `make install-uv` sets this automatically by appending to `~/.containers/homes/claude-hpc/home/.profile`:

```bash
export UV_PROJECT_ENVIRONMENT=.venv-claude
```

This matters because the container cannot see the `uv`-managed files stored under your real home directory (e.g. `~/.cache/uv`, `~/.local/share/uv`), so a virtual environment created on the host will not resolve correctly from inside the container, and vice versa. Giving Claude a distinct environment directory avoids that mismatch and keeps the two environments from interfering with each other.

## Notes

Claude Code's permission system and the Apptainer sandbox serve different purposes:

* **Permissions** determine whether Claude is allowed to perform an action.
* **Sandboxing** limits what Claude can access after the action is performed.

Neither replaces the other. Running Claude Code inside an Apptainer container while leaving Claude's permission system enabled provides a secure default for ExCL development while minimizing changes to existing workflows.
