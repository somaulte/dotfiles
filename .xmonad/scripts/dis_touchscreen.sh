#!/bin/bash

dev=$(xinput list | grep Raydium | sed -n -e 's/^.*id=//p' | cut -c1-2)


xinput disable $dev
