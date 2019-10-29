#!/bin/bash

if [ "${START_VNC}" = true ] ; then
  Xvfb :99 -screen 0 1024x768x16 &

  for i in $(seq 1 10)
  do
    sleep 1
    xdpyinfo -display ${VNC_DISPLAY} >/dev/null 2>&1
    if [ $? -eq 0 ]; then
      break
    fi
    echo "Waiting for Xvfb..."
  done

  x11vnc -usepw -forever -shared -rfbport ${VNC_PORT} -display ${VNC_DISPLAY} -noxrecord &
fi

exec "$@"
