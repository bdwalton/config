#!/usr/bin/env python

import argparse
import glob
import os
import re
import stat
import subprocess
import sys

CONFIG_FILE_NAME = ".bdwconfig"
HOME = os.getenv("HOME")
CONFIG_FILE = os.path.join(HOME, CONFIG_FILE_NAME)

OPTIONS = None

def croak(msg):
    print >> sys.stderr, "Error: %s" % msg
    sys.exit(1)

def get_config_type():
    config_type = None

    try:
        with open(CONFIG_FILE) as conf:
            for line in conf.readlines():
                matchdata = re.match(r"^BDW_CONFIG_TYPE=(.*)\s*$", line)
                if matchdata:
                    config_type = matchdata.group(1)
                    break

    except IOError as ex:
        croak(ex)

    return config_type

def get_dest_path(config_file):
    basename = os.path.basename(config_file).replace('_', '.', 1)
    return os.path.join(HOME, basename)

def get_config_items(config_dir, config_type):
    # We ignore anything that doesn't begin with underscore.
    all_items = [os.path.realpath(p) for p in
                 glob.glob(os.path.join(config_dir, "_*"))]
    items = []
    for item in all_items:
        if re.match(".+-.+", item) and not re.match(".+-%s$" %
                                                    config_type, item):
            # Skip over environment specific configs that do not
            # belong to this environment.
            continue

        data = {'src': item,
                'dest': get_dest_path(item),
                'type': 'dir' if stat.S_ISDIR(os.stat(item).st_mode) else 'file'}

        items.append(data)

    return items

def get_config_install_commands(config_items):
    commands = []

    if OPTIONS.debug:
        commands.append("set -x")

    for item in config_items:
        file_type = item['type']
        src = item['src']
        dest = item['dest']

        if os.path.exists(dest):
            if not os.path.islink(dest) and OPTIONS.backup:
                if OPTIONS.verbose:
                    commands.append("echo Backing up '%s' to '%s.bak'" %
                                    (dest, dest))
                commands.append("cp -pR '%s' '%s.bak'" % (dest, dest))

            # If we're installing a symlink to a directory, we're
            # potentially replacing an existing directory. Clean it up
            # first.
            if file_type == "dir":
                if OPTIONS.verbose:
                    commands.append("echo Removing original directory '%s'" %
                                    dest)
                commands.append("rm -rf '%s'" % dest)

        if OPTIONS.verbose:
            commands.append("echo Installing symlink for '%s'" % dest)
        commands.append("ln -snf '%s' '%s'" % (src, dest))

    if OPTIONS.dryrun:
        commands = ["echo %s" % cmd for cmd in commands]

    return commands

def run_commands(commands):
    shell = subprocess.Popen("/bin/bash", stdin=subprocess.PIPE)
    for cmd in commands:
        shell.stdin.write("%s\n" % cmd)

    shell.stdin.close()
    shell.wait()

def parse_args(argv):
    parser = argparse.ArgumentParser(prog=os.path.basename(sys.argv[0]),
                                     description='Config Installer.')

    parser.add_argument("-b", "--backup", action="store_true", default=False,
                        help="Preserve existing config files/dirs.")

    parser.add_argument("-d", "--debug", action="store_true", default=False,
                        help="Enable trace output.")

    parser.add_argument("-n", "--dryrun", action="store_true", default=False,
                        help="Enable dry run mode.")

    parser.add_argument("-q", "--noverbose", action="store_false",
                        dest="verbose", default=True,
                        help="Display output indicating actions taken.")

    args = parser.parse_args(argv)
    return args

def main(argv):
    global OPTIONS
    OPTIONS = parse_args(argv[1:])

    config_type = get_config_type()
    repo_dir = os.path.dirname(argv[0])
    if config_type:
        print "Config Repo: %s" % repo_dir
        print "Config type: %s" % config_type
        config_items = get_config_items(repo_dir, config_type)
        commands = get_config_install_commands(config_items)

        run_commands(commands)

    else:
        croak("Please set BDW_CONFIG_TYPE in '%s'" % CONFIG_FILE)


if __name__ == "__main__":
    main(sys.argv)
