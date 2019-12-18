include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = cmarkprefs

cmarkprefs_FILES = ABORootListController.m ABONewListController.m
cmarkprefs_INSTALL_PATH = /Library/PreferenceBundles
cmarkprefs_FRAMEWORKS = UIKit
cmarkprefs_PRIVATE_FRAMEWORKS = Preferences
cmarkprefs_CFLAGS = -fobjc-arc
cmarkprefs_EXTRA_FRAMEWORKS = Cephei CepheiPrefs

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/cmarkprefs.plist$(ECHO_END)
