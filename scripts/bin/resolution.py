#!/usr/bin/env python
# -*- coding: utf-8 -*-

#! /usr/bin/env python
from pathlib import Path
import argparse
import os
import sys

def run(args):
    configs = {
               'primary':
                   {'output': 'DP-0', 'resolution': '3840x2160', 'off_output': 'DP-2'},
               'secondary':
                   {'output': 'DP-2', 'resolution': '3840x2160', 'off_output': 'DP-0'},
              }

    if args.monitors == str(1) and \
       args.output in list(configs.keys()):
        output = configs[str(args.output)]['output']
        resolution = configs[str(args.output)]['resolution']
        off_output = configs[str(args.output)]['off_output']

        cmd = "xrandr --output {} --primary --mode {} --scale 1x1".format(output, resolution)
        cmd2 = "xrandr --output {} --off".format(off_output)

        os.system(cmd)
        os.system('sleep 1')
        os.system(cmd2)

        apps(args.output)

    if args.monitors == str(2):
        cmd = "xrandr --output {} --primary --mode 3840x2160 --scale 1x1 --output {} --mode 1366x768 --pos 3840x0 --scale 1x1".format(m_secondary, m_primary)
        os.system(cmd)
        apps('secondary')


def apps(monitor):
    filename = str(Path.home()) + '/.config/polybar/config'
    m_type = 'HDMI1' if monitor == 'secondary' else 'eDP1'

    # cmd = "sed -i 's/.*MONITOR.*/monitor \= ${end:MONITOR:}/g' {}".format( filename)
    cmd = "sed -i 's/.*MONITOR.*/monitor = ${{env:MONITOR:{}}}/g' {}".format(m_type, filename)
    os.system(cmd)
    cmd2 = str(Path.home()) + '/.config/polybar/launch.sh'
    os.system(cmd2)


def main():
    parser=argparse.ArgumentParser(description="enable or disable monitor")
    parser.add_argument("-m",help="1 or 2" ,dest="monitors", type=str, required=True)
    parser.add_argument("-o",help="primary or secondary" ,dest="output", type=str, required=False)
    parser.set_defaults(func=run)
    args=parser.parse_args()
    args.func(args)

if __name__=="__main__":
    main()
