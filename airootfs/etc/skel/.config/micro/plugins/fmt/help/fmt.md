# fmt plugin

To manually run formatting on the current file, use the `fmt` command.

To manually run a specific formatter on the current file, use the `fmt formattername` command.

When saving a supported file-type, the plugin will automatically run on the file
& save any changes, unless you set `fmt-onsave` to false.

To get the list of supported languages/formatters, run the `fmt list` command.  
A table of supported formatters will be printed to Micro's log.

To set a formatter to be used on a specific language, run `set languagename-formatter formattername`.  
The specific names can be found in the list from `fmt list`

To set a formatter to be used on all its supported languages, run `fmt setall formattername`.

To unset all options using a specified formatter, run `fmt unsetall formattername`.

To refresh the in-memory settings, run `fmt update`.  
This is useful if you changed your editor settings, or added a config file to your working directory.

Please note that formatting of all languages is disabled by default, as to not accidentally
format your files. You must enable them individually for this plugin to do
anything.

## What's Bundled?

No formatters are bundled with this plugin. You must install the formatter you
want or it won't work.

Some config files are bundled with this plugin, but are only used when one can't
be found in your dir.

## Config Files

If you added a config file and want to update settings, run `fmt update` to
force settings to refresh.

The fallback paths to the bundled config files don't have hard-coded names, so
you can delete/edit the one in the relevant folder, and it should still work.

#### Using Custom Formatter/Args

You can add your own formatter, or just use different args, by adding its command (and filetype) into `settings.json`  
The format looks like `"fmt|js": "prettier --write"` in your `settings.json`.

Note that you must use the filetype detected by Micro, and if it's `Unknown` then use it's literal filetype extension (ex: `p` for Pawn)  
You can check a file's type by running `show filetype`
