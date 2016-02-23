#! /bin/sh
### BEGIN INIT INFO
# Provides:          reset-ethernet
# Short-Description: reset ethernet network connection
# Description:       Daemon for reset ethernet drive network
### END INIT INFO

DESC="reset ethernet network connection"
NAME="ResetEthernet"
DRIVE="r8169"

result=`lsmod |grep $DRIVE | wc -l)`
kernel=`uname -r`
#
# Function that loads ethernet drive
#
d_start() {
  if [ $result -eq 0 ]; then
    $(insmod /lib/modules/${kernel}/kernel/drivers/net/ethernet/realtek/${DRIVE}.ko)
    echo "$DRIVE has been loaded"
  else
    echo "$DRIVE is loaded"
  fi
}

#
# Function that unloads ethernet drive
#
d_stop() {
  if [ $result -gt 0 ]; then
    $(rmmod ${DRIVE})
    echo "$DRIVE has been unloaded"
  else
    echo "$DRIVE is unloaded"
  fi
}


#
# Checking module status
#
d_status() {
  if [ $result -gt 0 ]
  then
    echo "$DRIVE is loaded"
  else 
    echo "$DRIVE is not loaded"
  fi
}

case "$1" in
  start)
    d_start
    ;;
  stop)
    d_stop
    ;;
  restart)
    $0 stop
    $0 start
    ;;
  status)
    d_status 
    ;;
  *)
    echo "Usage: $SCRIPTNAME {start|stop|restart|status}" >&2
    exit 1
    ;;
esac

exit 0
