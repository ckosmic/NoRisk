INSTALL_TARGET_PROCESSES = MobileSMS Springboard

export ARCHS = arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = cmark

cmark_FILES = Tweak.x
cmark_CFLAGS = -fobjc-arc
cmark_EXTRA_FRAMEWORKS = Cephei

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += cmarkprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
