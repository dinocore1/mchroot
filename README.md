#### mChroot ####

mChroot is a very simple script that mounts your unix system with an overlay and then chroots into it. This is very useful when expermenting with installing new software. You can run the script like so:

```bash
sudo . mchroot.sh
# now in chroot env

exit
# now exited from chroot env
```

All the changes made in the chroot env are saved to /tmp/mchroot-overlay. To wipe your overlay system, simply delete the mchroot-overly dir.
