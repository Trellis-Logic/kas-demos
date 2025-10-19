FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SRC_URI:append = " file://external-flash-custom.xml"

PARTITION_FILE_EXTERNAL = "${UNPACKDIR}/external-flash-custom.xml"
