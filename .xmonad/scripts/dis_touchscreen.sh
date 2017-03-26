#!/usr/bin/env bash

dev=$(xinput list | grep Raydium)
dev=${dev/*id=}
dev=${dev/\[*}
dev=${dev//[[:space:]]}

xinput disable $dev