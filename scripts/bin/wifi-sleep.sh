#!/bin/bash
# save this file /usr/lib/systemd/system-sleep
# this file will reconnect the wifi when you wake up you OS
case $1 in
	pre)
		# unload the modules before going to sleep
		;;
	post)
		sleep 2 #new
		systemctl restart wpa_supplicant.service #new
		;;
esac
