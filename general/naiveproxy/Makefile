# SPDX-License-Identifier: GPL-3.0-only
#
# Copyright (C) 2021 ImmortalWrt.org

include $(TOPDIR)/rules.mk

PKG_NAME:=naiveproxy
PKG_VERSION:=117.0.5938.44-1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/klzgrad/naiveproxy/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=42bc36a068711bc0752930c201371495bd39279caed41e6ff4097e2b05d1844c

PKG_LICENSE:=BSD 3-Clause
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Tianling Shen <cnsztl@immortalwrt.org>

ifneq ($(wildcard $(TOPDIR)/feeds/packages/devel/ninja/ninja.mk),)
PKG_BUILD_DEPENDS+= ninja/host
endif
NINJA ?= ninja
PKG_USE_MIPS16:=0
PKG_BUILD_PARALLEL:=1
PKG_BUILD_FLAGS:=no-mips16

ifneq ($(CONFIG_CPU_TYPE)," ")
  CPU_TYPE:=$(word 1, $(subst +," ,$(CONFIG_CPU_TYPE)))
  CPU_SUBTYPE:=$(word 2, $(subst +, ",$(CONFIG_CPU_TYPE)))
  ifeq ($(CPU_SUBTYPE),)
    CPU_SUBTYPE:=""
  endif
else
  CPU_TYPE:=""
  CPU_SUBTYPE:=""
endif

include $(INCLUDE_DIR)/package.mk

define Package/naiveproxy
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Web Servers/Proxies
  TITLE:=Make a fortune quietly
  URL:=https://github.com/klzgrad/naiveproxy
  DEPENDS:=@!(arc||armeb||mips||mips64||powerpc||riscv64||TARGET_gemini) +libatomic
endef

define Package/naiveproxy/description
  NaïveProxy uses Chrome's network stack to camouflage traffic with strong
  censorship resistance and low detectability. Reusing Chrome's stack also
  ensures best practices in performance and security.
endef

ifneq ($(CONFIG_CCACHE),)
  export CCACHE_SLOPPINESS=time_macros
  export CCACHE_BASEDIR=$(PKG_BUILD_DIR)/src
  export CCACHE_CPP2=yes
  export naive_ccache_flags=cc_wrapper="$(CCACHE)"
endif

CLANG_VER:=18-init-1174-g2532b68f-1
CLANG_FILE:=clang-llvmorg-$(CLANG_VER).tgz
define Download/CLANG
	URL:=https://commondatastorage.googleapis.com/chromium-browser-clang/Linux_x64
	URL_FILE:=$(CLANG_FILE)
	FILE:=$(CLANG_FILE)
	HASH:=1165d4130ae40efdb48427a6098c7cce393c09e00dc1feda9c91bdcf43a77eaf
endef

GN_VER:=991530ce394efb58fcd848195469022fa17ae126
GN_FILE:=gn-git_revision-$(GN_VER).zip
define Download/GN_TOOL
	URL:=https://chrome-infra-packages.appspot.com/dl/gn/gn/linux-amd64/+
	URL_FILE:=git_revision:$(GN_VER)
	FILE:=$(GN_FILE)
	HASH:=63bb0e23f0d2f5933435f497b91150892eb30dd5945e6851e0ab493ff2c6dbe1
endef

PGO_VER:=5938-1693935896-daaeff75cfda3bcc13276975ff4ba18cb55c14c5
PGO_FILE:=chrome-linux-$(PGO_VER).profdata
define Download/PGO_PROF
	URL:=https://storage.googleapis.com/chromium-optimization-profiles/pgo_profiles
	URL_FILE:=$(PGO_FILE)
	FILE:=$(PGO_FILE)
	HASH:=f4048d5a96163b585f5e8495d5cf48f0109492251e8e602c4223454c64f054fe
endef

define Build/Prepare
	$(call Build/Prepare/Default)

	( \
		pushd $(PKG_BUILD_DIR)/src ; \
		mkdir -p "chrome/build/pgo_profiles" ; \
		$(CP) "$(DL_DIR)/$(PGO_FILE)" "chrome/build/pgo_profiles" ; \
		mkdir -p "third_party/llvm-build/Release+Asserts" ; \
		$(TAR) -xzf "$(DL_DIR)/$(CLANG_FILE)" -C "third_party/llvm-build/Release+Asserts" ; \
		echo -e "llvmorg-$(CLANG_VER)" > "third_party/llvm-build/Release+Asserts/cr_build_revision" ; \
		mkdir -p "gn/out" ; \
		unzip -o "$(DL_DIR)/$(GN_FILE)" -d "gn/out" ; \
		popd ; \
	)
endef

define Build/Configure
	( \
		pushd "$(PKG_BUILD_DIR)/src" ; \
		. ../init_env.sh "$(ARCH)" $(CPU_TYPE) $(CPU_SUBTYPE) "$(TOOLCHAIN_DIR)" ; \
		export naive_flags+=" $$$${naive_ccache_flags}" ; \
		mkdir -p "out" ; \
		./gn/out/gn gen "out/Release" --args="$$$${naive_flags}" --script-executable="$(PYTHON)" ; \
		popd ; \
	)
endef

define Build/Compile
	+$(NINJA) -C "$(PKG_BUILD_DIR)/src/out/Release" naive
endef

define Package/naiveproxy/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/out/Release/naive $(1)/usr/bin/naive
endef

$(eval $(call Download,CLANG))
$(eval $(call Download,GN_TOOL))
$(eval $(call Download,PGO_PROF))

$(eval $(call BuildPackage,naiveproxy))
