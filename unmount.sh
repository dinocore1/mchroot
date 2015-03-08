#!/bin/bash

ENV_ROOT="/tmp/mchroot"
OVERLAY_ROOT="/tmp/mchroot-overlay"


#kill all processes in chroot

FOUND=0

for ROOT in /proc/*/root; do
    LINK=$(readlink $ROOT)
    if [ "x$LINK" != "x" ]; then
        if [ "x${LINK:0:${#ENV_ROOT}}" = "x$ENV_ROOT" ]; then
            # this process is in the chroot...
            PID=$(basename $(dirname "$ROOT"))
            echo "killing PID: $PID"
            kill -9 "$PID"
            FOUND=1
        fi
    fi
done

echo "waiting for processes to die..."
sleep 2

UNDERLAY_DIRS="bin sbin etc home lib lib32 lib64 usr var"

for dir in $UNDERLAY_DIRS; do
  umount $ENV_ROOT/$dir
done

umount $ENV_ROOT/proc
umount $ENV_ROOT/sys
umount $ENV_ROOT/dev
umount $ENV_ROOT/tmp
