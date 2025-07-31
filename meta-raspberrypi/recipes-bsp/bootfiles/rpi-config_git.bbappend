do_deploy:append:raspberrypi4-64() {
    echo "dtparam=i2s=on" >> $CONFIG
    echo "dtparam=i2c_vc=on" >> $CONFIG

    echo "dtoverlay=tc358743" >> $CONFIG
    echo "dtoverlay=tc358743-audio" >> $CONFIG
    echo "dtparam=act_led_gpio=13" >> $CONFIG

    echo "# Enable audio (loads snd_bcm2835)" >> $CONFIG
    echo "dtparam=audio=on" >> $CONFIG

    echo "# SPI (AUM)" >> $CONFIG
    echo "dtoverlay=spi0-1cs" >> $CONFIG

    echo "# Clock" >> $CONFIG
    echo "dtoverlay=i2c-rtc,pcf8563,wakeup-source" >> $CONFIG

    echo 
}
