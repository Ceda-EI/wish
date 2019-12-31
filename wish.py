#!/usr/bin/env python3
"""
Generate function wrappers from config for wish.

wish.py works by writing plugins which are isolated from the global plugins.
It assigns all the config to relevant variables inside a wrapper. e.g.

If the config file is

```
|left|
[plugin]
name = date
format = %F
```

wish.py creates a wrapper around date as 0_date where 0 is the index of plugin.
Inside the wrapper, in each function, it sets WISH_DATE_FORMAT="%F" and
WISH_DATE_BG=$WISH_0_DATE_BG (same for FG), so the plugin sees its config as
defined in the config file. After calling the plugin's relevant function, it
sets WISH_0_DATE_BG=$WISH_DATE_BG (same for FG) in case, the plugin has changed
it). This allows multiple instances of the same plugin to coexist with
different config and different themes.
"""

from os.path import isfile
import shlex
import sys

import ginie


def parse_core(core):
    "Parses a core block"
    config = core["config"]
    for key in core["config"]:
        print("WISH_{}={}".format(key.upper(), shlex.quote(config[key])))


def parse_plugin(plugin, plugin_idx):
    "Parses a plugin and writes a wrapper around it"
    config = plugin["config"]
    try:
        plugin_name = config["name"].strip().lower()
        config["name"] = plugin_name
    except KeyError:
        return False

    keys_from_source = ("BG", "FG")
    for j in ("start", "end", "set_colors", "main"):
        print("function wish_{}_{}_{}()".format(plugin_idx, plugin_name, j))
        print("{")
        for key in keys_from_source:
            print("\tlocal WISH_{0}_{2}=$WISH_{1}_{0}_{2}".format(
                plugin_name.upper(),
                plugin_idx,
                key.upper()
            ))
        for key in config:
            if key == "name":
                continue
            print("\tlocal WISH_{}_{}={}".format(plugin_name.upper(),
                                                 key.upper(),
                                                 shlex.quote(config[key])))
        print("\twish_{}_{} $*".format(plugin_name, j))
        print("\tlocal err=$?")
        for key in keys_from_source:
            print("\tWISH_{1}_{0}_{2}=$WISH_{0}_{2}".format(
                plugin_name.upper(),
                plugin_idx,
                key.upper()
            ))
        print("\treturn $err")
        print("}")
    return True


def print_plugin_list(name, array, always=False):
    "Prints a list of plugins as a bash array"
    if array or always:
        print("{}=(".format(name))
        for plugin in array:
            print("\t" + plugin)
        print(")")


def main():
    "Parse a config file passed as first argument"
    config_file = []
    for file_name in sys.argv[1:]:
        if isfile(file_name):
            with open(file_name) as file:
                config_file += ginie.load(file)
        else:
            print("echo Invalid config file: {}".format(
                shlex.quote(file_name)))

    plugin_idx = 0
    plugins_to_source = []
    left_plugins = []
    right_plugins = []
    for i in config_file:
        kind = i["type"]
        name = i["name"]
        # Parse core blocks outside a section.
        # No other blocks outside a section need to be parsed for now.
        if kind == "block" and name == "core":
            parse_core(i)
        elif kind == "section":
            # All sections other than left and right are skipped.
            if name not in ("left", "right"):
                continue
            for block in i["blocks"]:
                if block["name"] == "core":
                    parse_core(block)
                elif block["name"] == "plugin" and parse_plugin(block,
                                                                plugin_idx):
                    plugin_name = "{}_{}".format(plugin_idx,
                                                 block["config"]["name"])
                    if name == "left":
                        left_plugins.append(plugin_name)
                    else:
                        right_plugins.append(plugin_name)
                    plugins_to_source.append(block["config"]["name"])
                    plugin_idx += 1

    print_plugin_list("WISH_PLUGINS", left_plugins)
    print_plugin_list("WISH_RIGHT_PLUGINS", right_plugins)
    print_plugin_list("WISH_PLUGINS_SOURCE", plugins_to_source)


# Python 2 patch
# TODO: Write a better patch for Python 2
try:
    shlex.quote
except AttributeError:
    shlex.quote = lambda x: x

if __name__ == "__main__":
    main()
