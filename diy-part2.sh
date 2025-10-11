#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

#!/bin/bash
# DIY script part 2 (After feeds update and install)
#安装自定义插件包
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 23.x feeds/packages/lang/golang
./scripts/feeds install vsftpd openssh-sftp-server
git clone --depth=1 https://github.com/pexcn/openwrt-chinadns-ng.git package/chinadns-ng
git clone -b dev --depth=1 https://github.com/vernesong/OpenClash.git package/OpenClash
git clone --depth=1 https://github.com/immortalwrt/homeproxy.git package/homeproxy
rm -rf feeds/packages/net/v2ray-geodata
git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config
git clone https://github.com/sbwml/luci-app-alist package/alist

# 设置默认 IP 地址为 10.10.10.1
sed -i 's/192.168.1.1/10.10.10.1/g' package/base-files/files/bin/config_generate

# 修改rust编译配置
sed -i 's/download-ci-llvm=true/download-ci-llvm=false/g' feeds/packages/lang/rust/Makefile

# 设置 root 文件系统分区大小为 1G
sed -i 's/CONFIG_TARGET_KERNEL_PARTSIZE=.*/CONFIG_TARGET_KERNEL_PARTSIZE=16/g' .config
sed -i 's/CONFIG_TARGET_ROOTFS_PARTSIZE=.*/CONFIG_TARGET_ROOTFS_PARTSIZE=1024/g' .config

# 设置编译架构为 x86-64，Target Images 为 squashfs
sed -i 's/^# CONFIG_TARGET_x86 is not set/CONFIG_TARGET_x86=y/' .config
sed -i 's/^# CONFIG_TARGET_x86_64 is not set/CONFIG_TARGET_x86_64=y/' .config
sed -i 's/^# CONFIG_TARGET_IMAGES_GZIP is not set/CONFIG_TARGET_IMAGES_GZIP=y/' .config
sed -i 's/^CONFIG_TARGET_IMAGES_SQUASHFS=y//' .config

# 替换 dnsmasq 为 dnsmasq-full
sed -i 's/^# CONFIG_PACKAGE_dnsmasq-full is not set/CONFIG_PACKAGE_dnsmasq-full=y/' .config
sed -i 's/^CONFIG_PACKAGE_dnsmasq=y/# CONFIG_PACKAGE_dnsmasq is not set/' .config

# 使用 luci-ssl-openssl
sed -i 's/^# CONFIG_PACKAGE_luci-ssl-openssl is not set/CONFIG_PACKAGE_luci-ssl-openssl=y/' .config
sed -i 's/^CONFIG_PACKAGE_luci-ssl=y/# CONFIG_PACKAGE_luci-ssl is not set/' .config

# 设置 Luci 界面语言为中文
echo "CONFIG_PACKAGE_luci-i18n-base-zh-cn=y" >> .config

# 设置 Luci 主题为 Argon
echo "CONFIG_PACKAGE_luci-theme-argon=y" >> .config

# 安装所需的插件
#cat <<EOF >> .config
#CONFIG_PACKAGE_chinadns-ng=y
#CONFIG_PACKAGE_luci-app-statistics=y
#CONFIG_PACKAGE_luci-app-openclash=y
#CONFIG_PACKAGE_luci-app-netdata=y
#CONFIG_PACKAGE_mosdns=y
#CONFIG_PACKAGE_homeproxy=y
#EOF

# 添加必要的功能包（blockd 插件）
echo "CONFIG_PACKAGE_blockd=y" >> .config

# 清理多余选项，确保配置一致性
make defconfig


# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate
