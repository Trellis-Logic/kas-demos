TEGRA_DATAIMG_TYPE ?= "ext4"
TEGRA_DATA_PART_SIZE_MB ?= "100"
TEGRA_DATA_PART_FSOPTS ?= ""
TEGRA_DATA_PART_DIR ?= "data"
TEGRA_DATA_PART_LABEL ?= "DATAPART_EXPAND"
IMAGE_ROOTFS_EXCLUDE_PATH += " ${TEGRA_DATA_PART_DIR}"

DATAFILE ?= "${IMAGE_BASENAME}-${MACHINE}.dataimg"
IMAGE_TEGRAFLASH_DATA ?= "${IMGDEPLOYDIR}/${IMAGE_LINK_NAME}.dataimg"

IMAGE_TYPEDEP:tegraflash += "tegra_dataimg"

IMAGE_CMD:tegra_dataimg() {
    if [ ${TEGRA_DATAIMG_TYPE} = "btrfs" ]; then
        force_flag="-f"
        root_dir_flag="-r"
    else #Assume ext3/4
        force_flag="-F"
        root_dir_flag="-d"
    fi

    root_dir_copy_opts="$root_dir_flag ${IMAGE_ROOTFS}/${TEGRA_DATA_PART_DIR}"
    if [ ! -d "${IMAGE_ROOTFS}/${TEGRA_DATA_PART_DIR}" ]; then
        echo "Found empty data content in rootfs at ${IMAGE_ROOTFS}/${TEGRA_DATA_PART_DIR}, creating empty data partition"
        root_dir_copy_opts=""
    fi

    dd if=/dev/zero of="${WORKDIR}/data.${TEGRA_DATAIMG_TYPE}" count=0 bs=1M seek=${TEGRA_DATA_PART_SIZE_MB}
    mkfs.${TEGRA_DATAIMG_TYPE} \
        $force_flag \
        "${WORKDIR}/data.${TEGRA_DATAIMG_TYPE}" \
        $root_dir_copy_opts \
        -L ${TEGRA_DATA_PART_LABEL} \
        ${TEGRA_DATA_PART_FSOPTS}
    install -m 0644 "${WORKDIR}/data.${TEGRA_DATAIMG_TYPE}" "${IMAGE_TEGRAFLASH_DATA}"
}

do_image_tegra_dataimg[depends] += "e2fsprogs-native:do_populate_sysroot"
