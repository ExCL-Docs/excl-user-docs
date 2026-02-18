---
description: Getting started with Marimo.
---
# Marimo

Thank you Chen Zhang for the presentation materials to learn about and get started with [Marimo](https://marimo.io/).
Marimo works well in ExCL and can be set up to work with the Ollama instance running in ExCL to enable the AI features.

A Marimo server running on a worker node can be accessed either with VS Code’s automated port forwarding or via [FoxyProxy](https://docs.excl.ornl.gov/quick-start-guides/excl-remote-development#setup-foxyproxy)

## Quick Start

Very quick start using [uv](https://docs.excl.ornl.gov/quick-start-guides/python#how-to-install-uv) and [FoxyProxy](https://docs.excl.ornl.gov/quick-start-guides/excl-remote-development#setup-foxyproxy).

```bash
uv tool run marimo edit test.py --host $hostname
```

Then copy and paste the provided URL into a browser with FoxyProxy set up.

## Presentation

[Download Marimo Quick-start Presentation](https://github.com/ExCL-Docs/excl-user-docs/raw/master/assets/Marimo_ChenZhang.pdf)

{% embed url="https://excl-docs.github.io/excl-user-docs/Marimo_ChenZhang.pdf" %}
