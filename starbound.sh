#!/bin/bash
#chkconfig 345 99 10


#21025

#This Script requires SteamCMD See: https://developer.valvesoftware.com/wiki/SteamCMD
#Wrote for CentOS 6.5
#
#Steam Info for Updating
. /etc/rc.d/init.d/functions

STEAMUSER='STEAMUSERNAME'
STEAMPASS='STEAMPASSWORD' # doesn't work with passwords with $ and maybe ! dont know why

STEAMCMDPATH='/mnt/raid/SteamCMD'
STARBOUNDPATH='/mnt/raid/Starbound'
LOGPATH=${STARBOUNDPATH}/StarBound.log

PROG='StarboundServer'
DESC='Starbound Server'
STARBOUND_BIN=${STARBOUNDPATH}/linux32/starbound_server #not used for now
PIDFILE=/var/lock/subsys/${PROG}.pid #not used for now

RUNAS="starbound"




function updateStarBound {
	cd ${STEAMCMDPATH}
	
	  su  ${RUNAS} -c "./steamcmd.sh\
	 +login ${STEAMUSER} ${STEAMPASS}\
	 +force_install_dir ${STARBOUNDPATH}\
	 +app_update 211820\
	 +exit"
}

function startServer {

	su - ${RUNAS} -c "cd ${STARBOUNDPATH} ; nohup ${STARBOUNDPATH}/linux32/launch_starbound_server.sh &> /dev/null &"

}




function start
{
		PID=$(pidof starbound_server)
		[ -z ${PID} ] || exit 1 
		[ -x ${STEAMCMDPATH}/steamcmd.sh ] || echo "WARNING: steamcmd.sh not executable or does not exist"
		[ -x $STARBOUND_BIN ] || exit 1 
		updateStarBound
		startServer
}

function stop
{
		PID=$(pidof starbound_server)
		[ -z ${PID} ] || kill -2 ${PID}
}

function update
{
		[ -x ${STEAMCMDPATH}/steamcmd.sh ] || exit 1
		PID=$(pidof starbound_server)
		[ -z ${PID} ] || echo "It appears that Starbound is already running!" exit 1
		updateStarBound
}

function status
{
	PID=$(pidof starbound_server)
	if [[ -z ${PID} ]] ; then
		echo "StarBound not running!"
	else
		echo "StarBound running with pid of ${PID}"
	fi
}


case "$1" in
start)
		start
		;;

update)
		update
		;;
restart)
		stop
		sleep 4
		start
		;;		
stop)
		stop
		;;
status)
		status
		;;
*)
        echo "Usage: $0 {start|update|stop}"
        exit 1
        esac

exit 0
