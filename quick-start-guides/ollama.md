---
description: Getting started with Ollama.
---
# Ollama

[Ollama](https://ollama.com/) is deployed in ExCL as a module. To use ollama, load the module, and then you have access to the `ollama` cli interface.

Load the Ollama module with:
```bash
module load ollama
```

Ollama has a server component which stores files in its home. This server component should be launched using a service account by ExCL admin, since it provides ollama for the entire system. Ollama is already running on some of the workers in ExCL. See the output from the model load for an up-to-date list. Contact [excl-help@ornl.gov](mailto:excl-help@ornl.gov) if you would like ollama to be available on a specific system.

## Links

- [Ollama Website](https://ollama.com/)
- [Ollama GitHub](https://github.com/ollama/ollama)
- [Ollama CLI Reference](https://github.com/ollama/ollama?tab=readme-ov-file#cli-reference)
