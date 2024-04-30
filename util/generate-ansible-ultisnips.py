#!/usr/bin/env python3
# vim: filetype=python tabstop=8 expandtab shiftwidth=4 softtabstop=4
# -*- coding: utf-8 -*-
""" A boilerplate script

Author: JR Bing
Version: 1.0
Last Modified By: JR Bing
Date: 04/23/2024

This script-level docstring will double as the description when the script is
called with the --help or -h option.

TODO: Things that still need to be done.
"""

# Standard Library imports go here
import argparse
import logging
import os
import os.path
import subprocess
import json
# import sys
# import io

# External library imports go here
#
# Standard Library from-style imports go here
from pathlib import Path

# External library from-style imports go here
#
static_snippets_file_path = os.path.expanduser(
    '~') + '/.dotfiles/share/ansible/snippets/ansible-static.snippets'
snippets_file_path = os.path.expanduser(
    '~') + '/.dotfiles/vim/custom/snippets/ansible.snippets'

# Set up a global logger. Logging is a decent exception to the no-globals rule.
# We want to use the logger because it sends to standard error, and we might
# need to use the standard output for, well, output. We'll set the name of the
# logger to the name of the file (sans extension).
log = logging.getLogger(Path(__file__).stem)


def parse_args():
    """Parse command line arguments."""
    parser = argparse.ArgumentParser(description=__doc__)
    # Set the verbosity level for the logger. The `-v` option will set it to
    # the debug level, while the `-q` will set it to the warning level.
    # Otherwise use the info level.
    verbosity = parser.add_mutually_exclusive_group()
    verbosity.add_argument('-v', '--verbose', action='store_const',
                           const=logging.DEBUG, default=logging.INFO)
    verbosity.add_argument('-q', '--quiet', dest='verbose',
                           action='store_const', const=logging.WARNING)
    return parser.parse_args()


def main():
    args = parse_args()
    logging.basicConfig(level=args.verbose)
    log.info("Running")


if __name__ == "__main__":
    main()
