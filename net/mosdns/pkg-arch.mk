# Based on
# https://github.com/openwrt/packages/blob/master/lang/golang/golang-values.mk
# https://github.com/IrineSistiana/mosdns/blob/main/release.py

ifeq ($(ARCH),i386)
	PKG_ARCH:=386
else ifeq ($(ARCH),x86_64)
	PKG_ARCH:=amd64
else ifeq ($(ARCH),arm)
	PKG_ARCH:=arm

	TARGET_FPU:=$(word 2,$(subst +,$(space),$(call qstrip,$(CONFIG_CPU_TYPE))))

	# FPU names from https://gcc.gnu.org/onlinedocs/gcc-8.4.0/gcc/ARM-Options.html#index-mfpu-1
	# see also https://github.com/gcc-mirror/gcc/blob/releases/gcc-8.4.0/gcc/config/arm/arm-cpus.in

	ifeq ($(TARGET_FPU),)
		PKG_ARCH+=-5
	else ifneq ($(filter $(TARGET_FPU),vfp vfpv2),)
		PKG_ARCH+=-6
	else
		PKG_ARCH+=-7
	endif
else ifeq ($(ARCH),aarch64)
	PKG_ARCH:=arm64
else ifeq ($(ARCH),mips)
	PKG_ARCH:=mips

	ifeq ($(CONFIG_HAS_FPU),y)
		PKG_ARCH+=-hardfloat
	else
		PKG_ARCH+=-softfloat
	endif
else ifeq ($(ARCH),mipsel)
	PKG_ARCH:=mipsle

	ifeq ($(CONFIG_HAS_FPU),y)
		PKG_ARCH+=-hardfloat
	else
		PKG_ARCH+=-softfloat
	endif
else ifeq ($(ARCH),mips64)
	PKG_ARCH:=mips64

	ifeq ($(CONFIG_HAS_FPU),y)
		PKG_ARCH+=-hardfloat
	else
		PKG_ARCH+=-softfloat
	endif
else ifeq ($(ARCH),mips64el)
	PKG_ARCH:=mips64le

	ifeq ($(CONFIG_HAS_FPU),y)
		PKG_ARCH+=-hardfloat
	else
		PKG_ARCH+=-softfloat
	endif
else ifeq ($(ARCH),powerpc64le)
	PKG_ARCH:=ppc64le
endif
