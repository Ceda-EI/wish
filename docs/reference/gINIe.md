# gINIe file format


Customization of wish is done using a gINIe file (format specific to wish)
which is an extended INI config file. The default location for config file is
`~/.config/wish/config.gie`. The default config file is automatically copied
over. The location can be customized using `WISH_CONFIG_FILE` variable.
Multiple config files can be supplied as an array to `WISH_CONFIG_FILE`.

Comments start with a `#` or `;` and always exist on a line of their own.

Key value pairs are in the form of `key = value`. Keys cannot have whitespaces
or `=` in them. Values can have any character as part of them. Surrounding
spaces in values are stripped away. To keep surrounding spaces as a part of
the value. Although, keys are case-sensitive in gINIe, wish treats them case-
insensitively.

Block names are enclosed in `[]` (e.g. `[core]`). Block names are case
sensitive. All key value pairs after a block starts and before the next block
begins are considered a part of that block. All key value pairs must be in a
block.

Available Blocks:

+ `core`: Core block configures Wish itself. Available keys are:
    - `auto_newline`: Automatically add a newline if last line of output
      doesn't end in newline. (0 to disable, 1 to enable)
    - `theme`: Wish theme.
    - `powerline`: Enable / Disable powerline. (0 to disable, 1 to enable)
+ `plugin`: Adds a plugin to the section the block is added to. All config for
  that plugin goes there. Check wiki for details on available keys for
  plugins. The key "name" defines the plugin to use. Plugin blocks
  outside a section are ignored.

Section names are enclosed in `||` (e.g. `|left|`). All blocks after a section
starts and before the next section begins are considered a part of that
section.  Blocks don't necessarily need to be in a section.

Available sections are `left`, `right` for left prompt and right prompt
respectively.


