#!/bin/bash

#
# The main idea of this bash file is from https://github.com/iphoneintosh/kali-docker.
#

# Set password for VNC
mkdir -p /$USER/.vnc/
echo $VNCPWD | vncpasswd -f > /$USER/.vnc/passwd
chmod 600 /$USER/.vnc/passwd

# Start VNC server
if [ $VNC_EXPOSE = 1 ]
then
    # Expose VNC
    vncserver :0 -rfbport $VNC_PORT -geometry $VNC_DISPLAY -depth $VNC_DEPTH
else
    # Localhost only
    vncserver :0 -rfbport $VNC_PORT -geometry $VNC_DISPLAY -depth $VNC_DEPTH -localhost
fi

# Start noVNC server
/usr/share/novnc/utils/novnc_proxy --listen $NOVNC_PORT --vnc localhost:$VNC_PORT
