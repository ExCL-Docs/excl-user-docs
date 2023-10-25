---
description: Service to host internal documentation for code under development.
---
# DevDocs

This guide goes over hosting internal to ORNL documentation using ExCL’s devdocs VM. For an example of a project which uses devdocs, see [Hunter](https://code.ornl.gov/brisbane/hunter) and [Hunter Documentation](https://devdocs.ornl.gov/brisbane/hunter) ([Source](https://code.ornl.gov/brisbane/hunter/-/tree/master/docs)).

The documentation for hunter is built with GitLab-CI. Here are the relevant lines in .gitlab-ci.yml.

```yaml
stages:
    - docs
    - deploy_docs

before_script:
    - source /auto/ciscratch/conda/etc/profile.d/conda.sh
    - conda env create --force -p ./envs -f environment.yml
    - conda activate ./envs

docs-job:
    tags: [devdocs]
    stage: docs
    script:
        - cd docs
        - pip install sphinx sphinx-rtd-theme sphinx-serve recommonmark myst_parser sphinx-autoapi
        - make html
    artifacts:
        paths:
            - docs/_build/html
  
.deploy_docs_common:
    tags: [devdocs]
    stage: deploy_docs
    needs: [docs-job]
    script:
        - rsync -a --delete docs/_build/html/ ~/www/brisbane/hunter

deploy_docs-job:
    extends: .deploy_docs_common
    only:
        refs:
            - develop
  
deploy_docs_manual-job:
    extends: .deploy_docs_common
    when: manual
```

# Request a DevDocs Site

If you would like to host your project’s internal documentation on ExCL, please email [excl-help@ornl.gov](mailto:excl-help@ornl.gov?subject=Request%20DevDocs%20Site&body=Request%20a%20new%20DevDocs%20internal%20documentation%20site%20and%20DevDocs%20GitLab%20Runner:%0D%0A%0D%0A-%20URL:%20https://code.ornl.gov/%0D%0A-%20Registration%20Token:%20%20%0D%0A-%20Project%20Name%20(DevDocs%20URL%20Subdirectory):) with the following information and we can help you get started with a DevDocs subdirectory and the DevDocs GitLab Runner.

- URL
- [Runner Registration Token](gitlab-ci.md#register-a-runner)
- Project Name (This will be your DevDocs subdirectory)
