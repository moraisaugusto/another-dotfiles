#!/usr/bin/env python
# -*- coding: utf-8 -*-

#! /usr/bin/env python
from pathlib import Path
import argparse
import os
import sys

def run(args):
    m_internal = 'eDP1'
    m_external = 'HDMI1'

    if args.monitors == str(1) and args.output == 'external':
        cmd = "xrandr --output {} --primary --mode 3840x2160 --scale 1x1".format(m_external)
        os.system(cmd)
        cmd2 = "xrandr --output {} --off".format(m_internal)
        os.system(cmd2)
        apps(args.output)


    if args.monitors == str(1) and args.output == 'laptop':
        cmd = "xrandr --output {} --primary --mode 1366x768 --scale 1x1".format(m_internal)
        os.system(cmd)
        cmd2 = "xrandr --output {} --off".format(m_external)
        os.system(cmd2)
        apps(args.output)

    if args.monitors == str(2):
        cmd = "xrandr --output {} --primary --mode 3840x2160 --scale 1x1 --output {} --mode 1366x768 --pos 3840x0 --scale 1.5x1.5".format(m_external, m_internal)
        os.system(cmd)
        apps('external')


def apps(monitor):
    filename = str(Path.home()) + '/.config/polybar/config'
    m_type = 'HDMI1' if monitor == 'external' else 'eDP1'

    # cmd = "sed -i 's/.*MONITOR.*/monitor \= ${end:MONITOR:}/g' {}".format( filename)
    cmd = "sed -i 's/.*MONITOR.*/monitor = ${{env:MONITOR:{}}}/g' {}".format(m_type, filename)
    os.system(cmd)
    cmd2 = str(Path.home()) + '/.config/polybar/launch.sh'
    os.system(cmd2)


def main():
    parser=argparse.ArgumentParser(description="enable or disable monitor")
    parser.add_argument("-m",help="1 or 2" ,dest="monitors", type=str, required=True)
    parser.add_argument("-o",help="laptop or external" ,dest="output", type=str, required=False)
    parser.set_defaults(func=run)
    args=parser.parse_args()
    args.func(args)

if __name__=="__main__":
    main()
