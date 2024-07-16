---
description: Getting started with self-hosted runners for GitHub CI on ExCL systems.
---
# GitLab CI Runners in ExCL

If you don’t want to run the runner as service then you can follow the steps posted at [Adding self-hosted runners - GitHub Docs](https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners/adding-self-hosted-runners) to create a self-hosted runner in ExCL.

## Setup Runner as a service in ExCL

If you do want to register the runner as a service, the easiest way is to use systemd user services. To set this up follow the steps below.

### Create a user systemd config which is unique to a single system.

```bash
mkdir -p /scratch/$USER/.config/systemd
ln -s /scratch/$USER/.config/systemd /home/$USER/.config/systemd
```

Notes:
- If you are trying this on a system which doesn’t already have a `/scratch` folder the command will fail. Please send an email to [excl-help@ornl.gov](mailto:excl-help@ornl.gov) to create a folder for local storage.
- If you setting up a second runner, the `ln` command will fail if the link already exists. Ensure that the link is a valid link pointing to scratch before continuing with these instructions.

### Create a folder to store the GitHub Runner.

The steps are similar to that posted at [Adding self-hosted runners - GitHub Docs](https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners/adding-self-hosted-runners) with some changes. You will need to create one folder per machine and per repo so I recommend the following structure.

`~/github-runners/<node>-<repo>`

### Download and Configure the Runner.

Once you create this directory and enter it, you will then download and configure the runner. The steps are reproduce below, but you should follow the instructions from the “add new self-hosted runner” page after clicking on “New self-hosted runner”.

```bash
curl -o actions-runner-linux-x64-2.311.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.311.0/actions-runner-linux-x64-2.311.0.tar.gz
tar xzf ./actions-runner-linux-x64-2.311.0.tar.gz
```

```bash
./config.sh --url <url> --token <token>
```

### Patch the Runner Folder for use as a User Systemd Service.

Apply this patch to modify the directory to use user systemd modules.

```bash
patch -p1 < /auto/software/github-runner/excl-patch.diff
```

### Use the `svc.sh` script to install and manage the runner service.

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
systemctl --user disable <service name
```
or
```bash
systemctl --user enable <service name>
```

To stop the service run

```bash
./svc.sh stop
```

To uninstall the service run

```bash
./svc.sh uninstall
```

## Creating a secure, human-in-the-loop CI pipeline for public repos

GitHub Actions [discourages](https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners/about-self-hosted-runners#self-hosted-runner-security) the use of self-hosted runners for public repos. However, if you want to use an ExCL self-hosted runner for a public repo, you can use the following steps to create a secure CI pipeline that is triggered by an authorized user in a PR comment. This will prevent unauthorized users from running arbitrary code (e.g. attacks) automatically on ExCL systems from any PRs.

We follow the resulting workflow yaml file in the JACC.jl [repo](https://github.com/JuliaORNL/JACC.jl/blob/main/.github/workflows/ci-gpu-AMD.yaml) as an example that can be reused across repos.

1. *Select authorized users*: those who can trigger the pipeline and store it in a [GitHub secret](https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions) in your repo using the following format: `CI_GPU_ACTORS=;user1;user2;user3;` and store another secret `TOKENIZER=;` to be used as a delimiter (it can be any character). Users should have a strong password and 2FA enabled.

2. *Trigger on issue_comment*: this is the event that triggers the CI pipeline. The `types: [created]` ensures that the pipeline is triggered only when a new comment is made and not when an existing comment is edited.

    ```yaml
    on:
      issue_comment:
        types: [created]
    ```
    
    > **NOTE**: in GitHub Actions PRs are issues, so the `issue_comment` event is used to trigger the pipeline when a PR comment is made.
    
    
2. *Verify Actor*:  and "actor" is any user writing a comment on the PR. This step verifies that the actor is an authorized user to trigger the CI pipeline. The following is an example of how to verify the actor in the workflow yaml file. `ACTOR_TOKEN` puts the current "actor" within the delimiter and checks if it is in the list of authorized users. If it is, it triggers the pipeline. If not, it skips all subsequent steps.

    ```yaml
    - name: Verify actor
          env:
            ACTOR_TOKEN: ${{secrets.TOKENIZER}}${{github.actor}}${{secrets.TOKENIZER}}
            SECRET_ACTORS: ${{secrets.CI_GPU_ACTORS}}
          if: contains(env.SECRET_ACTORS, env.ACTOR_TOKEN)
          id: check
          run: |
            echo "triggered=true" >> $GITHUB_OUTPUT
    ```

3. *Request PR info*: since the event triggering the pipeline is a `issue_comment` the pipeline needs to retrieve information for the current PR. We use the official `octokit/request-action` [action](https://github.com/octokit/request-action) to get the PR information using the `GITHUB_TOKEN` available automatically from repo [secrets](https://docs.github.com/en/actions/security-guides/automatic-token-authentication#about-the-github_token-secret). This is stored in a json format and available for future steps.

    ```yaml
    - name: GitHub API Request
        if: steps.check.outputs.triggered == 'true'
        id: request
        uses: octokit/request-action@v2.x
        with:
          route: ${{github.event.issue.pull_request.url}}
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
    ```

4. *Create PR status*: this step creates a status check on the PR extracting information from the json information generated in the previous step. This steps allows for seamless integration with the typical checks interface for a PR along with other CI workflow. The status check is created as a "pending" status and the URL is linked to the current pipeline run before the actual tests run.
 
    ```yaml
    - name: Create PR status
        if: steps.check.outputs.triggered == 'true'
        uses: geekdude/github-status-action-v2@v1.1.10
        with:
          authToken: ${{ secrets.GITHUB_TOKEN }}
          context: "ci-gpu-AMD ${{ matrix.jobname }}"
          state: "pending"
          sha: ${{fromJson(steps.request.outputs.data).head.sha}}
          target_url: https://github.com/${{github.repository}}/actions/runs/${{github.run_id}}
    ```

5. *Run tests*: the following steps continue the pipeline tests and they are specific to each workflow reusing these steps.
   
6. *Report PR status*: this step reports the status of the pipeline to the PR. The status is updated to "success" if the tests pass and "failure" if the tests fail. The URL is linked to the current pipeline run to update the PR status created in step 4.

    ```yaml
    - name: Report PR status
        if: always() && steps.check.outputs.triggered == 'true'
        uses: geekdude/github-status-action-v2@v1.1.10
        with:
          authToken: ${{ secrets.GITHUB_TOKEN }}
          context: "ci-GPU-AMD ${{matrix.jobname}}"
          state: ${{job.status}}
          sha: ${{fromJson(steps.request.outputs.data).head.sha}}
          target_url: https://github.com/${{github.repository}}/actions/runs/${{github.run_id}}
    ```

    > **NOTE**: in GitHub Actions statuses are different from checks, see [the docs](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/collaborating-on-repositories-with-code-quality-features/about-status-checks#types-of-status-checks-on-github]) for a better explanation. The statuses generated by this pipeline get reported and stored in the Actions, and not in the PR checks tab. The important part is that the status from this workflow gets reported to the PR, users can see the status of the pipeline and admins can make these statuses mandatory or optional before merging.
