FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SRC_URI:append = " file://external-flash.xml"

PARTITION_FILE_EXTERNAL = "${UNPACKDIR}/external-flash.xml"
