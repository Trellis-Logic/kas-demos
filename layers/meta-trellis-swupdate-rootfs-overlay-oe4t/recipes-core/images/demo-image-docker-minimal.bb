DESCRIPTION = "Minimal Docker demo image with X11/Sato, nvidia-docker."

IMAGE_FEATURES += "ssh-server-openssh"

LICENSE = "MIT"

inherit core-image

CORE_IMAGE_BASE_INSTALL += "packagegroup-demo-base"
CORE_IMAGE_BASE_INSTALL += "${@'packagegroup-demo-systemd' if d.getVar('VIRTUAL-RUNTIME_init_manager') == 'systemd' else ''}"
TOOLCHAIN_HOST_TASK += "nativesdk-packagegroup-cuda-sdk-host"

inherit nopackages

IMAGE_FEATURES += "splash x11-base x11-sato hwcodecs"

inherit features_check

REQUIRED_DISTRO_FEATURES = "x11 virtualization"

CORE_IMAGE_BASE_INSTALL += "nvidia-docker"
CORE_IMAGE_BASE_INSTALL += "tailscale"
