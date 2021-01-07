# om5pFlashTool
Tool to get OpenWRT installed on an OM5P-AC Router after unlocking it using a raspberry pi

This is provided with no guarantees and there is a chance you're going to break your router/AP while using this. If that doesn't scare you away then keep reading.

Parts Needed:
  * Raspberry Pi 4
  * Ethernet Cable
  * Power cable for an OM5P-AC Radio (12v Barrel Jack)
  * OM5P-AC Radio

General Directions:
  * Follow the prompts.  Do not skip any of them.
  * Yes, you really should wait the full 6 minutes that it takes for the unlock.  Just be patient.

Specific Directions:
  * Run the flashTool.sh script
  * Accept the risks if you do
  * You will be prompted to plug in the ethernet cable into the 18-24V POE Port
  * You will then be prompted to plug in the power cable
  * The process of unlocking the device will start
  * You need to wait for about six minutes
  * You will be prompted to unplug the power cable to reboot the router
  * You will need to wait while the OpenWRT firmware is loaded
  * You will be prompted to disconnect both the ethernet and power cables
  * You will need to plug the ethernet cable back into the 802.3af POE Port
  * You will need to plug in the power
  * A browser should open to http://192.168.1.1
  * Configure the radio however you'd like using OpenWRT

Thanks:
  * Big thanks to the OpenWRT group for making awesome software.
  * HUGE thanks to True Systems for their OM5P Unlocker Utility
  
Resources:
  * https://openwrt.org/toh/hwdata/open-mesh/open-mesh_om5p-ac
  * https://github.com/ap51-flash/ap51-flash
  * https://github.com/true-systems/om5p-ac-v2-unlocker
  * http://files.andymark.com/OM5P-AN_QuickAP_Setup.pdf
