#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
#echo 'src-git luci-app-openclash https://github.com/vernesong/OpenClash' >> feeds.conf.default
sed -i '$a src-git mosdns https://github.com/QiuSimons/openwrt-mos.git' feeds.conf.default
#sed -i '$a src-git netdata https://github.com/sirpdboy/luci-app-netdata.git' feeds.conf.default
#sed -i '$a src-git chinadns https://github.com/pexcn/openwrt-chinadns-ng.git' feeds.conf.default
#sed -i '$a src-git homeproxy https://github.com/immortalwrt/homeproxy.git' feeds.conf.default
#sed -i '$a src-git argon https://github.com/jerrykuku/luci-theme-argon.git' feeds.conf.default
