THEOS_DEVICE_IP = 192.168.1.106
THEOS_DEVICE_PORT = 22

TARGET := iphone:clang:latest:14.0
INSTALL_TARGET_PROCESSES = SpringBoard


TWEAK_NAME = Cardculator

$(TWEAK_NAME)_FILES = $(shell find Sources/Cardculator -name '*.swift') $(shell find Sources/CardculatorC -name '*.m' -o -name '*.c' -o -name '*.mm' -o -name '*.cpp')
$(TWEAK_NAME)_SWIFTFLAGS = -ISources/CardculatorC/include
$(TWEAK_NAME)_CFLAGS = -fobjc-arc -ISources/CardculatorC/include
$(TWEAK_NAME)_LIBRARIES += activator

BUNDLE_NAME = CardculatorPreferences
$(BUNDLE_NAME)_FILES = $(shell find Sources/CardculatorPreferences -name '*.swift')
$(BUNDLE_NAME)_INSTALL_PATH = /Library/PreferenceBundles
$(BUNDLE_NAME)_CFLAGS = -fobjc-arc
$(BUNDLE_NAME)_FRAMEWORKS = Preferences
$(BUNDLE_NAME)_EXTRA_FRAMEWORKS = Cephei


include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/bundle.mk
include $(THEOS_MAKE_PATH)/aggregate.mk
