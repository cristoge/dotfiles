# Restore the minimal Gentle Shell status bar

`minimal-status.patch` preserves the local customization made against **gentle-pi 4.8.0**, without storing installed packages, credentials, or sessions. It is a source patch, not a supported Pi settings file; Stow links this backup but does **not** apply it.

## Saved preferences

- Keep Pi's dynamic `system` theme and the rest of its palette unchanged.
- Replace filled/empty gauge blocks with `━` / `─`, keeping eight cells and existing rounding.
- Color filled cells green (`#6fbf83`) below 80%, orange (`#e6a052`) from 80% to below 95%, and red (`#df6b68`) from 95%.
- Keep empty cells in the theme's `border` color and honor explicit theme gauge overrides.
- Hide the entire monetary segment (for example `$0.183 sub`) in status bars and headers, while keeping context, usage percentages, and shortcut hints.
- Keep cost calculations and the Stats spending display intact.

Only `lib/shell-gauge.ts` and `lib/shell-bar.ts` are patched.

## Check after an update

Run from the dotfiles repository root:

```bash
patch_file="$PWD/pi/.pi/agent/patches/minimal-status.patch"
package_dir="$HOME/.pi/agent/npm/node_modules/gentle-pi"

# Read-only: success means the customization is already present.
git -C "$package_dir" apply --reverse --check "$patch_file"

# If it is not already present, check whether it can be restored cleanly.
git -C "$package_dir" apply --check "$patch_file"
```

If the reverse check succeeds, do not reapply. If only the forward check succeeds, review the patch, back up both target files, and apply it manually:

```bash
# Continue in the same shell, with patch_file and package_dir set above.
backup_dir=$(mktemp -d "$package_dir/minimal-status-backup.XXXXXX")
cp "$package_dir/lib/shell-gauge.ts" "$backup_dir/shell-gauge.ts"
cp "$package_dir/lib/shell-bar.ts" "$backup_dir/shell-bar.ts"
printf 'Backup: %s\n' "$backup_dir"
git -C "$package_dir" apply "$patch_file"
```

Run `/reload` in Pi and check the status bar. Updates or reinstalls can overwrite the patch again.

If **both checks fail**, stop: the new release may have changed these renderers or contain only part of the customization. Adapt the patch to that release; do not force it, use `--reject`, or replace whole installed files. Existing package tests that assert the original gauge glyphs or visible costs will need updated expectations when maintaining this patch upstream.
