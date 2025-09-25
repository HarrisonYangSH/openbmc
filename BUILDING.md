# BUILDING

## 准备

### 安装编译依赖(Ubuntu 24.04)

```bash
sudo apt-get -y install git build-essential libsdl1.2-dev texinfo gawk chrpath diffstat
```

### 下载源码

```bash
git clone https://github.com/HarrisonYangSH/openbmc -b raspi4-develop --depth 1
```

## 编译源码

### 初始化编译配置

```bash
. openbmc-env-rpi4
```

### 编译

``` bash
bitbake obmc-phosphor-image
```

编译过程中需要访问较多国外网站，如有条件需设置全局代理优化连接环境。

#### 编译报错

- `Fetcher failure for URL: 'https://www.google.com/'.`

```
Fetcher failure for URL: 'https://www.google.com/'. URL https://www.google.com/ doesn't work.
Please ensure your host's network is configured correctly.
If your ISP or network is blocking the above URL, try with another domain name, for example by setting:
CONNECTIVITY_CHECK_URIS = "https://www.yoctoproject.org/" You could also set
BB_NO_NETWORK = "1" to disable network access if all required sources are on local disk.
```

编译时默认会检查主机是否有互联网连接，可以通过`CONNECTIVY_CHECK_URIS`选项跳过网络检测。编辑`conf/local.conf`增加一条：

```
CONNECTIVITY_CHECK_URIS = ""
```

- `ERROR: Nothing RPROVIDES 'linux-firmware-rpidistro-bcm43455'`

```
ERROR: Nothing RPROVIDES 'linux-firmware-rpidistro-bcm43455' (but /**/openbmc/poky/meta/recipes-core/packagegroups/packagegroup-base.bb RDEPENDS on or otherwise requires it)
linux-firmware-rpidistro RPROVIDES linux-firmware-rpidistro-bcm43455 but was skipped: Has a restricted license 'synaptics-killswitch' which is not listed in your LICENSE_FLAGS_ACCEPTED.
```

默认情况下，某些计算机配置会推荐 WiFi/BT 固件，由 `linux-firmware-rpidistro` 提供。所以构建系
统将只允许在以下情况下构建此配方。
用户通过编辑 `conf/local.conf` 添加以下配置来承认此风险：

```
LICENSE_FLAGS_ACCEPTED = "synaptics-killswitch"
```

### 编译后

编译成功后，在`build/tmp/deploy/images/raspberrypi4-64`目录下可以看到生成的 `obmc-phosphor-image-raspberrypi4-64.rpi-sdimg`格式镜像文件。
