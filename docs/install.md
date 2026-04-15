# Install

## Requirements

- Ubuntu 24.04
- sudo access
- internet connection for package installation

## Install command

From the repo root:

```bash
bash install.sh
```

## What the installer does

The installer currently:

1. checks OS compatibility
2. checks the active user
3. verifies core dependencies
4. installs baseline CLI packages
5. installs GitHub CLI
6. installs Python tooling
7. installs Node.js tooling
8. installs SQLite
9. installs tmux
10. installs cron
11. creates the Buildiful workspace
12. writes machine profile
13. initializes install log
14. installs branding stub
15. installs the BOS CLI
16. writes install state

## After install

Recommended commands:

```bash
bos version
bos status
bos doctor
```
