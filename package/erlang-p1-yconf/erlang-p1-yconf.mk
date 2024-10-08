################################################################################
#
# erlang-p1-yconf
#
################################################################################

ERLANG_P1_YCONF_VERSION = 1.0.16
ERLANG_P1_YCONF_SITE = $(call github,processone,yconf,$(ERLANG_P1_YCONF_VERSION))
ERLANG_P1_YCONF_LICENSE = Apache-2.0
ERLANG_P1_YCONF_LICENSE_FILES = LICENSE
ERLANG_P1_YCONF_DEPENDENCIES = erlang-fast-yaml

$(eval $(rebar-package))
