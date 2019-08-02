#!/bin/bash
# you can pass insight ui repo url to this script as argument

coin/start.sh
sleep 60

electrum/start.sh $(coin/config.py ac_name)
sleep 60

insight/start.sh $(coin/config.py ac_name) $1
exit

