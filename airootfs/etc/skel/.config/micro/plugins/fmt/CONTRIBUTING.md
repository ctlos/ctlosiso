# Contributing

Everything below assumes you're using
[the Micro text-editor](https://github.com/zyedidia/micro) and this `fmt`
plugin.

**Tooling for contributions:**

* Use the [editorconfig](http://editorconfig.org/) plugin to keep everything
  uniform, which can be installed by doing `plugin install editorconfig`
* Download and use [luafmt](https://github.com/trixnz/lua-fmt) if you're editing a `.lua`
  file, which can be run with `fmt luafmt`
* Download and use [prettier](https://github.com/prettier/prettier) if you're editing a `.md`
  file, which can be run with `fmt prettier`

## Git workflow

First fork the repo, create a branch from `master`, push your changes to your repo, then submit a PR.

Please don't commit tons of changes in one big commit. Instead, use `git add -p` to selectively add lines.

When making changes, put a short blurb about it under `Unreleased` in the `CHANGELOG.md`.  
Make sure to adhear to the [Keep a changelog](http://keepachangelog.com/en/1.0.0/) format.

Changes to `.md` files can be left out of the changelog.

## Adding another formatter

To see if Micro supports the filetype, open the file and run `show filetype`.  
If the filetype is not known by Micro (displayed as `Unknown`), then use the file extension without the period as the "language".

The `insert()` function is used to insert a formatter into the table.

### Using insert

Both `filetype` and/or `args` can be in tables for multiple filetypes or args.

If no args are needed, don't put any in. So no empty string for args, just leave
it out.

Do NOT concat any args/filetypes, even when one arg depends on another.
Everything must be seperate strings.

If an arg depends on another, put them in order, such as `"--arg", "arginput"`

Note that, regardless of how you structure the `insert()` code, the file path is always the last "argument".  
If you have an arg that requires the filepath, then put it at the very end.
