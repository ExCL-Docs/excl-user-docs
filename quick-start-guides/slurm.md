---
description: Getting Started with Slurm in ExCL with best practice recommendations.
---
# Getting Started with Slurm

For general Slurm use, see [Job Submission with Slurm - CADES User Documentation](https://docs.cades.ornl.gov/condos/how-to-use/execute-a-slurm-job/) and the cheat sheet at [Cheat Sheet | ExCL User Docs](https://docs.excl.ornl.gov/#excl-cheat-sheet).

Here is a recommended Slurm sbatch script template:

```bash
#!/bin/bash

#SBATCH --job-name=test
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=youngar@ornl.gov
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
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

### Run Command
echo Run Task

echo --------------------------------------------------------------------------------
echo Finished: $(date)
```

# Using the Preemptable GPU Queue (`nvidia-long`)

The **`nvidia-long`** queue provides **opportunistic GPU access** for long-running or flexible workloads.
Jobs in this queue may be **preempted** when higher-priority work arrives.

Preemption allows better overall cluster utilization, but **your job must be written to tolerate interruption**.

---

## What “Preemptable” Means

Jobs submitted to **`nvidia-long`**:

* Run when GPUs are idle
* May be **stopped at any time**
* Are **requeued** instead of canceled *only if you request it*
* May restart multiple times

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

* Preemption is **enabled**
* Preempted jobs are **eligible** to be requeued
* **Jobs are NOT requeueable by default**
* You **must explicitly request requeue behavior**

If you do **not** request requeue:

* Your job will be **canceled** when preempted
* Partial work will be lost

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

* Catch the signal
* Save checkpoints
* Exit cleanly

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

* It transitions to `PENDING (BeginTime)`
* Slurm may delay restart briefly to avoid thrashing
* `scontrol show job` will show:

  * `Restarts=1` (or higher)
  * `Requeue=1`

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

* Parameter sweeps
* Model training with checkpoints
* Monte Carlo workloads
* Long experiments without strict deadlines

**Not recommended**

* Jobs that cannot restart
* Short, latency-sensitive runs
* Jobs without checkpointing

---

## Summary

| Queue         | Preemptable | Requires `--requeue` | Intended Use              |
| ------------- | ----------- | -------------------- | ------------------------- |
| `nvidia`      | ❌ No        | N/A                  | Normal GPU jobs           |
| `nvidia-long` | ✅ Yes       | ✅ Yes                | Opportunistic / long jobs |

### Key takeaways

✔ `nvidia-long` jobs **can be interrupted**
✔ **Always use `--requeue`** if you want your job restarted
✔ Handle `SIGTERM` and checkpoint frequently
✔ Expect jobs to restart multiple times
