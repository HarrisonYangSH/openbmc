RDEPENDS:${PN}-chassis-state-mgmt:append:openbmc-phosphor = " \
        phosphor-skeleton-control-power \
        pldm \
        libmctp \
        "

RDEPENDS:${PN}-ikvm:append:openbmc-phosphor = " \
        v4l-utils \
        "

RDEPENDS:${PN}-extras:append:openbmc-phosphor = " \
        dbus-sensors \
        entity-manager \
        ipmitool \
        "