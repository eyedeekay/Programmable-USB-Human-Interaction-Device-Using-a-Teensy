# Programmable-USB-Human-Interaction-Device-Using-a-Teensy
## Introduction
* Used a device called Teensy (3.1) to implement this project
* Teensy is a microcontroller development board similar to Arduino
* Can be programmed using traditional C programming or using the Arduino development language using the Teensyduino add-on
* Can emulate any USB device including HID devices such as keyboards and mice
* Works even if U3 autorun is turned off
* Comes in a very small form factor (1.4 x 0.7)in.
* Draws very little attention
* Available at PJRC store for just $20

## What does the device do?
* Open up command prompt
* Adds a hidden administrative account to the target machine
* Grant FULL access privileges to the newly created user account
* Disable windows firewall
* Enable Remote Desktop and Remote Assistance 
* Download an executable file containing using powershell
* Start reverse TCP meterpreter shell by executing malicious payload embedded in the executable file
* Make a Facebook post crafted to bait users into clicking an attached malicious file
    * File is injected with another payload to start reverse TCP shell 

## How the device does it?
* The Teensy has built in capability to emulate USB devices
* The Teensy is programmed to emulate a keyboard and send specifically programmed keystrokes
* The keystrokes are sent in a timely manner in order to perform specifically designed actions just as an attacker with physical access to a machine would
* These keystrokes are the foundation to Teensy based attacks
