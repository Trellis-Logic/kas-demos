FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SRC_URI:append = " \
                file://additions.fstab \
                file://10-wait-for-var-volatile-lib.conf \
                file://10-add-data-log-dir.conf \
"

inherit systemd tegra_dataimg

# Make sure the /data mountpoint is present
# Add a /data/log symlink target
dirs755:append = " /data"
dirs755:append = " /data/log"

# Remove the symlink to volatile on log, we'll add our own /data partition symlink
volatiles:remove = "log"


do_install:append() {
    sed -e"s!@TEGRA_DATA_PART_LABEL@!${TEGRA_DATA_PART_LABEL}!g" -i ${S}/additions.fstab
    cat ${S}/additions.fstab >> ${D}${sysconfdir}/fstab
    ln -s ../data/log ${D}${localstatedir}/log
    install -d 0755 ${D}${sysconfdir}/systemd/systemd-networkd-persistent-storage.service.d/
    install -m 0644 10-wait-for-var-volatile-lib.conf ${D}${sysconfdir}/systemd/systemd-networkd-persistent-storage.service.d/
    install -d 0755 ${D}${sysconfdir}/systemd/systemd-timesyncd.service.d/
    install -m 0644 10-wait-for-var-volatile-lib.conf ${D}${sysconfdir}/systemd/systemd-timesyncd.service.d/
    install -d 0755 ${D}${sysconfdir}/systemd/data-overlay-setup.service.d/
    # Add the /data/log dir in case it's not there already (upgrade scenario)
    install -m 0644 10-add-data-log-dir.conf ${D}${sysconfdir}/systemd/data-overlay-setup.service.d/
}

RDEPENDS:${PN} += "data-overlay-setup"

FILES:${PN} += "${sysconfdir}/systemd/*"
