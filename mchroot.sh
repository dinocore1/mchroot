#!/bin/bash

# this script creates an overlay of your system and then chroots into
# it


ENV_ROOT="/tmp/mchroot"
OVERLAY_ROOT="/tmp/mchroot-overlay"

UNDERLAY_DIRS="bin etc home lib lib32 lib64 usr var"

for dir in $UNDERLAY_DIRS; do
  mkdir -p "$ENV_ROOT/$dir"
  mkdir -p "$OVERLAY_ROOT/$dir"

  mount -t aufs -o br="$OVERLAY_ROOT/$dir":"/$dir": none "$ENV_ROOT/$dir"
done

mkdir -p $ENV_ROOT/proc
mount -t proc proc $ENV_ROOT/proc

mkdir -p $ENV_ROOT/sys
mount -t sysfs sys $ENV_ROOT/sys

mkdir -p $ENV_ROOT/dev
mount -o bind /dev $ENV_ROOT/dev

chroot $ENV_ROOT

#unmount
for dir in $UNDERLAY_DIRS; do
  umount $ENV_ROOT/$dir
done

umount $ENV_ROOT/proc
umount $ENV_ROOT/sys
umount $ENV_ROOT/dev
