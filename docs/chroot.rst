chroot instructions
======================

::

    D=/mnt/temp

::

    mkdir -p $D
    mkdir -p $D/dev
    mkdir -p $D/sys
    mkdir -p $D/dev/shm
    mkdir -p $D/proc

::

    mount -o bind /dev $D/dev
    mount -o bind /sys $D/sys
    mount -o bind /dev/shm $D/dev/shm
    mount -o bind /proc $D/proc

::

    cp /etc/resolv.conf $D/etc/resolv.conf
    chroot $D

::

    sudo umount $D/dev
    sudo umount $D/sys
    sudo umount $D/dev/shm
    sudo umount $D/proc
    sudo umount $D
