#
# Copyright (C) 2006-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=lrzsz
PKG_VERSION:=0.12.20
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/sbwml/packages_utils_lrzsz/releases/download/$(PKG_NAME)-$(PKG_VERSION)/
PKG_HASH:=c28b36b14bddb014d9e9c97c52459852f97bd405f89113f30bee45ed92728ff1

PKG_MAINTAINER:=Hsing-Wang Liao <kuoruan@gmail.com>
PKG_LICENSE:=GPL-2.0-or-later
PKG_LICENSE_FILES:=COPYING

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/lrzsz
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Tools for zmodem/xmodem/ymodem file transfer
  URL:=https://ohse.de/uwe/software/lrzsz.html
endef

define Package/lrzsz/description
  lrzsz is a cosmetically modified zmodem/ymodem/xmodem package built
  from the public-domain version of Chuck Forsberg's rzsz package.

  These programs use error correcting protocols ({z,x,y}modem) to send
  (sz, sx, sb) and receive (rz, rx, rb) files over a dial-in serial port
  from a variety of programs running under various operating systems.
endef

define Package/lrzsz/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/lrz $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/lsz $(1)/usr/bin/
	(cd $(1)/usr/bin; \
		ln -fs lrz lrx; \
		ln -fs lrz lrb; \
		ln -fs lrz rz; \
		ln -fs lrz rx; \
		ln -fs lrz rb; \
		ln -fs lsz lsx; \
		ln -fs lsz lsb; \
		ln -fs lsz sz; \
		ln -fs lsz sx; \
		ln -fs lsz sb; \
	);
endef

$(eval $(call BuildPackage,lrzsz))
