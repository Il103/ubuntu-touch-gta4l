#!/bin/bash
set -xe
[ -d build ] || git clone https://github.com/NotKit/halium-generic-adaptation-build-tools.git -b wseries build

# Extract android-rootfs.img if missing or older than in the repo
if [ ! -f overlay/system/var/lib/lxc/android/android-rootfs.img ] || [ android-rootfs/android-rootfs.img.zst.part00 -nt overlay/system/var/lib/lxc/android/android-rootfs.img ]; then
    echo "Unpacking android-rootfs.img..."
    mkdir -p overlay/system/var/lib/lxc/android
    cat android-rootfs/android-rootfs.img.zst.part* | zstd -d > overlay/system/var/lib/lxc/android/android-rootfs.img
fi

./build/build.sh "$@"
