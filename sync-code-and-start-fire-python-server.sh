#!/bin/bash

# Bash script to start Python ISMRMRD server.  First argument is path to log file.
# If no argument is provided, logging is done to stdout (and discarded)

#cp -R -f /tmp/share/code/* "/opt/code/python-ismrmrd-server/"

if [ $# -eq 1 ]; then
  LOG_FILE=${1}
  /usr/local/bin/python /opt/codes/python-ismrmrd-server/main.py -v -H=0.0.0.0 -p=9002 -l=${LOG_FILE} &
else
  /usr/local/bin/python /opt/codes/python-ismrmrd-server/main.py -v -H=0.0.0.0 -p=9002 &
fi

