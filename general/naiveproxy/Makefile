# SPDX-License-Identifier: GPL-3.0-only
#
# Copyright (C) 2021 ImmortalWrt.org

include $(TOPDIR)/rules.mk

PKG_NAME:=naiveproxy
PKG_VERSION:=118.0.5993.65-1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/klzgrad/naiveproxy/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=d97193d82e346ec2f753151cee52d00495e2df7688d60a5b4395b8cd39399734

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

CLANG_VER:=17-init-16420-g0c545a44-8
CLANG_FILE:=clang-llvmorg-$(CLANG_VER).tgz
define Download/CLANG
	URL:=https://commondatastorage.googleapis.com/chromium-browser-clang/Linux_x64
	URL_FILE:=$(CLANG_FILE)
	FILE:=$(CLANG_FILE)
	HASH:=3c84d6673efd5a0d40785c9fd510ce347c9a4acf9ffb3b503c707857f5ca8398
endef

GN_VER:=182a6eb05d15cc76d2302f7928fdb4f645d52c53
GN_FILE:=gn-git_revision-$(GN_VER).zip
define Download/GN_TOOL
	URL:=https://chrome-infra-packages.appspot.com/dl/gn/gn/linux-amd64/+
	URL_FILE:=git_revision:$(GN_VER)
	FILE:=$(GN_FILE)
	HASH:=46ecff76a97070c7cb6b37501ca5bc664a62665d3ad3c4a28b2d81fd936f481a
endef

PGO_VER:=5993-1696528594-5b0dc009ef20f14165590ea16444c1ee3dca372e
PGO_FILE:=chrome-linux-$(PGO_VER).profdata
define Download/PGO_PROF
	URL:=https://storage.googleapis.com/chromium-optimization-profiles/pgo_profiles
	URL_FILE:=$(PGO_FILE)
	FILE:=$(PGO_FILE)
	HASH:=1d6b4d7d2dab529ae179097e508d63fc28fd459ee3fe7511e5ed5b329707e0b5
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
