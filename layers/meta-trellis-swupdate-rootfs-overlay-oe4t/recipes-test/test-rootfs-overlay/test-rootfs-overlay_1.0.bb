DESCRIPTION = "Test scripts for data overlay and symlink layer"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

SRC_URI = "\
    file://test-rootfs-overlay.sh \
    file://test-factory-reset.sh \
"

UNPACKDIR_COMPAT = "${@'${WORKDIR}' if not d.getVar('UNPACKDIR') else d.getVar('UNPACKDIR', expand=True)}"

do_install:append() {
    install -d 0744 ${D}${bindir}
    install ${UNPACKDIR_COMPAT}/test-rootfs-overlay.sh -m 0755 ${D}${bindir}
    install ${UNPACKDIR_COMPAT}/test-factory-reset.sh -m 0755 ${D}${bindir}
}

FILES:${PN} += "${bindir}/*"
