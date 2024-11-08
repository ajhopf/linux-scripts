#!/bin/bash

logdir="$HOME/logs"

cat "$logdir/cronjob.log" | grep -E '^\[ACZG_CI\] \[(COMMIT|TEST)\] \[(SUCCESS|ERROR)\]'
