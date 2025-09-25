# Post installation

## 配置obmc-ikvm

### 复制EDID到 Rapsberry Pi 4，假设EDID保存为`/opt/edid`

### 修改`/usr/bin/create_usbhid.sh`设置TC358743的EDID信息

```diff
   if [ ! -e "${hid_conf_directory}" ]; then
        modprobe -a tc358743 bcm2835_unicam i2c_mux_pinctrl libcomposite dwc2
+       v4l2-ctl --set-edid=file=/opt/edid
        create_hid
    else
        cd "${hid_conf_directory}" || exit 1
    fi
```

### 必要的话清理 TC358743 的采集帧队列

```bash
v4l2-ctl --stream-mmap --stream-to=/dev/null --stream-count=30
```

## 配置 BMC 状态

### 配置 phosphor-led-manager服务，创建`/usr/share/phosphor-led/manager/led-group-config.json`

```json
{
  "version": 1,
  "leds": [
    {
      "group": "bmc_booted",
      "members": [
      ],
      "Priority": 0
    },
    {
      "group": "power_on",
      "members": [
      ]
    }
  ]
}
```

### ttyS0相关服务初始化可能会影响启动时间，暂时禁用`serial-getty@ttyS0.service`

```bash
systemctl mask serial-getty@ttyS0.service
```

### `phosphor-health-monitor`监测的部分节点在 Raspberry Pi 4无法访问，暂时需要禁用`phosphor-health-monitor`服务

```bash
systemctl disable phosphor-health-monitor.service
```

以上操作完成后，系统启动后BMC 组件的状态可进入 Ready。

## 配置 Power Control 服务

### 激活 Power Control 服务

```bash
systemctl enable org.openbmc.control.Power@0.service
```

### 检查 GPIO 配置，文件位于 `/etc/default/obmc/gpio/gpio_defs.json`

以下是可用于 Raspberry Pi 4 的`/etc/default/obmc/gpio/gpio_defs.json`的最小配置
```json
{
  "gpio_configs": {
    "power_config": {
      "power_good_in": "PGOOD",
      "power_up_outs": [
        {"name": "POWER_BUTTON", "polarity": true} 
      ],
      "reset_outs": [
      ]
    }
  },
  "gpio_definitions": [
    {
      "name": "PGOOD",
      "num": 24,
      "direction": "in"
    },
    {
      "name": "POWER_BUTTON",
      "num": 23,
      "direction": "both"
    },
    {
      "name": "RESET_BUTTON",
      "num": 27,
      "direction": "both"
    }
  ]
}
```
