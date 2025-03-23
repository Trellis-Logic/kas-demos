FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SRC_URI:append = " file://10-add-data-ssh-keys-dir.conf \
                   file://10-wait-for-data-overlay-setup.conf \
"

UNPACKDIR_COMPAT = "${@'${WORKDIR}' if not d.getVar('UNPACKDIR') else d.getVar('UNPACKDIR', expand=True)}"

do_install:append() {
    # target /etc/ssh/keys for readonly mount, we will overlay this dir
    sed -i -r -e 's!HostKey\s+/var/run/ssh!HostKey ${sysconfdir}/ssh/keys!g' ${D}${sysconfdir}/ssh/sshd_config_readonly
    ln -s ../../data/ssh/keys ${D}${sysconfdir}/ssh/keys
    install -d 0755 ${D}${sysconfdir}/systemd/system/data-overlay-setup.service.d
    install ${UNPACKDIR_COMPAT}/10-add-data-ssh-keys-dir.conf -m 0644 ${D}${sysconfdir}/systemd/system/data-overlay-setup.service.d/
    install -d 0755 ${D}${sysconfdir}/systemd/system/sshdgenkeys.service.d
    install ${UNPACKDIR_COMPAT}/10-wait-for-data-overlay-setup.conf -m 0644 ${D}${sysconfdir}/systemd/system/sshdgenkeys.service.d/
}

FILES:${PN} += "${sysconfdir}/systemd/system/data-overlay-setup.service.d/*"
FILES:${PN} += "${sysconfdir}/systemd/system/sshdgenkeys.service.d/*"

RDEPENDS:${PN} += "data-overlay-setup"
