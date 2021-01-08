# om5pFlashTool
Tool to get OpenWRT installed on an OM5P-AC Router after unlocking it using a raspberry pi

This is provided with no guarantees and there is a chance you're going to break your router/AP while using this. If that doesn't scare you away then keep reading.

FRC:
  * You might be here because you are an FRC Team or someone from a team.
  * You probably don't need to use this.
  * If you don't need to use this then don't.

Parts Needed:
  * Raspberry Pi 4 or pi 3
  * Ethernet Cable
  * Power cable for an OM5P-AC Radio (12v Barrel Jack)
  * OM5P-AC Radio
  
Pre-Requisite Stuff:
  * apt update
  * apt upgrade
  * apt install openssh-server
  * #enable SSH Server using rpi-config
  * apt install vim
  * apt install build-essential
  * apt install git
  * apt install tftpd-hpa
  * wget http://ftp.us.debian.org/debian/pool/main/a/ap51-flash/ap51-flash_2019.0.1-3_armhf.deb
  * dpkg -i ap51-flash_2019.0.1-3_armhf.deb

General Directions:
  * Follow the prompts.  Do not skip any of them.
  * Yes, you really should wait the full 9 minutes that it takes for the unlock.  Just be patient.
  * If something goes wrong, don't panic.  Start the process over from a clean boot.
  * First process uses TFTP to boot up the unlock files on the router and possibly generate a backup file
  * Second process involves flashing OpenWRT on the router and then connecting to the LUCI page for configuration
  * Have fun.

Specific Directions:
  * Run the flashTool.sh script (it's on the desktop in the image file for you to double click on)
  * Accept the risks if you do
  * You will be prompted to plug in the ethernet cable into the 18-24V POE Port
  * You will then be prompted to plug in the power cable
  * The process of unlocking the device will start
  * You need to wait for about nine minutes
  * You will be prompted to unplug the power cable to reboot the router
  * You will be prompted to plug the power back in.
  * You will need to wait while the OpenWRT firmware is loaded
  * You will be prompted to disconnect both the ethernet and power cables
  * You will need to plug the ethernet cable back into the 802.3af POE Port
  * You will need to plug in the power
  * A browser should open to http://192.168.1.1
  * Configure the radio however you'd like using OpenWRT
  
Image File:
  * There is a Raspberry pi image file.  It should work on a Pi 3 or a Pi 4.
  * Link is here: https://drive.google.com/file/d/1HsNgSEx2KmgwyxEb49PKPvfaoFYVwldJ/view?usp=sharing
  * It might not correctly launch the browser after running the script from the desktop.  Open the browser and navigate to http://192.168.1.1

Thanks:
  * Big thanks to the OpenWRT group for making awesome software.
  * HUGE thanks to True Systems for their OM5P Unlocker Utility
  
Resources:
  * https://openwrt.org/toh/hwdata/open-mesh/open-mesh_om5p-ac
  * https://github.com/ap51-flash/ap51-flash
  * https://github.com/true-systems/om5p-ac-v2-unlocker
  * http://files.andymark.com/OM5P-AN_QuickAP_Setup.pdf
