# GitLab CI Runners in ExCL

If you don’t want to run the runner as service then you can follow the steps posted at [Adding self-hosted runners - GitHub Docs](https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners/adding-self-hosted-runners) to create a self-hosted runner in ExCL.

## Setup Runner as a service in ExCL

If you do want to register the runner as a service, the easiest way is to use systemd user services. To set this up follow the steps below.

Create a user systemd config which is unique to a single system.

```bash
mkdir -p /scratch/$USER/.config/systemd
ln -s /scratch/$USER/.config/systemd /home/$USER/.config/systemd
```

The steps are similar to that posted at [Adding self-hosted runners - GitHub Docs](https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners/adding-self-hosted-runners) with some changes. You will need to create one folder per machine and per repo so I recommend the following structure.

`~/github-runners/<node>-<repo>`

Once you create this directory and enter it, you will then download and configure the runner. The steps are reproduce below, but you should follow the instructions from the “add new self-hosted runner” page after clicking on “New self-hosted runner”.

```bash
curl -o actions-runner-linux-x64-2.311.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.311.0/actions-runner-linux-x64-2.311.0.tar.gz
tar xzf ./actions-runner-linux-x64-2.311.0.tar.gz
```

```bash
./config.sh --url <url> --token <token>
```

Apply this patch to modify the directory to use user systemd modules.

```bash
patch -p1 < /auto/software/github-runner/excl-patch.diff
```

After this patch is applied the `svc.sh` script works as documented in [Configuring the self-hosted runner application as a service - GitHub Docs](https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners/configuring-the-self-hosted-runner-application-as-a-service?platform=linux). However you don’t need to specify a username since it now defaults to the current user. The commands are reproduced below.

Install service

```bash
./svc.sh install
```

Start service and check status.

```bash
./svc.sh start
./svc.sh status
```

Note: The above install adds the service to auto start on reboot once you log back into the system. If you want to disable or enable this auto starting of the service run.

```bash
systemctl --user enable <service name>
```
or
```bash
systemctl --user disable <service name
```

To stop the service run

```bash
./svc.sh stop
```

To uninstall the service run

```bash
./svc.sh uninstall
```
