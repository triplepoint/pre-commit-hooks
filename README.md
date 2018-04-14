# Introduction
This repo contains a collection of custom pre-commit hook scripts, intended to be used with the [Pre-Commit](https://pre-commit.com/) framework.


# Usage
With the Pre-Commit framework installed (see below), a Git repository with a properly configured `.pre-commit-config.yaml` file in its root directory, and in which `pre-commit install` has been run, will apply the specified pre-commit hooks before applying a Git commit.

## Install The Pre-Commit Framework
Complete information can be found in the  [Pre-Commit installation instructions](https://pre-commit.com/#install), but the most straightforward method would be:
``` bash
pip install pre-commit --upgrade
```

Environments without this package installed cannot execute the pre-commit hooks, even if a repo has a `.pre-commit-config.yaml` file.

## Enable Pre-Commit for a Repository
Each clone of a repository needs to have `Pre-Commit` enabled once, before hooks will automatically execute.  This can be done with:
``` bash
cd the-repo-in-question
pre-commit install
```

## Configure a Repo's Pre-Commit Hooks
The most complete instructions are available at the [Pre-Commit usage instructions](https://pre-commit.com/#usage), but the specific usage for commit hooks in this repository would be a `.pre-commit-config.yaml` something like:
``` yaml
---
exclude: '^$'
fail_fast: false
repos:
  - repo: https://github.com/triplepoint/pre-commit-hooks
    rev: 1.0.0
    hooks:
      - id: ansible-vault-encrypted
        files: '^.*vault.*\.yml$'
```
Note that in the above example, we're overriding the default `files` field for the `ansible-vault-encrypted` hook.  This is optional behavior; if the `files` field was absent, the hook's defaults (defined in this repo in `.pre-commit-hooks.yaml`) would be used instead.

# Available Hooks
Name                         | Notes
---------------------------- | ---
`ansible-vault-encrypted`    | By default, only files of the form "\*vault\*.yml" are considered for this hook.
