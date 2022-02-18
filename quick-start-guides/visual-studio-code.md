---
description: Getting started with using VSCode and ExCL.
---

# Visual Studio Code

[Visual Studio Code or VSCode](https://code.visualstudio.com) is a lightweight but powerful source code editor which runs on your desktop and is available for Windows, macOS, and Linux.
The editor has IntelliSense, debugger support, built-in git, and many extensions to add additional support to the editor.
VSCode supports [WSL](https://docs.microsoft.com/en-us/windows/wsl/) and development on remote servers via ssh.
Plugins add language support, linters, and compilers for many languages including Python, C/C++, CMake, and markdown.

## Remote Explorer

The [Remote - SSH](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh) and [Remote - WSL](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl) are both extremely useful to edit code remotely on ExCL or locally in WSL if on a windows machine.
Remote - SSH pulls the ssh targets from the users `.ssh/config` file.
On Linux or MacOS, this process is straightforward and you likely already have an ssh config file setup.
On Windows you have to specify the proxy command to use to proxy into the internal ExCL nodes. Here is an example file:

```sshconfig
Host excl
    HostName login.excl.ornl.gov
    IdentityFile ~/.ssh/id_rsa

Host quad00
    HostName quad00
    ProxyCommand c:/Windows\System32\OpenSSH/ssh.exe -W %h:%p excl
    IdentityFile ~/.ssh/id_rsa

Host *
    User <Username>
    ForwardAgent yes
    ForwardX11 yes
```

Replace `<Username>` with your username.
Other internal system can be added by copying the quad00 entry and modifying the name of the config and the HostName.
It is highly recommended to use a passphrase protected ssh key as the login method.
If you used a different name for the ssh key file, then replace `~/.ssh/id_rsa` with your private key file.
On Windows, this config file is located at `%USERPROFILE%\.ssh\config`.
The config file doesn’t have an extension, but it is a text file that can be edited with vscode.

To avoid typing your ssh passphrase multiple times per login, use an SSH Agent to store the ssh credentials.
See [Setting up the SSH Agent](https://code.visualstudio.com/docs/remote/troubleshooting#_setting-up-the-ssh-agent) for details. On Windows, to enable SSH Agent automatically, start a local Administrator PowerShell and run the following commands:

```powershell
# Make sure you're running as an Administrator
Set-Service ssh-agent -StartupType Automatic
Start-Service ssh-agent
Get-Service ssh-agent
```

On the ExCL side, you can add this code snippet to `~/.bashrc` start the ssh-agent on login:

```bash
# Start the SSH Agent
if [ -z "$SSH_AUTH_SOCK" ] ; then
   eval $(ssh-agent -s)
   # ssh-add
fi
```

**Important:** Since VSCode installs its configuration to your home directory by default and the home directories are stored in NFS, the `Remote.SSH: Lockfiles in Tmp` setting needs to be checked. This setting is easiest to find with the settings search box.

![Remote.SSH: Lockfiles Setting](/assets/2022-02-18-lockfiles-setting.png)

The remote SSH explorer provides the same experience editing code remotely as you get when you are editing locally.
Files that are opened are edited locally and saved to the remote server which helps when you have a slow connection to the remote which makes editing view vim and ssh too irresponsive.
You can also access a remote terminal with `ctl`+\`.
The debuggers also run remotely.
One gotcha is that extensions might need to be installed remotely for them to work properly.
However, this is easy to do by clicking on the extension tab and choosing install local extensions on remote.

The ssh explorer also makes it easy to forward remote ports to the local machine.
This is especially helpful when launching an http server or a jupyter notebook.
See [Jupyter Documentation](/quick-start-guides/jupyter-quick-start.md#detailed-instructions-for-windows-with-visual-studio-code) for details.

## Debugging Using Run and Debug

Edit `launch.json` to define launch configurations according to the [launch configuration documentation](https://code.visualstudio.com/docs/editor/debugging#_launchjson-attributes).

After generating a configuration from a template, the main attributes I add or change are `"cwd"` and `"args"`. `"args"` has to be specified as an array, which is a pain.
One workaround from [github issue 1210](https://github.com/microsoft/vscode-cpptools/issues/1210) suggests replacing `" "` with `","` to avoid space separated arguments.
For arguments with a value, `"="` will need to be added between arguments and the value without spaces.
When specifying `"program"` and `"cwd"` is is helpful to use the built in variables to reference the file or workspace folder.
See [Varibles Reference Documentation](https://code.visualstudio.com/docs/editor/variables-reference).

## Useful Extensions

- GrapeCity.gc-excelviewer
  - Preview CSV files.
- Gruntfuggly.todo-tree
  - View TODOs in a project.
- ms-vsliveshare.vsliveshare
  - Real-time Collaboration.
- ms-vsliveshare.vsliveshare-audio
- mushan.vscode-paste-image
  - Paste images into markdown files.
- vscodevim.vim
  - Use Vim Keybindings in VSCode.

### Remote Work

- ms-vscode-remote.remote-containers
- ms-vscode-remote.remote-ssh
- ms-vscode-remote.remote-ssh-edit
- ms-vscode-remote.remote-wsl

### Linters

- DavidAnson.vscode-markdownlint
  - Lint markdown files.

### Language Support

- lextudio.restructuredtext
- ms-python.python
- ms-python.vscode-pylance
- ms-toolsai.jupyter
- ms-toolsai.jupyter-keymap
- ms-toolsai.jupyter-renderers
- ms-vscode.cmake-tools
- ms-vscode.cpptools
- ms-vscode.cpptools-extension-pack
- ms-vscode.cpptools-themes
- mshr-h.veriloghdl
- puorc.awesome-vhdl
- slevesque.vscode-autohotkey
- twxs.cmake
- yzhang.markdown-all-in-one
  - Supports markdown preview in addition to language support.

### Git

- donjayamanne.githistory
- eamodio.gitlens

### Note Taking/Knowledge Base

- foam.foam-vscode
