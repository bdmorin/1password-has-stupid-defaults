1Password Permissions Audit
===========================

This repository contains a pair of small [fish](https://fishshell.com/) scripts that help audit and fix the permissive defaults applied to new vaults in 1Password.

The scripts collect all vaults, groups and users defined in your 1Password account and output commands that remove the ability to print or export items. They rely on the official 1Password command line tool.

## Requirements

* [1Password CLI](https://developer.1password.com/docs/cli/) installed and configured.
* The `fish` shell. The commands can be ported to other shells if desired.
* GNU `parallel` (optional) for running the generated commands quickly.

## Usage

1. Run `op-gen-ids.fish` to gather vault, group and user information and produce `op vault user revoke` and `op vault group revoke` commands for each combination. Redirect the output to a file:

   ```bash
   fish op-gen-ids.fish > revoke.cmd
   ```

2. Execute the commands. For large installations `parallel` speeds things up:

   ```bash
   parallel -j 8 < revoke.cmd
   ```

3. Run `op-audit.fish` to output the current vault/group permissions in JSON form:

   ```bash
   fish op-audit.fish
   ```

The audit script relies on the 1Password CLI cache. If you encounter stale data remove the cache or omit the `--cache` flag inside the script.

## License

This project is released under the MIT license. See the `LICENSE` file for details. A record of changes is kept in `CHANGELOG.md`.

