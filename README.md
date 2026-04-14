# Buildiful OS [Founder Edition]

Buildiful OS [Founder Edition] is a free local-first workspace layer for Ubuntu 24.04 that helps you turn your own computer into a structured AI agent workstation.

It is designed as a clean starting point for building local-first agent setups on your own machine, especially alongside the Buildiful ebook series.

## What this repo is

This repo provides an installer-driven BOS foundation that:

* checks for Ubuntu 24.04 compatibility
* prepares a Buildiful workspace under your user home
* installs a practical command-line baseline
* installs Python and Node tooling
* writes machine profile and install state files
* creates a local structure for future agent packs

## What this repo is not

This repo is not:

* a full Linux distro replacement
* a polished commercial app marketplace
* a complete agent pack library
* a guarantee of production-grade automation for finance, security, or other sensitive use cases

Buildiful OS [Founder Edition] is intentionally lightweight. It is meant to be a credible and useful base layer.

## Why it exists

We are publishing a series of ebooks around building your own local-first AI agent systems.

BOS [Founder Edition] exists to give those builds a cleaner starting point than a plain Ubuntu machine alone.

Instead of beginning from a completely blank system, readers can start with:

* a recognizable Buildiful workspace
* a predictable file structure
* a small BOS command surface
* baseline local tooling
* a path for future pack-style expansion

## Current status

This is an early Founder Edition release.

The goal of this version is to install cleanly, stay understandable, and provide a solid base for future local-first agent packs.

## Requirements

* Ubuntu 24.04
* sudo access
* internet connection for package installation

## Quick install

```bash
bash install.sh
```

## What gets created

BOS creates a Buildiful workspace in your home directory.

Typical folders include:

* `~/Buildiful/apps`
* `~/Buildiful/config`
* `~/Buildiful/data`
* `~/Buildiful/logs`

Later versions may expand this structure further.

## Included baseline tooling

Depending on your machine state, the installer may ensure availability of tools such as:

* curl
* git
* jq
* unzip
* zip
* htop
* tree
* Python tooling
* Node.js
* SQLite
* tmux
* cron
* GitHub CLI

## Intended use

BOS [Founder Edition] is meant to be used as the base layer for workflows such as:

* turning a normal computer into an AI agent workstation
* experimenting with local-first agents
* following Buildiful ebooks and future pack guides
* organizing apps, data, logs, and machine metadata in a repeatable way

## Roadmap direction

Near-term priorities include:

* a BOS command interface
* improved local docs
* backup/export helpers
* sample pack manifests
* a lightweight home screen
* better troubleshooting and install diagnostics

## License

Add your preferred license here.