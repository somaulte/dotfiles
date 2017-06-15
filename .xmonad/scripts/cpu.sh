#!/bin/bash

source $(dirname $0)/config.sh

cpu=$(sensors | grep SMBUSMASTER)
cpu=${cpu#SMBUSMASTER 0:[[:space:]]}
cpu=${cpu/.*/°C}
cpu=${cpu/+/}

gpu=$(sensors | grep temp1)
gpu=${gpu#temp1:[[:space:]]}
gpu=${gpu/.*/°C}
gpu=${gpu/+/\| }

echo $cpu$gpu