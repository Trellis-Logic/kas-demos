DESCRIPTION = "Custom flash layout file to add data partition"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

SRC_URI = " \
            file://external-flash.xml \
"

INHIBIT_DEFAULT_DEPS = "1"

FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

S = "${WORKDIR}"

do_compile[noexec] = "1"

do_install() {
    install -d ${D}${datadir}/custom-flash-layout
    install -m 0644 ${S}/external-flash.xml ${D}${datadir}/custom-flash-layout/
}

PACKAGE_ARCH = "${MACHINE_ARCH}"

inherit nopackages
