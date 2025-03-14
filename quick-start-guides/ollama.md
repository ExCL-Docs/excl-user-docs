---
description: Getting started with Ollama.
---
# Ollama

![](https://ollama.com/public/ollama.png)

[Ollama](https://ollama.com/) is deployed in ExCL as a module. To use Ollama, load the module, and then you have access to the `ollama` CLI interface.

Load the Ollama module with:
```bash
module load ollama
```

Ollama has a server component which stores files in its home. This server component should be launched using a service account by ExCL admin, since it provides ollama for the entire system. Ollama is already running on some of the workers in ExCL. See the output from the model load for an up-to-date list. Contact [excl-help@ornl.gov](mailto:excl-help@ornl.gov) if you would like ollama to be available on a specific system.

## Ollama API

{% hint style="warning" %}
When interacting with the Ollama server via the [REST API](https://github.com/ollama/ollama?tab=readme-ov-file#rest-api) in ExCL, you need to unset the `http_proxy` and `https_proxy` environment variables, since you are trying to connect to an internal http server instead of a remote one.
{% endhint %}

Examples of using the Ollama API can be found at [ollama-python/examples/chat.py](https://github.com/ollama/ollama-python/blob/main/examples/chat.py).

## Links

- [Ollama Website](https://ollama.com/)
- [Ollama GitHub](https://github.com/ollama/ollama)
- [Ollama CLI Reference](https://github.com/ollama/ollama?tab=readme-ov-file#cli-reference)
