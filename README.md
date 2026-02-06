# BlackBerry Passport (wseries) Ubuntu Touch Port

This repository contains the device adaptation for the BlackBerry Passport (wseries), utilizing Halium 11.

## Build Instructions

This port uses `halium-generic-adaptation-build-tools` with a patch for old Qualcomm DT boot.img format support.

### Building the System Image

The build process consists of three steps: building the device tarball, preparing the OTA files, and generating the final system image.

1.  **Build Device Tarball**

    ```bash
    ./build.sh -b workdir
    ```
    This compiles the kernel, generates `dt.img`, and creates the device adaptation tarball (`out/device_wseries.tar.xz`).

2.  **Prepare OTA Files**

    ```bash
    build/prepare-fake-ota.sh out/device_wseries.tar.xz workdir/fake-ota
    ```
    This downloads the Ubuntu Touch rootfs and prepares the OTA package format artifacts in `workdir/fake-ota`.

3.  **Generate System Image**

    ```bash
    fakeroot build/system-image-from-ota.sh workdir/fake-ota/ubuntu_command out
    ```
    This generates the final `rootfs.img` and `boot.img` in `out`.

The output files will be:
-   `out/boot.img` (boot image)
-   `out/rootfs.img` (rootfs image, rename to `ubuntu.img` if booting from /userdata)
-   `out/system.img` (same as rootfs.img, but in Android sparse format, can be ignored)

## Installation

### 1. Convert to Android
First, you must convert your BlackBerry Passport to Android. This process requires replacing and resoldering the eMMC chip.
Follow the guide here: [BlackBerry Passport Conversion Guide](https://balika011.hu/blackberry/guides/passport/conversion.php)

### 2. Flash LineageOS
Flash the latest LineageOS build and ensure the device is functional.

### 3. Install Ubuntu Touch
Once the device is running LineageOS, follow these steps to install Ubuntu Touch:

1.  **Push the Rootfs**:
    ```bash
    adb root
    adb push out/rootfs.img /data/ubuntu.img
    ```

2.  **Flash the Boot Image**:
    ```bash
    adb reboot bootloader
    fastboot flash boot out/boot.img
    ```

3.  **Reboot**:
    ```bash
    fastboot reboot
    ```
