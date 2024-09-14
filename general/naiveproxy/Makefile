include $(TOPDIR)/rules.mk

PKG_NAME:=naiveproxy
PKG_VERSION:=128.0.6613.40-3
PKG_RELEASE:=1

ARCH_PREBUILT:=$(ARCH_PACKAGES)

# intel 80386 & riscv64 & cortex-a76
ifeq ($(ARCH_PREBUILT),aarch64_cortex-a76)
  ARCH_PREBUILT:=aarch64_generic
else ifeq ($(ARCH_PREBUILT),i386_pentium-mmx)
  ARCH_PREBUILT:=x86
else ifeq ($(ARCH_PREBUILT),i386_pentium4)
  ARCH_PREBUILT:=x86
else ifeq ($(ARCH_PREBUILT),riscv64_riscv64)
  ARCH_PREBUILT:=riscv64
endif

PKG_SOURCE:=naiveproxy-v$(PKG_VERSION)-openwrt-$(ARCH_PREBUILT).tar.xz
PKG_SOURCE_URL:=https://github.com/klzgrad/naiveproxy/releases/download/v$(PKG_VERSION)/

ifeq ($(ARCH_PREBUILT),aarch64_cortex-a53)
  PKG_HASH:=0d7d76e49200be17799cec334e96240e0e8703a801ada4d9ad6e24c5260c5b40
else ifeq ($(ARCH_PREBUILT),aarch64_cortex-a72)
  PKG_HASH:=12636890159578d0f8f71fca2283a904546b2f908b9d53bb170fb479edc7837f
else ifeq ($(ARCH_PREBUILT),aarch64_generic)
  PKG_HASH:=c6cee154fc727950790bb77bc602c36d2b5c296ddd1d40605f445297f5aaee4c
else ifeq ($(ARCH_PREBUILT),arm_arm1176jzf-s_vfp)
  PKG_HASH:=0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5
else ifeq ($(ARCH_PREBUILT),arm_arm926ej-s)
  PKG_HASH:=0e383ef113da9085edb4750dfc2cfbe33e27351bfd767933b88ad1361197d6d7
else ifeq ($(ARCH_PREBUILT),arm_cortex-a15_neon-vfpv4)
  PKG_HASH:=0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5
else ifeq ($(ARCH_PREBUILT),arm_cortex-a5_vfpv4)
  PKG_HASH:=0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5
else ifeq ($(ARCH_PREBUILT),arm_cortex-a7)
  PKG_HASH:=4a0e2b5c9a5368bf229d3bf3dcd650319a59c9c5f5ec471f3d85a8e7d805853b
else ifeq ($(ARCH_PREBUILT),arm_cortex-a7_neon-vfpv4)
  PKG_HASH:=a934e6cc58f2c3778281c972fbc0a66e6f903f16547d895ba8bbe043bd9d8539
else ifeq ($(ARCH_PREBUILT),arm_cortex-a7_vfpv4)
  PKG_HASH:=cd853a7dc9f77b6a15eea0b930d59e24725ba2c2d1eceaf59a3d71c90301e765
else ifeq ($(ARCH_PREBUILT),arm_cortex-a8_vfpv3)
  PKG_HASH:=bd712b65a03b44859a06a1fb4f4ab30d24d97bcdfca204dd79c03fc4cbf2944b
else ifeq ($(ARCH_PREBUILT),arm_cortex-a9)
  PKG_HASH:=d8e4340d94fcccbe98188dc696d9056a7affbdade1c7f73cc62d1d486b6bb5f7
else ifeq ($(ARCH_PREBUILT),arm_cortex-a9_neon)
  PKG_HASH:=571b73b317cbb103e6dc07030f403a95f1727279f7e375bdf646b61987ea4f5f
else ifeq ($(ARCH_PREBUILT),arm_cortex-a9_vfpv3-d16)
  PKG_HASH:=e68cf99fd95a055012b1f6339756510ea9dabc563bafa6ebbd7dc7dbbddc2029
else ifeq ($(ARCH_PREBUILT),arm_mpcore)
  PKG_HASH:=cf180efdee817e20113c73b1c879b0f166d34a3e795eef0becb274e654a70be6
else ifeq ($(ARCH_PREBUILT),arm_xscale)
  PKG_HASH:=ab5662b339e0489d6e4ed46240a8a43f24810c88a86f15124b97d45c11e44f00
else ifeq ($(ARCH_PREBUILT),mipsel_24kc)
  PKG_HASH:=92d3fa43f76d8995531f4601529ab2236f82cdb7195d7466fcdc49e1ddb0d5b7
else ifeq ($(ARCH_PREBUILT),mipsel_mips32)
  PKG_HASH:=9fafdf62222f94639b60c4adfb5f2662a3e1b0183a9ef4eda111bcfa5d05f9ba
else ifeq ($(ARCH_PREBUILT),riscv64)
  PKG_HASH:=6dc6b8bb2e34df2d5f5b32b57538726d93fcd6813535eb342538277e536248e7
else ifeq ($(ARCH_PREBUILT),x86)
  PKG_HASH:=07b855b2643dd5b3d4645b332ed7f858e879028f11960efd312a0f422f1540b4
else ifeq ($(ARCH_PREBUILT),x86_64)
  PKG_HASH:=c80083330e0dc11ab00e362917c25dea3f522c22e825855947d3b79bef896d4b
else
  PKG_HASH:=dummy
endif

PKG_LICENSE:=BSD 3-Clause
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=sbwml <admin@cooluc.com>

PKG_BUILD_DIR:=$(BUILD_DIR)/naiveproxy-v$(PKG_VERSION)-openwrt-$(ARCH_PACKAGES)

include $(INCLUDE_DIR)/package.mk

define Package/naiveproxy
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Web Servers/Proxies
  TITLE:=Make a fortune quietly
  URL:=https://github.com/klzgrad/naiveproxy
  DEPENDS:=@(aarch64||arm||i386||mipsel||riscv64||x86_64) +libatomic
endef

define Package/naiveproxy/description
  NaïveProxy uses Chrome's network stack to camouflage traffic with strong
  censorship resistance and low detectability. Reusing Chrome's stack also
  ensures best practices in performance and security.
endef

define Package/naiveproxy/conffiles
/etc/config/naiveproxy
endef

define Build/Prepare
	$(TAR) --strip-components=1 -C $(PKG_BUILD_DIR) -xJf $(DL_DIR)/naiveproxy-v$(PKG_VERSION)-openwrt-$(ARCH_PREBUILT).tar.xz
endef

define Build/Compile
endef

define Package/naiveproxy/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/naive $(1)/usr/bin/naive
	$(INSTALL_DIR) $(1)/etc/config $(1)/etc/init.d
	$(INSTALL_CONF) $(CURDIR)/files/naiveproxy.config $(1)/etc/config/naiveproxy
	$(INSTALL_BIN) $(CURDIR)/files/naiveproxy.init $(1)/etc/init.d/naiveproxy
endef

$(eval $(call BuildPackage,naiveproxy))
