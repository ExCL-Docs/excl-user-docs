---
description: Getting Started with Slurm in ExCL with best practice recommendations.
---
# Getting Started with Slurm

Slurm is the recommended way to allocate resources and schedule long running jobs within ExCL. However, using Slurm is not a hard requirement, and nodes can still be directly accessed and used.

Our [Cheat Sheet | ExCL User Docs](https://docs.excl.ornl.gov/#excl-cheat-sheet) includes a quick Slurm reference on it.

## Details specific to Slurm on ExCL

### No usage limits or project accounts

The Slurm deployment on ExCL does not implement project/user quotas, priority queues, or quality of service guarantees. However, we reserved the right to ask users to share the machines more fairly if multiple people are wanting the same resource.

### Specialized accelerators with heterogeneous nodes

Apart from a few exceptions (primarily the Triple Crown Systems), all of the system on ExCL have a different configuration. This makes single node use of Slurm more common and adds additional challenges when running jobs that span multiple systems. MPI is being deployed and tested to support multiple nodes with different accelerators. Use of Slurm’s [Heterogeneous Job Support](https://slurm.schedmd.com/heterogeneous_jobs.html) is also recommended as needed. If you run into specific challenges please reach out with a [Support request](https://www.excl.ornl.gov/support-request/). Also because of this specialization is it likely that most jobs will want to specify the partition with `-p` or `--partition` and the desired node with `-w` or `--nodelist`.

See [[#Custom `sinfo` to show GRES and GRES Used.]] for how to list the specific accelerators for each system.

### Partitions are created on request

Partitions are created on request or based on project needs. If you want a new partition created please reach out with a [Support request](https://www.excl.ornl.gov/support-request/). Like-wise reach out if a node is missing or misconfigured for your use-case. Use `sinfo` to get a list of partitions and systems. As mentioned before, based on each nodes specialization, you you will likely be specifying partition with `-p` or `--partition` and the desired node with `-w` or `--nodelist` to run on a particular system with the configuration you want.

## ExCL’s Slurm Policy Q&A

### Should Slurm or direct SSH be used?

Direct SSH, Slurm batch submissions, and Slurm interactive jobs are all supported on the compute nodes. As a preference, if your job doesn't need interaction, then use `sbatch`. If it is a heavier job or the systems are under heavy use, then `srun` for interactive use is preferred to help with coordination. If the system is lightly used or the job is low-resource using and interactive, then direct `ssh` is fine.

An exception to this are nodes in high demand, that we have decided to set up as an Slurm exclusive system. See [[Slurm Exclusive Systems]].

### Should Slurm be used from the login node only or locally from the worker node?

Either works fine. The login node or any compute node can be used to submit Slurm jobs. One approach is to use a less-used general system for coding and VS Code, then use Slurm to compile and run on the target systems. Do not run heavy compilation or VS Code on the login node. When combining automated workflows with Slurm, sometimes it's useful to run the workflow on a separate node from the Slurm worker nodes.

### What about using Slurm when debugging, building, using VS Code, …? Or just when running?

Debugging probably needs to be done on the target system. If light resource or light use, then SSH is fine for minimal friction. Building and running with logging can be done via Slurm, preferably in batch mode, with output saved to a file. If it's of interest, I have on my to-do list to set up VS Code remote launching directly into a Slurm allocation. I.e., launching VS Code remote connection will open in a newly allocated Slurm job. Claude code and Codex are also good at debugging software using Slurm to launch the jobs. See [Claude Code and Codex | ExCL User Docs](https://docs.excl.ornl.gov/quick-start-guides/claude-code#slurm-and-environment-modules) for additional information.

### Use Slurm only when using GPUs, or when using CPUs as well?

The preference is to use Slurm anytime a job is using a known resource amount, is long-running, or uses a large amount of resources. Slurm can be used for allocation CPU, memory, and accelerator resources.

### How is ExCL’s Slurm instance configured to count CPUs/Threads/Hyperthreading?

Slurm is currently configured to allocate each core as a CPU (as opposed to each hyperthread as CPU) as well as allocating the memory and accelerators. Slurm is NUMA-aware, so that can also be requested, but I have less experience with it. By default the systems are shared and requested resources are allocated. `--exclusive` can be used if you want the full system allocated. (Of course, Slurm only schedules work that is submitted via Slurm, which is why Slurm use is recommended for sharing of resources. Slurm has no way of accounting for work started outside Slurm. Since Slurm is not required, `htop`, [availability@excl.groups.io](https://excl.groups.io/g/availability/messages), and Slack are used to check and request use. And we do have restricted access reservation requests, but if the system can be shared with Slurm or Slack, then that is less work for us and allows for tighter sharing.

### Should I use `srun` or `salloc`?

Use `salloc` when you want to allocate resources and run a command on the submission system (outside of the allocation). Use `srun` when you want to allocate resources and run on the allocated systems (within the allocation).

I find `srun` to be very useful to launch an interactive shell on the target system.

```
srun -c <cores> --mem=<memory> -t <timeout> -p <partition> -w <nodelist> --gres=<accelerators> --pty /bin/bash
```

I like to wrap these `srun` commands inside helpful shell functions for commonly used allocations. See [Vitis FPGA Development | ExCL User Docs](https://docs.excl.ornl.gov/quick-start-guides/vitis#using-vitis-with-the-fish-shell-recommended-approach) for examples.

> sbatch and salloc allocate resources to the job, while srun launches parallel tasks across those resources. When invoked within a job allocation, srun will launch parallel tasks across some or all of the allocated resources. In that case, srun inherits by default the pertinent options of the sbatch or salloc which it runs under. You can then (usually) provide srun different options which will override what it receives by default. Each invocation of srun within a job is known as a job step.
>
> srun can also be invoked outside of a job allocation. In that case, srun requests resources, and when those resources are granted, launches tasks across those resources as a single job and job step.
>
> —[hadoop - Slurm: What is the difference for code executing under salloc vs srun - Stack Overflow](https://stackoverflow.com/questions/22152400/slurm-what-is-the-difference-for-code-executing-under-salloc-vs-srun):

## Highlighted Slurm Documentation

This selected documentation is useful when learning Slurm or to use as a reference.

- [Slurm Workload Manager - Documentation](https://slurm.schedmd.com/documentation.html)
    - [Quick Start User Guide](https://slurm.schedmd.com/quickstart.html)—General user guide starting point.
    - [Command/option Summary (two pages)](https://slurm.schedmd.com/pdfs/summary.pdf)—Useful reference sheet to print out.
    - [Man Pages](https://slurm.schedmd.com/man_index.html)—Man pages to look up commands and options.
    - [Rosetta Stone of Workload Managers](https://slurm.schedmd.com/rosetta.html)—Useful if you are familiar with another workload manager.
    - [Job Array Support](https://slurm.schedmd.com/job_array.html)—Recommended for submitting lots of small jobs, or jobs with multiple tasks.
    - [Heterogeneous Job Support](https://slurm.schedmd.com/heterogeneous_jobs.html)—Support for heterogeneous jobs. Useful for our heterogeneous cluster.
    - Job Codes
        - [Job Reason Codes](https://slurm.schedmd.com/job_reason_codes.html)
        - [Job State Codes](https://slurm.schedmd.com/job_state_codes.html)
        - [Job Exit Codes](https://slurm.schedmd.com/job_exit_code.html)

## Commonly Used Slurm Commands

| Command                                             | Use case                                                                                                                                                           |
| --------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| [sacct](https://slurm.schedmd.com/sacct.html)       | Displays accounting data for all jobs and job steps in the Slurm job accounting log or Slurm database. (Useful to view completed job info.)                        |
| [salloc](https://slurm.schedmd.com/salloc.html)     | Obtain a Slurm job allocation (a set of nodes), execute a command, and then release the allocation when the command is finished. (Command runs on current system.) |
| [sbatch](https://slurm.schedmd.com/sbatch.html)     | Submit a batch script to Slurm. (Non-interactive job submission.)                                                                                                  |
| [scancel](https://slurm.schedmd.com/scancel.html)   | Used to signal jobs or job steps that are under the control of Slurm.                                                                                              |
| [scontrol](https://slurm.schedmd.com/scontrol.html) | View or modify Slurm configuration and state. (Useful to see detailed job or node state.)                                                                          |
| [sinfo](https://slurm.schedmd.com/sinfo.html)       | View information about Slurm nodes and partitions.                                                                                                                 |
| [squeue](https://slurm.schedmd.com/squeue.html)     | View information about jobs located in the Slurm scheduling queue.                                                                                                 |
| [srun](https://slurm.schedmd.com/srun.html)         | Run parallel jobs. (Also useful in ExCL when wanting to run a command on a single worker node. I use this instead of sacct to get a shell on the worker node.)     |
| [sstat](https://slurm.schedmd.com/sstat.html)       | Display the status information of a running job/step.                                                                                                              |

For a list of all Slurm commands, see [Slurm Workload Manager - Man Pages](https://slurm.schedmd.com/man_index.html).

## sbatch Template

{% hint style="info" %}
**`sbatch` Command Arguments** can be specified on the command line or in the script using `#SBATCH` before the argument. See the [sbatch documentation](https://slurm.schedmd.com/sbatch.html) to look up what the options do and for a full list of options.
{% endhint %}

Here is a recommended Slurm sbatch script template:

`slurm-base.sh`:
```bash
#!/bin/bash

#SBATCH --job-name=test
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=youngar@ornl.gov
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --output=slurm-test-out.txt
#SBATCH --error=slurm-test-err.txt
#SBATCH --partition=compute
#SBATCH --nodelist=justify

GIT_ROOT=$(git rev-parse --show-toplevel)
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo Started: $(date)
echo Host: $(hostname)
echo Path: $(pwd)
echo --------------------------------------------------------------------------------

### Setup Environment

## Work around for lmod + Slurm (Needed if you want to load a module)
unset MODULEPATH_ROOT
unset MODULEPATH
source /etc/profile.d/lmod.sh

### Run Command
echo Run Task

echo --------------------------------------------------------------------------------
echo Finished: $(date)

```

Example use:
```bash
$ sbatch slurm-bash.sh
Submitted batch job 45343
$ cat slurm-test-out.txt
Started: Wed Sep 16 10:20:22 AM EDT 2026
Host: justify.ftpn.ornl.gov
Path: /home/7ry/Data/templates/slurm-templates
--------------------------------------------------------------------------------
Run Task
--------------------------------------------------------------------------------
Finished: Wed Sep 16 10:20:22 AM EDT 2026
$ cat slurm-test-err.txt
$   
```

## Tips and Tricks

### More useful `sinfo` with more information:

```bash
sinfo --Node --long
```

### Custom `sinfo` to show CPU and memory state:

```shell
sinfo -o "%11n %10e %10m %10t %10c %15C" -p compute
```
```
HOSTNAMES   FREE_MEM   MEMORY     STATE      CPUS       CPUS(A/I/O/T)
milan0      846203     1030000    mix-       128        16/112/0/128
milan2      895363     1030000    mix        128        16/112/0/128
affirmed    770986     1031000    idle       256        0/256/0/256
cousteau    248966     257600     idle       48         0/48/0/48
explorer    414013     515697     idle       256        0/256/0/256
faraday     496276     514000     idle       192        0/192/0/192
justify     242856     1031000    idle       256        0/256/0/256
milan1      1018868    1030000    idle       128        0/128/0/128
milan3      981474     1030000    idle       128        0/128/0/128
oswald      49679      64144      idle       16         0/16/0/16
oswald00    255892     257664     idle       32         0/32/0/32
oswald02    240046     257664     idle       32         0/32/0/32
oswald03    255551     257600     idle       32         0/32/0/32
pharaoh     1023951    1031000    idle       256        0/256/0/256
radeon      62212      64000      idle       8          0/8/0/8
secretariat 977100     1031000    idle       256        0/256/0/256

```
Note: example is for compute partition.

or in GiB

```bash
printf "%-11s %10s %10s %-10s %10s %15s\n" NODELIST FREE_GiB MEM_GiB STATE CPUS "CPUS(A/I/O/T)"
sinfo -h -o "%11n %10e %10m %10t %10c %15C" -p nvidia |
awk '{printf "%-11s %10.1f %10.1f %-10s %10s %15s\n", $1, $2/1024, $3/1024, $4, $5, $6}'
```
```
NODELIST      FREE_GiB    MEM_GiB STATE            CPUS   CPUS(A/I/O/T)
hudson          1353.8     1464.8 mix-              192    16/176/0/192
milan0           826.4     1005.9 mix-              128    16/112/0/128
milan2           873.8     1005.9 mix               128    16/112/0/128
oswald00         249.9      251.6 idle               32       0/32/0/32
oswald02         234.4      251.6 idle               32       0/32/0/32
oswald03         249.6      251.6 idle               32       0/32/0/32
spike             69.0       72.6 idle               24       0/24/0/24
zenith2            1.7      244.1 idle               64       0/64/0/64
```
Note: example is for the nvidia partition.

With memory available for allocation:

Bash:
```bash
printf "%-11s %10s %10s %-10s %10s %15s\n" NODELIST AVAIL_GiB MEM_GiB STATE CPUS "CPUS(A/I/O/T)"
sinfo -h -N -p nvidia -o "%n %m %t %c %C" |
while read -r node mem state cpus cpualloc; do
    alloc=$(scontrol show node "$node" -o | sed -n 's/.*AllocMem=\([0-9]*\).*/\1/p')
    awk -v n="$node" -v m="$mem" -v a="$alloc" -v s="$state" -v c="$cpus" -v ca="$cpualloc" \
        'BEGIN { printf "%-11s %10.1f %10.1f %-10s %10s %15s\n", n, (m-a)/1024, m/1024, s, c, ca }'
done
```

Fish:
```fish
printf "%-11s %10s %10s %-10s %10s %15s\n" NODELIST AVAIL_GiB MEM_GiB STATE CPUS "CPUS(A/I/O/T)"
sinfo -h -N -p nvidia -o "%n %m %t %c %C" | while read -l node mem state cpus cpualloc
    set alloc (scontrol show node "$node" -o | string match -r 'AllocMem=\K[0-9]+')
    set avail_gib (math "($mem - $alloc) / 1024")
    set mem_gib (math "$mem / 1024")

    printf "%-11s %10.1f %10.1f %-10s %10s %15s\n" \
        $node $avail_gib $mem_gib $state $cpus $cpualloc
end
```

### Custom `sinfo` to show GRES and GRES Used.

```bash
sinfo -O 'PartitionName,NodeList:80,Gres:40,GresUsed:80'
```
```
PARTITION           NODELIST                                                                        GRES                                    GRES_USED
compute             affirmed,apachepass,excl-us03,justify,milan3,oswald,pharoah,quad[01-02],secretar(null)                                  gpu:0,fpga:0,groq:0
compute             cousteau                                                                        gpu:MI100:2                             gpu:MI100:0(IDX:N/A),fpga:0,groq:0
compute             explorer                                                                        gpu:MI60:2                              gpu:MI60:0(IDX:N/A),fpga:0,groq:0
compute             milan0                                                                          gpu:A100:2(S:0)                         gpu:A100:0(IDX:N/A),fpga:0,groq:0
compute             oswald[00,02-03]                                                                gpu:p100:1                              gpu:p100:0(IDX:N/A),fpga:0,groq:0
compute             radeon                                                                          gpu:Radeon-V7:1                         gpu:Radeon-V7:0(IDX:N/A),fpga:0,groq:0
compute             milan[1-2]                                                                      groq:card:1                             gpu:0,fpga:0,groq:card:0
leconte             leconte                                                                         gpu:V100:6(S:0-87)                      gpu:V100:0(IDX:N/A),fpga:0,groq:0
thunderx            thunderx                                                                        (null)                                  gpu:0,fpga:0,groq:0
milan               milan0                                                                          gpu:A100:2(S:0)                         gpu:A100:0(IDX:N/A),fpga:0,groq:0
milan               milan3                                                                          (null)                                  gpu:0,fpga:0,groq:0
milan               milan[1-2]                                                                      groq:card:1                             gpu:0,fpga:0,groq:card:0
fpgabuild           serenity,serenity[01-03]                                                        (null)                                  gpu:0,fpga:0,groq:0
fpgarun             firefly                                                                         fpga:U250:1                             gpu:0,fpga:U250:1,groq:0
fpgabuild_20_2      serenity,serenity[01-03]                                                        (null)                                  gpu:0,fpga:0,groq:0
fpgarun_20_2        firefly                                                                         fpga:U250:1                             gpu:0,fpga:U250:1,groq:0
fpgabuild_21_2      icarus[00-01]                                                                   (null)                                  gpu:0,fpga:0,groq:0
fpgarun_21_2        intrepid                                                                        fpga:U250:1,fpga:U55C:1                 gpu:0,fpga:U250:0,fpga:U55C:0,groq:0
neurorad            icarus[00-01],serenity,serenity[01-03]                                          (null)                                  gpu:0,fpga:0,groq:0
gpu                 zenith                                                                          gpu:RTX3090:1,gpu:RD6900:1              gpu:RTX3090:0(IDX:N/A),gpu:RD6900:0(IDX:N/A),fpga:0,groq:0
groq                milan[1-2]                                                                      groq:card:1                             gpu:0,fpga:0,groq:card:0

```

### Finding max RAM used by a completed job.

You can also use `sacct` to see the MAXRSS to see the max memory used by a job. This is helpful when figuring out how much memory jobs like it will need.  
  
```
sacct -j <jobid> --format JobID,JobName,MaxRSS
```

{% hint style="info" %}
**Note** that Slurm specifies and reports KB and GB, but means KiB and GiB. See [Add information about GB vs GiB when configuring memory by guillaumeeb · Pull Request #269 · dask/dask-jobqueue (github.com)](https://github.com/dask/dask-jobqueue/pull/269/files).
{% endhint %}

# Slurm Exclusive Systems

Specific, high demand systems will be made Slurm Exclusive. Which means that use of the systems requires a Slurm allocation. This will help with coordinating sharing of the resources of that system.

On these systems, the [pam_slurm_adopt](https://slurm.schedmd.com/pam_slurm_adopt.html) module will be used to limit SSH access to users who have a Slurm allocation on the node. Additionally, the SSH session will be constrained to the same resources as were allocated. We hope that this policy will help will resource sharing without getting in the way of the work. To help with running on these systems some example commands are provided.

## Run on a specific GPU interactively

Request two P100 GPUs with 128 GiB of memory and 16 CPU cores.

```bash
srun -p nvidia --gres gpu:P100:2 --mem 128G -c 16 --pty bash
```

Running this command opens a bash shell on the system with the requested resources. Future `ssh` sessions to this system will fall under the same allocation.

## Request exclusive access on the node

Request exclusive access to Hudson.

```
srun -p nvidia -w hudson --exclusive --pty bash
```

Now you can also SSH into Hudson.

# Using the Preemptable GPU Queue (`nvidia-long`)

The **`nvidia-long`** queue provides **opportunistic GPU access** for long-running or flexible workloads.
Jobs in this queue may be **preempted** when higher-priority work arrives.

Preemption allows better overall cluster utilization, but **your job must be written to tolerate interruption**.

---

## What “Preemptable” Means

Jobs submitted to **`nvidia-long`**:

- Run when GPUs are idle
- May be **stopped at any time**
- Are **requeued** instead of canceled *only if you request it*
- May restart multiple times

The normal GPU queue (**`nvidia`**) is **not preempted**.

---

## Important Cluster Policy

The cluster is configured with:

```ini
PreemptType=preempt/partition_prio
PreemptMode=REQUEUE
JobRequeue=0
```

### What this means for users

- Preemption is **enabled**
- Preempted jobs are **eligible** to be requeued
- **Jobs are NOT requeueable by default**
- You **must explicitly request requeue behavior**

If you do **not** request requeue:

- Your job will be **canceled** when preempted
- Partial work will be lost

---

## Submitting a Preemptable Job

### Basic submission

```bash
sbatch -p nvidia-long my_job.sh
```

⚠️ This job **will be canceled on preemption** unless you also add `--requeue`.

---

## Making Your Job Requeueable (REQUIRED)

To allow your job to be restarted after preemption, **you must include**:

```bash
#SBATCH --requeue
```

### Example job script

```bash
#!/bin/bash
#SBATCH -p nvidia-long
#SBATCH --requeue
#SBATCH --job-name=my-long-job
#SBATCH --time=7-00:00:00
#SBATCH --gres=gpu:1

./run_my_workload.sh
```

---

## Handling Preemption Gracefully (Strongly Recommended)

When a job is preempted, Slurm sends a **SIGTERM** signal before stopping it.

You should:

- Catch the signal
- Save checkpoints
- Exit cleanly

### Example with signal handling

```bash
#!/bin/bash
#SBATCH -p nvidia-long
#SBATCH --requeue
#SBATCH --signal=B:TERM@60   # 60 seconds warning

checkpoint() {
    echo "Preempted – saving state..."
    ./save_checkpoint.sh
    exit 0
}

trap checkpoint SIGTERM

./run_my_workload.sh
```

This gives your job **60 seconds** to checkpoint before requeue.

---

## How Requeued Jobs Behave

When a requeueable job is preempted:

- It transitions to `PENDING (BeginTime)`
- Slurm may delay restart briefly to avoid thrashing
- `scontrol show job` will show:

  - `Restarts=1` (or higher)
  - `Requeue=1`

This is **expected behavior**.

---

## Monitoring Preemptable Jobs

### Check job status

```bash
squeue -j <jobid>
```

### See restart count

```bash
scontrol show job <jobid> | grep -i restart
```

### View job history

```bash
sacct -j <jobid> --format=JobID,State,Reason,Elapsed
```

---

## When to Use `nvidia-long`

**Good fits**

- Parameter sweeps
- Model training with checkpoints
- Monte Carlo workloads
- Long experiments without strict deadlines

**Not recommended**

- Jobs that cannot restart
- Short, latency-sensitive runs
- Jobs without checkpointing

---

## Summary

| Queue         | Preemptable | Requires `--requeue` | Intended Use              |
| ------------- | ----------- | -------------------- | ------------------------- |
| `nvidia`      | ❌ No        | N/A                  | Normal GPU jobs           |
| `nvidia-long` | ✅ Yes       | ✅ Yes                | Opportunistic / long jobs |

### Key takeaways

- ✔ `nvidia-long` jobs **can be interrupted**
- ✔ **Always use `--requeue`** if you want your job restarted
- ✔ Handle `SIGTERM` and checkpoint frequently
- ✔ Expect jobs to restart multiple times

## Additional Resources

For general Slurm use and reference, see [Job Submission with Slurm - CADES User Documentation](https://docs.cades.ornl.gov/condos/how-to-use/execute-a-slurm-job/), [CADES Cheat Sheet](https://docs.cades.ornl.gov/cheatsheet/cades_cheatsheet.pdf), and [Cheat Sheet | ExCL User Docs](https://docs.excl.ornl.gov/#excl-cheat-sheet).
