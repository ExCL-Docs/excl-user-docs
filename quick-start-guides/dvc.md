---
description: Getting started with DVC on ExCL systems.
---
# DVC on ExCL — Quick Start Guide

[DVC](https://dvc.org/) (Data Version Control) is a **content-addressable data management system** that integrates with Git. On ExCL, DVC enables **shared, deduplicated storage** across projects using a common cache.

DVC works well with ExCL. On ExCL, data can be stored in a shared cache in the project folder. Outside of ExCL, this same cache, can be used as the remote data storage.

---

## 🚀 What You Get on ExCL with shared data cache

* **Shared cache across repositories** → no duplicate datasets
* **Content-addressed storage** → automatic change detection
* **Reproducible pipelines (optional)**
* **Git-based versioning for data pointers**
* **Flexible remote syncing (for off-cluster use)**

---

## ⚡ Quick Start (New Repository)

### 1. Install DVC

```bash
uv tool install dvc[ssh]
```

---

### 2. Initialize a Repository

```bash
git init
dvc init

# Auto-stage DVC changes into git
dvc config core.autostage true
```

---

### 3. Configure Shared Cache (ExCL)

```bash
# Set cache directory path to shared project cache location
dvc cache dir /auto/project/<project>/dvc-cache

# Enable group sharing of cache
dvc config cache.shared group

# Use symlinks (recommended on ExCL)
dvc config cache.type symlink
```

{% hint style="warning" %}
This can also be skipped and done instead at the instance level to better support using the repo on non-ExCL systems. See [Post Clone Steps on ExCL | ExCL User Docs](https://docs.excl.ornl.gov/quick-start-guides/dvc#on-excl-shared-cache).
{% endhint %}

---

## 📦 Adding Data

```bash
dvc add data/my-dataset

git add data/my-dataset.dvc .gitignore
git commit -m "Track dataset with DVC"
```

---

## 🔄 Getting Data

```bash
dvc checkout
```

If cache settings changed:

```bash
dvc checkout --relink
```

---

## 🧰 Helpful Commands

```bash
# Show configuration (with source)
dvc config -l --show-origin

# Check data status vs cache/remote
dvc status -c

# Fix workspace links after config change
dvc checkout --relink

# Make git repo group-writable (shared repos)
# This is useful if you want to share a git DVC repo in project space.
git config core.sharedRepository group
```

---

## 🧑‍🤝‍🧑 Cloning a DVC Repository and Post Clone Steps

### On ExCL (shared cache)

```bash
git clone <repo>
cd <repo>
```
```bash
# Set cache directory path to shared location
dvc config --local cache.dir /auto/project/<project>/dvc-cache
# Share cache with your group
dvc config --local cache.shared group
# Use symlinks to map files from the cache.
dvc config --local cache.type symlink
```
```bash
dvc checkout
```

{% hint style="info" %}
With ExCL’s shared cache, `dvc push` and `dvc pull` are not needed, only `dvc checkout` and `dvc checkout --relink`.
{% endhint %}

---

### Outside ExCL (remote usage)

```bash
git clone <repo>
cd <repo>
```
```bash
# Set the remote to be ExCL's DVC cache
dvc remote add -d --local excl ssh://login.excl.ornl.gov/auto/project/<project>/dvc-cache

# Default is reflink,copy so if reflink is not supported, you will want to change it. Check for supported types with `dvc version`. Symlink is recommended if reflink is not an option.
dvc config --local cache.type symlink
```
```bash
# Sync data
dvc pull
```

{% hint style="info" %}
For systems outside of ExCL’s, treat ExCL as a DVC remote and use `dvc push` and `dvc pull` to synchronize files to and from your local cache.
{% endhint %}

---

## 🧠 Mental Model

* Git tracks **small metadata files** (`.dvc`)
* DVC cache stores **actual data (by hash)**
* Workspace files are **symlinks into the cache**
* Multiple repos → **same shared cache → no duplication**

---

## 🗒️ Best Practices on ExCL

* Use a **shared project cache** (`/auto/project/…`)
* Always run `dvc checkout` after cloning
* Prefer `cache.type symlink` for data sharing and clarity
* Avoid unnecessary pipeline re-runs (be careful with dependencies)
* Periodically review cache usage (`dvc gc` with care)

---

## 📊 When to Use DVC vs. \<Insert Existing Workflow\>

### Use DVC when:

* You want **reproducibility and versioned datasets**
* Multiple repos need to **share large datasets**
* You want **content-based tracking instead of paths**

### Use existing workflow when:

* You have **large exploratory runs (e.g., DEFFE)**
* Data is **expensive to recompute**, or you have bespoke processes.
* You prefer **manual control and simpler tooling**

---

## 🔁 Key Change from Simple Data Storage Approach

Instead of:

```
/path/to/data/file
```

You reference:

```
(repo, git commit, dvc-tracked file)
```

→ Data becomes **portable, versioned, and reproducible**

---

## 🧹 Notes on Cache Management

* Cache grows over time (content-addressed)
* Use:

```bash
dvc gc
```

{% hint style="warning" %}
Only run with care in shared environments (can remove needed data)
{% endhint %}

{% hint style="warning" %}
Note that enabling soft/hard links causes DVC to protect the linked data because editing them in-place would corrupt the cache. See [`dvc unprotect`](https://doc.dvc.org/command-reference/unprotect).
{% endhint %}

{% hint style="warning" %}
Using [`dvc gc`](https://doc.dvc.org/command-reference/gc) with a shared cache may delete data needed in another project! See more info about [cleaning a shared cache](https://doc.dvc.org/command-reference/gc#cleaning-shared-cache-or-remote) safely.
{% endhint %}
