---
description: Getting Started with Julia in ExCL with best practice recommendations.
---
# Julia

See [The Julia Programming Language](https://julialang.org/) to learn more about Julia.

Use `module load julia` to load the Julia tooling on an ExCL system.

## Julia VSCode Extension in ExCL.

Since Julia is install and loaded as a module, the [Julia VSCode extension](https://marketplace.visualstudio.com/items?itemName=julialang.language-julia) has trouble finding the Julia executable needed to run properly.
Therefore to use the extension on ExCL worker nodes via [VSCode](visual-studio-code.md) Remote SSH, you must explicitly set the Julia executable location to the correct path.

This can be done by setting the  `julia.executablePath` to point to the Julia executable that the extension should use, which is this case is the one loaded by the module load command for the version of Julia you want to use.
Once set, the extension will always use that version of Julia.
To edit your configuration settings, execute the `Preferences: Open User Settings` command (you can also access it via the menu `File->Preferences->Settings`), and then make sure your user settings include the `julia.executablePath` setting.
The format of the string should follow your platform specific conventions, and be aware that the backlash `\` is the escape character in JSON, so you need to use `\\` as the path separator character on Windows.

To find the proper path to Julia, you can use `which julia` after the module load command.
At the time of writing this page, the default version of Julia installed on ExCL is 1.10.4 and the `julia.executablePath` should be set as shown below.

```json
"julia.executablePath": "/auto/software/swtree/ubuntu22.04/x86_64/julia/1.10.4/bin/julia"
```
