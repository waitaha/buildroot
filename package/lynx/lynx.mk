################################################################################
#
# lynx
#
################################################################################

LYNX_VERSION = 2.9.2
LYNX_SOURCE = lynx$(LYNX_VERSION).tar.bz2
LYNX_SITE = https://invisible-mirror.net/archives/lynx/tarballs
LYNX_LICENSE = GPL-2.0
LYNX_LICENSE_FILES = COPYING
LYNX_CPE_ID_VALID = YES

LYNX_DEPENDENCIES = host-pkgconf $(TARGET_NLS_DEPENDENCIES)

ifeq ($(BR2_REPRODUCIBLE),y)
# configuration info leaks build paths
LYNX_CONF_OPTS += --disable-config-info
# disable build timestamp
LYNX_CFLAGS += -DNO_BUILDSTAMP
endif

ifeq ($(BR2_PACKAGE_NCURSES),y)
LYNX_DEPENDENCIES += ncurses
LYNX_CONF_OPTS += --with-screen=ncurses$(if $(BR2_PACKAGE_NCURSES_WCHAR),w)
else ifeq ($(BR2_PACKAGE_SLANG),y)
LYNX_DEPENDENCIES += slang
LYNX_CONF_OPTS += --with-screen=slang
endif

ifeq ($(BR2_PACKAGE_OPENSSL),y)
LYNX_DEPENDENCIES += openssl
LYNX_CONF_OPTS += --with-ssl=$(STAGING_DIR)/usr
LYNX_LIBS += `$(PKG_CONFIG_HOST_BINARY) --libs openssl`
else ifeq ($(BR2_PACKAGE_GNUTLS),y)
LYNX_DEPENDENCIES += gnutls
LYNX_CONF_OPTS += --with-gnutls
endif

ifeq ($(BR2_PACKAGE_ZLIB),y)
LYNX_DEPENDENCIES += zlib
LYNX_CONF_OPTS += --with-zlib
else
LYNX_CONF_OPTS += --without-zlib
endif

ifeq ($(BR2_PACKAGE_LIBIDN),y)
LYNX_DEPENDENCIES += libidn
LYNX_LIBS += `$(PKG_CONFIG_HOST_BINARY) --libs libidn`
endif

LYNX_CONF_ENV = \
	LDFLAGS="$(TARGET_LDFLAGS) $(LYNX_LIBS)" \
	CFLAGS="$(TARGET_CFLAGS) $(LYNX_CFLAGS)"

$(eval $(autotools-package))
