#!/usr/bin/bash
#Global stuff

#Functions:
function askForConsent () {
	echo "Asking for permission..."
	zenity --width=800 --warning --text "Unlocking your router is a risky procedure. If a mistake is made and the router is bricked, it might take some time and resources to recover it. 

You are doing this at your own risk, you take the full responsibility for any action you choose to take to unlock your router. 

We cannot be held liable for any damage you do to your device, other devices or your person. You do this at your own risk!"
	
	zenity --width=400 --question --text "Do you understand the risks and are you sure you want to continue?" --ok-label "Yes" --cancel-label "No"
	if [ $? = 0 ] ; then
		#Yes
		return
	else
		#No
		exit
	fi
}

function setupStaticAddress () {
	echo "Setting up Static Addressing..."
	sudo systemctl stop dhcpcd.service
	sudo systemctl disable dhcpcd.service
	sudo cp ./configBits/etc/network/interfacesSTATIC /etc/network/interfaces
	sudo systemctl restart networking.service
	ip addr show eth0 | grep inet
	echo "IP should now be set to 192.168.100.8/16."
	echo "Setting up TFTP Server..."
}

function setupTFTPD () {
	sudo cp ./configBits/etc/default/tftpd-hpa /etc/default/tftpd-hpa
	tar -xzvf ./om5p-ac-v2-unlocker_20170112.tar.gz
	sudo chmod 777 ./fwupgrade.cfg ./fwupgrade.cfg.sig
	sudo mv ./fwupgrade.cfg /srv/tftp/fwupgrade.cfg
	sudo mv ./fwupgrade.cfg.sig /srv/tftp/fwupgrade.cfg.sig
	sudo systemctl restart tftpd-hpa
	systemctl status tftpd-hpa.service | grep Active
}

function unlockOm5pAc () {
	echo "Unlocking OM5P-AC..."
	zenity --width=400 --warning --text "Please plug an ethernet cable from the Raspberry Pi into the '18-24V POE' Port on the OM5P-AC, then proceed. 
	
DO NOT plugin the power cable yet.  We will do that in the next step."
	zenity --width=400 --warning --text "Please plug the power cable into the OM5P-AC, then promptly click OK to proceed."
	echo "Pausing for 30s for router to boot."
	sleep 30s
	if tail -n 50 /var/log/syslog | grep "RRQ from 192.168.100.9 filename fwupgrade.cfg"
	then
		echo "Flashing unlock, this process takes about nine minutes."
		sleep 9m
		##CHECK FOR BACKUP FILE HERE
		if test -f "/srv/tftp/*_backup.bin"; then
			echo "Flash backup exists in the /srv/tftp directory."
		fi
	else 
		echo "Failed to flash unlock."
		exit
	fi
}

function postUnlock () {
	zenity --width=400 --warning --text "STOP!!! Please UNPLUG the power cable from the OM5P-AC, then proceed."
}

function stopTFTPD () {
	zenity --width=400 --warning --text "We are done unlocking your OM5P-AC. The next steps will flash the OpenWRT Image"
	echo "Stopping TFTPD Service."
	sudo systemctl stop tftpd-hpa
}

function flashOpenWRT () {
	zenity --width=400 --info --text "Please PLUG the power cable back into the OM5P-AC, then proceed."
	exec 3< <(sudo ap51-flash eth0 ./openwrt-19.07.5-ar71xx-generic-om5pac-squashfs-factory.bin 2>&1)
	while read line; do
   	case “$line” in
	*flash\ complete*)
      		echo $line
      		echo "Completed Flashing."
      		return
      	;;
   	*)
      		echo $line
      	;;
   	esac
	done <&3
	exec 3<&-
}

function setupDHCP () {
	zenity --width=400 --info --text "Please UNPLUG both the power and ethernet cables from the OM5P-AC, then proceed."
	echo "Setting up DHCP..."
	sudo cp ./configBits/etc/network/interfacesDHCP /etc/network/interfaces
	zenity --width=400 --warning --text "Please plug an ethernet cable from the Raspberry Pi into the '802.3af POE' Port on the OM5P-AC, then proceed. 
	
DO NOT plugin the power cable yet.  We will do that in the next step."
	zenity --width=400 --warning --text "Please plug the power cable into the OM5P-AC, then click OK to proceed."
	sudo systemctl restart networking.service
	echo "Waiting on DHCP address - this can take about three minutes"
	sleep 3m
	ip addr show eth0 | grep inet
}

function connectToLuci () {
	echo "Launching GUI Config..."
	chromium-browser 192.168.1.1 &
}

function main () {
	DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
	cd $DIR
	clear
	askForConsent
	setupStaticAddress
	setupTFTPD
	unlockOm5pAc
	postUnlock
	stopTFTPD
	flashOpenWRT
	setupDHCP
	connectToLuci
	echo "Fin."
}

main "$@"

