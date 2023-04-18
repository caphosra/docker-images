#!/bin/bash

#
# The main idea of this bash file is from https://github.com/iphoneintosh/kali-docker.
#

# Start VNC server
if [ $VNC_EXPOSE = 1 ]
then
    # Expose VNC
    sudo vncserver :0 -rfbport $VNC_PORT -geometry $VNC_DISPLAY -depth $VNC_DEPTH \
        > /var/log/vncserver.log 2>&1
else
    # Localhost only
    sudo vncserver :0 -rfbport $VNC_PORT -geometry $VNC_DISPLAY -depth $VNC_DEPTH -localhost \
        > /var/log/vncserver.log 2>&1
fi

# Start noVNC server
sudo /usr/share/novnc/utils/launch.sh --listen $NOVNC_PORT --vnc localhost:$VNC_PORT \
    > /var/log/novnc.log 2>&1 &

# Start shell
/bin/bash
