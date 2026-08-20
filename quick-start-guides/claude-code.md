# Claude Code / Codex CLI Quick Start

Claude Code and OpenAI's Codex CLI are agentic coding assistants that can read, edit, test, and debug code from a terminal. On ExCL systems, run them inside an isolated environment rather than directly from your normal home directory. This repo packages both the same way, sharing one base image but with separate container images, launchers, and persistent homes so the two tools' auth/config never collide.

The ExCL sandbox for both tools is available at:

> **Repository:** <https://code.ornl.gov/7ry/claude-hpc>

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

> [!TIP]
> Slurm commands (`squeue`, `sbatch`, etc.) and Lmod modules (`module load …`) work inside Claude Code out of the box. A branch switch is no longer needed. See [Slurm and environment modules](#slurm-and-environment-modules) below.

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
make build-claude
```

The first build automatically creates the base image if it does not already exist. (Plain `make build` builds both the Claude Code and Codex CLI images in one go — see [Codex CLI](#codex-cli) below.)

To rebuild only the base image (system packages, LaTeX, ripgrep, etc.):

```bash
make build-base
```

### Install Claude Code

Install Claude Code into the persistent container home so it can update itself independently of the container image:

```bash
make install-claude-cli
```

This sets the npm prefix to `~/.local` inside the persistent home and installs `@anthropic-ai/claude-code` there. Because the persistent home is writable, Claude Code can download and apply updates on its own without rebuilding the container.

To update Claude Code later, run `make install-claude-cli` again, or let Claude Code update itself automatically.

### Install the launcher

Install the launcher script, copy the image, and install Claude Code into the persistent home:

```bash
make install-claude
```

This installs:

* `claude-hpc` into `~/bin`
* the Apptainer image into `~/.containers/images` (copied with `rsync -ah --progress`)
* Claude Code into the persistent home via `make install-claude-cli` (skipped if already installed)

(Plain `make install`, with no suffix, runs `install-claude` and `install-codex` together.)

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
| `make build-claude` | Build the Claude Code image (builds the base image if necessary)    |
| `make build-base` | Build the base image containing system tools                          |
| `make run`        | Run Claude Code                                                       |
| `make remote`     | Run Claude Code with `--remote-control`                               |
| `make danger`     | Run Claude Code with `--dangerously-skip-permissions`                 |
| `make shell`      | Open a Bash shell inside the container                                |
| `make install-claude` | Install the launcher and image                                    |
| `make install-claude-cli` | Install Claude Code into the persistent home (user-updatable) |
| `make install-uv-claude` | Install `uv` into the persistent Claude home                   |
| `make show-home-claude`  | Print the path to the persistent Claude home                   |
| `make clean-home-claude` | Delete the persistent Claude home (reset authentication and settings) |

Every target above also has a bare form with no `-claude`/`-codex` suffix. For `build`, `install`, `install-uv`, `install-rust`, `show-home`, and `clean-home`, the bare form runs the operation for **both** tools (Make only rebuilds the shared `base.sif` once). `run`, `danger`, and `shell` stay single-tool when unsuffixed — running two interactive sessions at once isn't practical — and default to Claude Code for backward compatibility (`run` is an alias for `run-claude`, etc.); use the explicit `-codex` form for Codex CLI.

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

If you use `uv` and work on the same repository both on the host and inside the container, `UV_PROJECT_ENVIRONMENT` needs to be set inside the container's persistent home so Claude creates its own `.venv` instead of reusing (or clobbering) the one from your host checkout. `make install-uv-claude` (or bare `make install-uv`, which does this for both tools) sets this automatically by appending to `~/.containers/homes/claude-hpc/home/.profile`:

```bash
export UV_PROJECT_ENVIRONMENT=.venv-claude
```

This matters because the container cannot see the `uv`-managed files stored under your real home directory (e.g. `~/.cache/uv`, `~/.local/share/uv`), so a virtual environment created on the host will not resolve correctly from inside the container, and vice versa. Giving Claude a distinct environment directory avoids that mismatch and keeps the two environments from interfering with each other.

## Slurm and Environment Modules

The container includes the cluster's Slurm client tools (`sbatch`, `srun`, `salloc`, `squeue`, `sinfo`, `scancel`, `scontrol`, `sacct`, PMI libs), `munge`, and Lmod. No extra setup is needed — `make run`/`make shell`/`claude-hpc`/`claude-hpc-shell` (and the `-codex` equivalents) already bind-mount:

* `/etc/slurm` (read-only) — the cluster's `slurm.conf` and related config
* `/var/run/munge` — the host's running `munged` socket, used for authentication
* `/auto/software/swtree` (read-only) — the ORNL software tree, so Lmod's `MODULEPATH` resolves to real modulefiles

The container never holds a copy of the munge key or runs its own `munged`; it authenticates through the host's already-running daemon. `module load …` works from Claude's own Bash tool calls, not just interactive shells, because the image sources Lmod's init script via `BASH_ENV` — non-interactive shells (which is what Claude's Bash tool uses) never source `/etc/profile.d`, where Lmod normally wires itself in.

These binds are present for both tools — Codex CLI's launchers and `make *-codex` targets bind-mount the same three paths, so Slurm commands and `module load` work identically inside a Codex CLI container.

## Notes

Claude Code's permission system and the Apptainer sandbox serve different purposes:

* **Permissions** determine whether Claude is allowed to perform an action.
* **Sandboxing** limits what Claude can access after the action is performed.

Neither replaces the other. Running Claude Code inside an Apptainer container while leaving Claude's permission system enabled provides a secure default for ExCL development while minimizing changes to existing workflows.

## Codex CLI

Codex CLI follows the identical pattern to Claude Code above — same repository, same `Makefile`, same Apptainer sandboxing rationale — with its own container image, launcher scripts, and persistent home so the two tools never share authentication or configuration state.

### Build the container

The definition file is [`codex.def`](codex.def). It bootstraps `From: base.sif` (the same base image Claude Code uses) but overrides `HOME`/`PATH` to `/home/codex`, so `make build-base` only needs to run once regardless of which tool you build next.

Build the Codex CLI image:

```bash
make build-codex
```

The first build automatically creates the base image if it does not already exist.

### Install Codex CLI

Install Codex CLI into the persistent container home so it can update itself independently of the container image:

```bash
make install-codex-cli
```

This sets the npm prefix to `~/.local` inside the persistent Codex home (`~/.containers/homes/codex-hpc/home`, mounted at `/home/codex`) and installs `@openai/codex` there. Because the persistent home is writable, Codex CLI can download and apply updates on its own without rebuilding the container.

To update Codex CLI later, run `make install-codex-cli` again, or let Codex CLI update itself automatically.

### Install the launcher

Install the launcher scripts, copy the image, and install Codex CLI into the persistent home:

```bash
make install-codex
```

This installs:

* `codex-hpc` and `codex-hpc-shell` into `~/bin`
* the Apptainer image into `~/.containers/images` (copied with `rsync -ah --progress`)
* Codex CLI into the persistent home via `make install-codex-cli` (skipped if already installed)

### Running Codex CLI

From the repository you want Codex to work on:

```bash
cd /path/to/repository
codex-hpc .
```

The launcher automatically:

* mounts the repository as `/work`
* uses a persistent isolated home located at

```text
~/.containers/homes/codex-hpc/home
```

mounted at `/home/codex` inside the container (not `/home/claude` — the two tools' homes are entirely separate directories, both on the host and inside their respective containers)

* forwards `OPENAI_API_KEY` into the container automatically, if set in your shell (otherwise `--cleanenv` would strip it)
* starts Codex CLI inside the Apptainer sandbox

### Available Make Targets

| Target                  | Description                                                            |
| ------------------------ | ----------------------------------------------------------------------- |
| `make build-codex`       | Build the Codex CLI image (builds the base image if necessary)          |
| `make run-codex`         | Run Codex CLI                                                           |
| `make danger-codex`      | Run Codex CLI with `--dangerously-bypass-approvals-and-sandbox`         |
| `make shell-codex`       | Open a Bash shell inside the Codex container                            |
| `make install-codex`     | Install the launcher scripts and image                                  |
| `make install-codex-cli` | Install Codex CLI into the persistent home (user-updatable)             |
| `make install-uv-codex`  | Install `uv` into the persistent Codex home                             |
| `make install-rust-codex`| Install the Rust toolchain into the persistent Codex home               |
| `make show-home-codex`   | Print the path to the persistent Codex home                             |
| `make clean-home-codex`  | Delete the persistent Codex home (reset authentication and settings)    |

Note: Codex CLI has no equivalent of Claude Code's `--remote-control` (IDE-extension pairing), so there is no `remote-codex` target.

As described in the Claude Code section above, `build`, `install`, `install-uv`, `install-rust`, `show-home`, and `clean-home` (no suffix) run both tools at once; `run-codex`, `danger-codex`, and `shell-codex` must be invoked explicitly since the unsuffixed interactive targets default to Claude Code.

Override the working directory when using the make targets:

```bash
make run-codex DIR=/path/to/repository
```

### First-time Login

Codex CLI supports two authentication methods; either works from inside the container. Authentication state is stored inside the persistent Codex home rather than your real home directory.

**ChatGPT sign-in (default):**

```bash
codex-hpc .
```

Follow the "Sign in with ChatGPT" prompt on first run. Because this happens on a remote HPC node, confirm during your first login whether Codex CLI's browser flow needs a URL opened on your own machine and a code pasted back, versus a local browser/localhost redirect — the exact prompt can vary by Codex CLI version.

**API key:**

```bash
export OPENAI_API_KEY=sk-...
codex-hpc .
```

`OPENAI_API_KEY` is forwarded into the container automatically by `codex-hpc`, `codex-hpc-shell`, and all `make *-codex` targets whenever it's set in your shell.

### Recommended Workflow

For normal development:

```bash
codex-hpc .
```

or

```bash
make run-codex
```

Codex can then inspect code, implement features, fix bugs, write documentation, generate tests, and perform code reviews — same as Claude Code above.

### Dangerous Mode

Codex CLI's equivalent of Claude Code's `--dangerously-skip-permissions` is `--dangerously-bypass-approvals-and-sandbox`, which removes both the approval gate and Codex's own OS-level sandbox:

```bash
codex-hpc . --dangerously-bypass-approvals-and-sandbox
```

or

```bash
make danger-codex
```

Only use this mode:

* inside the Apptainer sandbox
* on disposable branches or worktrees
* in repositories that do not contain sensitive credentials

### Working in a Temporary Worktree, Read-only Data Mounts, and What Not to Mount

These sections above apply identically to Codex CLI — substitute `codex-hpc` for `claude-hpc`, `codex.sif` for `claude-code.sif`, and `~/.containers/homes/codex-hpc/home:/home/codex` for the Claude equivalent in the read-only bind example. The same "never bind `~/.ssh`, `~/.aws`, `~/.kube`, `~/.docker`, `~/.config/gcloud`, `~/.gnupg`" and "mount the narrowest subdirectory" guidance holds regardless of which tool is running.

### Isolating uv virtual environments (Codex CLI)

Same rationale as the Claude Code section above: `make install-uv-codex` sets `UV_PROJECT_ENVIRONMENT=.venv-codex` (note the distinct name — even though the Codex and Claude homes are already separate directories, using a different venv directory name keeps `~/.profile` self-documenting) by appending to `~/.containers/homes/codex-hpc/home/.profile`:

```bash
export UV_PROJECT_ENVIRONMENT=.venv-codex
```

## Notes (Codex CLI)

Codex CLI's own approval/sandbox system and the Apptainer sandbox serve the same complementary purposes described above for Claude Code: approvals decide whether Codex may perform an action, and the container sandbox limits what that action can reach afterward. Running Codex CLI inside Apptainer while leaving its own approval system enabled is the secure default; `--dangerously-bypass-approvals-and-sandbox` should be reserved for disposable, credential-free work.
