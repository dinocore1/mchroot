#!/bin/bash

ENV_ROOT="/tmp/mchroot"
OVERLAY_ROOT="/tmp/mchroot-overlay"

UNDERLAY_DIRS="bin sbin etc home lib lib32 lib64 usr var"

for dir in $UNDERLAY_DIRS; do
  umount $ENV_ROOT/$dir
done

umount $ENV_ROOT/proc
umount $ENV_ROOT/sys
umount $ENV_ROOT/dev
