#!/usr/bin/env python3
# vim: filetype=python tabstop=8 expandtab shiftwidth=4 softtabstop=4
# -*- coding: utf-8 -*-
""" Generate Ultisnips snippets for Ansible

Author: JR Bing
Version: 1.0
Last Modified By: JR Bing
Date: 04/06/2022

Generate an Ultisnips formatted snippets file for Ansible modules.

"""
from __future__ import unicode_literals

# import argparse
import os
import os.path
import logging
import subprocess
import shlex
import json
import pprint as pp
from ansible.plugins.loader import fragment_loader
from ansible.utils import plugin_docs

# NOTE:  Be sure to set the PYTHONPATH environment variable before running this
#        ex: export PYTHONPATH=/usr/local/Cellar/ansible/5.5.0/libexec/lib/python3.10/site-packages

static_snippets_file_path = os.path.expanduser(
    '~') + '/.dotfiles/share/ansible/snippets/ansible-static.snippets'
snippets_file_path = os.path.expanduser(
    '~') + '/.dotfiles/vim/custom/snippets/ansible.snippets'

# Setup Logging
logger = logging.getLogger('snippet_generator')
logger.setLevel(logging.INFO)
ch = logging.StreamHandler()
ch.setLevel(logging.DEBUG)
formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')
ch.setFormatter(formatter)
logger.addHandler(ch)

def get_documents():
    logger.info('Generating list of modules')
    command = 'ansible-doc --type module --list_files --json'
    process = subprocess.Popen(shlex.split(command),
                        stdout=subprocess.PIPE,
                        stderr=subprocess.PIPE)
    stdout = process.communicate()[0]
    plugin_list = json.loads(stdout.decode('utf-8'))
    for plugin_name, plugin_path in plugin_list.items():
        try:
            documentation = plugin_docs.get_docstring(plugin_path, fragment_loader)[0]
            metadata = plugin_docs.get_docstring(plugin_path, fragment_loader)[3]
        except Exception as e:
            logger.error(e)
            continue
        if documentation is None or metadata is None:
            continue
        if metadata.get('supported_by') == 'network':
            logger.info(f'Skipping network module: {plugin_name}')
            continue
        if metadata.get('supported_by') == 'certified':
            logger.info(f'Skipping certified module: {plugin_name}')
            continue
        # if documentation['module'] is None:
            # logger.info('Skipping file: ' + filename)
            # continue
        logger.info(f'Metadata for module: {plugin_name} {metadata}')
        yield documentation


def get_play_snippet():
    play_snippet = []
    play_snippet.insert(0, 'snippet play "Execute an ansible play"')
    play_snippet.append('- name: ${1:name}')
    play_snippet.append('\thosts: ${2:host_group}')
    play_snippet.append('\tbecome: ${3:true}')
    play_snippet.append('\ttasks:')
    play_snippet.append('\t\t$0')
    play_snippet.append('endsnippet\n')
    return "\n".join(play_snippet)


# TODO: strip double quotes from description
def to_snippet(document):
    snippet = []
    # Insert the snippet header, name label, and module name
    snippet.insert(0, 'snippet %s "%s" b' %
                   (document['module'], document['short_description'].replace(
                       '"', '')))  # noqa: E501
    snippet.append('- %s: $1' % ('name'))

    if 'options' in document:
        if 'free_form' in document['options']:
            logger.info('Detected free-form module: ' + document['module'])
            snippet.append('\t%s: $2' % (document['module']))
            snippet.append('\targs:')
            options = sorted(document['options'].items(),
                             key=lambda x: x[1].get("required", False),
                             reverse=True)  # noqa: E501
            for index, (name, option) in enumerate(options, 1):
                if 'choices' in option:
                    default = option.get('default')
                    if isinstance(default, list):
                        prefix = lambda x: '#' if x in default else ''  # noqa: E731
                        suffix = lambda x: "'%s'" % x if isinstance(
                            x, str) else x  # noqa: E731, E501
                        value = '[' + ', '.join(
                            "%s%s" % (prefix(choice), suffix(choice))
                            for choice in option['choices'])  # noqa: E501
                    else:
                        prefix = lambda x: '#' if x == default else ''  # noqa: E731
                        value = '|'.join(
                            '%s%s' % (prefix(choice), choice)
                            for choice in option['choices'])  # noqa: E501
                elif option.get('default') is not None and option[
                        'default'] != 'None':  # noqa: E501
                    value = option['default']
                    if isinstance(value, bool):
                        value = 'yes' if value else 'no'
                else:
                    value = "# " + option.get('description', [''])[0]
                if option.get("required", False) is False:
                    snippet.append('\t\t# %s: %s' % (name, value))
                    # snippet.append('\t\t# %s: ${%d:%s}' % (name, (index+1), value))
        else:
            logger.info('Detected non-free-form module: ' + document['module'])
            snippet.append('\t%s:' % (document['module']))
            options = sorted(document['options'].items(),
                             key=lambda x: x[1].get("required", False),
                             reverse=True)  # noqa: E501
            for index, (name, option) in enumerate(options, 1):
                if 'choices' in option:
                    default = option.get('default')
                    if isinstance(default, list):
                        prefix = lambda x: '#' if x in default else ''  # noqa: E731
                        suffix = lambda x: "'%s'" % x if isinstance(
                            x, str) else x  # noqa: E731, E501
                        value = '[' + ', '.join(
                            "%s%s" % (prefix(choice), suffix(choice))
                            for choice in option['choices'])  # noqa: E501
                    else:
                        prefix = lambda x: '#' if x == default else ''  # noqa: E731
                        value = '|'.join(
                            '%s%s' % (prefix(choice), choice)
                            for choice in option['choices'])  # noqa: E501
                elif option.get('default') is not None and option[
                        'default'] != 'None':  # noqa: E501
                    value = option['default']
                    if isinstance(value, bool):
                        value = 'yes' if value else 'no'
                else:
                    value = "# " + option.get('description', [''])[0]
                if option.get("required", False) is True:
                    snippet.append('\t\t%s: ${%d:%s}' % (name,
                                                         (index + 1), value))
                else:
                    snippet.append('\t\t# %s: %s' % (name, value))
                    # snippet.append('\t\t# %s: ${%d:%s}' % (name, (index+1), value))

    snippet.append('$0')
    snippet.append('endsnippet')
    return "\n".join(snippet)


if __name__ == "__main__":
    static_snippets = open(static_snippets_file_path, 'r').read()
    with open(snippets_file_path, "w") as snippetfile:
        snippetfile.writelines([
            "priority 50\n", "\n",
            "# THIS FILE IS AUTOMATICALLY GENERATED, PLEASE DON'T MODIFY BY HAND\n",
            "\n"
        ])  # noqa: E501
        snippetfile.write(static_snippets)
        snippetfile.write("\n")
        for document in get_documents():
            logger.info('Generating snippet for module: ' + document['module'])
            if 'deprecated' in document:
                continue
            snippetfile.write(to_snippet(document))
            snippetfile.write("\n\n")
