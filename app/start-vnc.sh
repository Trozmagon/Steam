#!/bin/bash

# Start VNC server with provided geometry and depth
tightvncserver $DISPLAY -geometry $GEOMETRY -depth $DEPTH && \

# Start noVNC to provide browser-based access to the VNC server 
novnc_proxy --vnc localhost:5901 --listen 6080 & 

# Keep the script running so that the container doesn't exit immediately 
tail -f /dev/null #!/bin/bash

# Start VNC server with provided geometry and depth
tightvncserver $DISPLAY -geometry $GEOMETRY -depth $DEPTH && \

# Start noVNC to provide browser-based access to the VNC server 
novnc_proxy --vnc localhost:5901 --listen 6080 & 

# Keep the script running so that the container doesn't exit immediately 
tail -f /dev/null 