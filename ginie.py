#!/usr/bin/env python3
"gINIe Parser for Wish"

import re
import sys


class GinieParseError(ValueError):
    "Exception Class for errors in"


def loads(string):
    """
    Deserialize `string` (a `str` instance containing a gINIe document)
    into a Python list.

    Return Value: List of `block` and `section` dicts

    `block` dicts are of form
    {
        'type': 'block',
        'name': 'name_of_block_as_in_config',
        'config': {}
    }
    where `name` and `config` keys are based on the gINIe document.

    `section` dicts are of form

    {
        'type': 'block',
        'name': 'name_of_block_as_in_config',
        'blocks': []
    }
    where `name` and `blocks` keys are based on the gINIe document and blocks
    is a list of block dicts found in the section.
    """
    config = []
    section_re = re.compile(r"^\|(?P<section>.+)\|$")
    block_re = re.compile(r"^\[(?P<block>[^\]]*)\]$")
    line_re = re.compile(r"^\s*(?P<key>[^\s=]+)(\s*)=\s*?(?P<value>.*)$")
    empty_re = re.compile(r"^\s*$")
    comment_re = re.compile(r"^\s*(#|;)")
    current_block = None
    current_section = None
    for idx, line in enumerate(string.splitlines()):
        idx += 1  # Since line numbers begin with 1
        # Skip comments and empty lines
        if empty_re.match(line) or comment_re.match(line):
            continue

        # Section parsing
        if line.startswith("|"):
            match = section_re.match(line)
            if match is None:
                err = "Invalid line {}".format(idx)
                raise GinieParseError(err)
            current_section = {
                "type": "section",
                "name": match.group("section"),
                "blocks": []
            }
            config.append(current_section)
            continue

        # Block Parsing
        if line.startswith("["):
            match = block_re.match(line)
            if match is None:
                err = "Invalid block name on line {}".format(idx)
                raise GinieParseError(err)
            current_block = {
                "type": "block",
                "name": match.group("block"),
                "config": {}
            }
            if current_section is None:
                config.append(current_block)
            else:
                current_section["blocks"].append(current_block)
            continue

        # If it is neither a comment, nor a section, nor a block, it has to be
        # a key, value pair.
        if current_block is None:
            raise GinieParseError("Found lines outside a block")

        match = line_re.match(line)
        if match is None:
            raise GinieParseError("Invalid line {}: {}".format(idx, line))

        value = match.group('value').strip()
        if value:
            if value[0] == value[-1] == "'" or value[0] == value[-1] == '"':
                value = value[1:-1]
        current_block["config"][match.group('key').strip()] = value

    return config


def load(file):
    """
    Deserialize `file` (a file-like object containing a gINIe document)
    into a Python list.

    Return Value: List of `block` and `section` dicts

    `block` dicts are of form
    {
        'type': 'block',
        'name': 'name_of_block_as_in_config',
        'config': {}
    }
    where `name` and `config` keys are based on the gINIe document.

    `section` dicts are of form

    {
        'type': 'block',
        'name': 'name_of_block_as_in_config',
        'blocks': []
    }
    where `name` and `blocks` keys are based on the gINIe document and blocks
    is a list of block dicts found in the section.
    """
    return loads(file.read())


if __name__ == "__main__":
    if len(sys.argv) == 1:
        print("Usage: {} file.gie|-".format(sys.argv[0]))
    elif sys.argv[1] == '-':
        print(load(sys.stdin))
    else:
        with open(sys.argv[1]) as source:
            print(load(source))
