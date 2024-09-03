include $(TOPDIR)/rules.mk
include ./pkg-arch.mk

PKG_NAME:=mosdns
PKG_VERSION:=5.3.3
PKG_RELEASE:=1

PKG_BINARY_FILE:=mosdns-linux-$(PKG_ARCH).zip
PKG_BINARY_FILE_URL:=https://github.com/IrineSistiana/mosdns/releases/download/v$(PKG_VERSION)/

PKG_INIT_FILE:=mosdns-init-openwrt
PKG_INIT_FILE_URL:=https://github.com/IrineSistiana/mosdns/raw/v$(PKG_VERSION)/scripts/openwrt/
PKG_INIT_FILE_HASH:=669d3318c740c1e5181b3637802e094c00499333f67f263372f620811feafcf8

PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILE:=LICENSE
PKG_MAINTAINER:=Xu Yiming <xuyiming.open@outlook.com>

PKG_BUILD_PARALLEL:=1
PKG_USE_MIPS16:=0
PKG_BUILD_FLAGS:=no-mips16

include $(INCLUDE_DIR)/package.mk

define Download/mosdns
	FILE:=$(PKG_BINARY_FILE)
	URL:=$(PKG_BINARY_FILE_URL)
	HASH:=skip
endef

define Download/mosdns-init
	FILE:=$(PKG_INIT_FILE)
	URL:=$(PKG_INIT_FILE_URL)
	HASH:=$(PKG_INIT_FILE_HASH)
endef

define Build/Prepare
	unzip -q -d $(PKG_BUILD_DIR) $(DL_DIR)/$(PKG_BINARY_FILE)
	$(CP) $(DL_DIR)/$(PKG_INIT_FILE) $(PKG_BUILD_DIR)/mosdns.init
endef

define Build/Compile
endef

define Package/mosdns
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=IP Addresses and Names
	TITLE:=A plug-in DNS forwarder/splitter
	URL:=https://github.com/IrineSistiana/mosdns
	DEPENDS:=@(aarch64||arm||(mips64el&&HAS_FPU)||mipsel||powerpc64||x86_64) +ca-bundle
endef

define Package/mosdns/conffiles
/etc/mosdns/config.yaml
endef

define Package/mosdns/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/mosdns \
		$(1)/usr/bin/

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/mosdns.init \
		$(1)/etc/init.d/mosdns

	$(INSTALL_DIR) $(1)/etc/mosdns
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/config.yaml \
		$(1)/etc/mosdns/
endef

$(eval $(call Download,mosdns))
$(eval $(call Download,mosdns-init))
$(eval $(call BuildPackage,mosdns))
