# fmt-micro

[![GitHub tag](https://img.shields.io/github/tag/sum01/fmt-micro.svg)](https://github.com/sum01/fmt-micro/releases)

This is a multi-language formatting plugin for the [Micro text-editor.](https://github.com/zyedidia/micro)

This plugin does NOT bundle any formatters, so you must install whichever you want to use.

**Installation:** Just run `plugin install fmt` and restart Micro :+1:

## Language Support

Is your favorite formatter missing? Make a request in [the issue tracker](https://github.com/sum01/fmt-micro/issues), or [submit a PR](./CONTRIBUTING.md#adding-another-formatter) :smile:

| Language     | Supported Formatter(s)                  |
| :----------- | :-------------------------------------- |
| C            | [clang-format], [uncrustify]            |
| C#           | [uncrustify]                            |
| C++          | [clang-format], [uncrustify]            |
| CSS          | [csscomb], [js-beautify], [prettier]    |
| Clojure      | [cljfmt]                                |
| CoffeeScript | [coffee-fmt]                            |
| Crystal      | [crystal]                               |
| D            | [dfmt], [uncrustify]                    |
| Dart         | [dartfmt]                               |
| Elm          | [elm-format]                            |
| Fish         | [fish_indent]                           |
| Flow         | [prettier]                              |
| Fortran      | [fprettify]                             |
| Go           | [gofmt], [goimports]                    |
| GraphQL      | [prettier]                              |
| HTML         | [htmlbeautifier], [js-beautify], [tidy] |
| Haskell      | [stylish-haskell]                       |
| JSON         | [prettier]                              |
| JSX          | [prettier]                              |
| Java         | [uncrustify]                            |
| JavaScript   | [js-beautify], [prettier]               |
| LaTeX        | [latexindent]                           |
| Less         | [prettier]                              |
| Lua          | [luafmt]                                |
| Markdown     | [prettier]                              |
| Marko        | [marko-prettyprint]                     |
| OCaml        | [ocp-indent]                            |
| Objective-C  | [clang-format], [uncrustify]            |
| PHP          | [php-cs-fixer]                          |
| Pawn         | [uncrustify]                            |
| Perl         | [perltidy]                              |
| Pug          | [pug-beautifier-cli]                    |
| Puppet       | [puppet-lint]                           |
| Python       | [autopep8], [yapf]                      |
| Ruby         | [rubocop], [rufo]                       |
| Rust         | [rustfmt]                               |
| Sass         | [prettier]                              |
| Shell        | [beautysh], [sh]                        |
| TypeScript   | [prettier], [tsfmt]                     |
| Vala         | [uncrustify]                            |
| XML          | [tidy]                                  |
| YAML         | [align-yaml]                            |

### Usage

The formatter will run on-save, unless `fmt-onsave` is set to false.

Run `help fmt` to bring up a help file while in Micro.

#### Commands

* `fmt` to run the formatter on the current file.
* `fmt formattername` to run the specified formatter on the current file without affecting your settings.
* `fmt list` to output the supported formatters to Micro's log.
* `fmt update` to force an update of the in-memory formatter settings.  
  Useful for after adding a config file, or changing editor settings.
* `fmt setall formattername` to set the specified formatter to be used in all the options of its supported language types.
* `fmt unsetall formattername` to unset all settings the specified formatter is currently set to.  
  This is useful for if you uninstalled a formatter.

#### Using Custom Formatter/Args

You can add your own formatter, or just use different args, by adding its command (and filetype) into `settings.json`  
The format looks like `"fmt|js": "prettier --write"` in your `settings.json`.

Note that you must use the filetype detected by Micro, and if it's `Unknown` then use it's literal filetype extension (ex: `p` for Pawn)  
You can check a file's type by running `show filetype`

<!-- Table links to make the table easier to read in source -->

[align-yaml]: https://github.com/jonschlinkert/align-yaml
[autopep8]: https://github.com/hhatto/autopep8
[beautysh]: https://github.com/bemeurer/beautysh
[clang-format]: https://clang.llvm.org/docs/ClangFormat.html
[cljfmt]: https://github.com/snoe/node-cljfmt
[coffee-fmt]: https://github.com/sterpe/coffee-fmt
[crystal]: https://github.com/crystal-lang/crystal
[csscomb]: https://github.com/csscomb/csscomb.js
[dartfmt]: https://github.com/dart-lang/dart_style
[dfmt]: https://github.com/dlang-community/dfmt
[elm-format]: https://github.com/avh4/elm-format
[fish_indent]: https://fishshell.com/docs/current/commands.html#fish_indent
[gofmt]: https://golang.org/cmd/gofmt/
[goimports]: https://godoc.org/golang.org/x/tools/cmd/goimports
[htmlbeautifier]: https://github.com/threedaymonk/htmlbeautifier
[js-beautify]: https://github.com/beautify-web/js-beautify
[latexindent]: https://github.com/cmhughes/latexindent.pl
[luafmt]: https://github.com/trixnz/lua-fmt
[marko-prettyprint]: https://github.com/marko-js/marko-prettyprint
[ocp-indent]: https://www.typerex.org/ocp-indent.html
[perltidy]: http://perltidy.sourceforge.net/
[pug-beautifier-cli]: https://github.com/lgaticaq/pug-beautifier-cli
[fprettify]: https://github.com/pseewald/fprettify
[rubocop]: https://github.com/bbatsov/rubocop
[rufo]: https://github.com/ruby-formatter/rufo
[rustfmt]: https://github.com/rust-lang-nursery/rustfmt
[sh]: https://github.com/mvdan/sh
[stylish-haskell]: https://github.com/jaspervdj/stylish-haskell
[tidy]: http://www.html-tidy.org/
[tsfmt]: https://github.com/vvakame/typescript-formatter
[php-cs-fixer]: https://github.com/friendsofphp/PHP-CS-Fixer
[prettier]: https://github.com/prettier/prettier
[puppet-lint]: http://puppet-lint.com/
[uncrustify]: https://github.com/uncrustify/uncrustify
[yapf]: https://github.com/google/yapf
