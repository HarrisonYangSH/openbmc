FILESEXTRAPATHS:prepend:raspberrypi4-64 := "${THISDIR}/${PN}:"

SRC_URI:append:raspberrypi4-64 = " file://gpio_defs.json "
