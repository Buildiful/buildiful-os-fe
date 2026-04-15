# Troubleshooting

## Installer permission denied

If a module fails with a permission error, run it through `bash` from `install.sh` instead of relying on executable bits alone.

## BOS command not found

If `bos` is not available after installation, rerun:

```bash
bash modules/install_cli.sh
```

Then check:

```bash
bos version
```

## Missing directories or state files

Run:

```bash
bos status
bos doctor
```

These commands help identify whether the Buildiful workspace, machine profile, or install state are missing.

## Missing tools

If a tool such as `pip3`, `sqlite3`, or `gh` is missing, rerun the installer or the corresponding module.

## Backup not working

`bos backup` requires the Buildiful workspace to exist and at least one of these paths to be present:

- `~/Buildiful/config`
- `~/Buildiful/data`
- `~/Buildiful/logs`
- `~/Buildiful/apps`
