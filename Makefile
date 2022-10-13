TARGET := iphone:clang:latest:14.0
INSTALL_TARGET_PROCESSES = SpringBoard

TWEAK_NAME = Cardculator

$(TWEAK_NAME)_FILES = $(shell find Sources/$(TWEAK_NAME) -name '*.swift') $(shell find Sources/$(TWEAK_NAME)C -name '*.m' -o -name '*.c' -o -name '*.mm' -o -name '*.cpp')
$(TWEAK_NAME)_SWIFTFLAGS = -ISources/$(TWEAK_NAME)C/include
$(TWEAK_NAME)_CFLAGS = -fobjc-arc -ISources/$(TWEAK_NAME)C/include


BUNDLE_NAME = $(TWEAK_NAME)Preferences
$(BUNDLE_NAME)_FILES = $(shell find Sources/$(BUNDLE_NAME) -name '*.swift')
$(BUNDLE_NAME)_INSTALL_PATH = /Library/PreferenceBundles
$(BUNDLE_NAME)_CFLAGS = -fobjc-arc
$(BUNDLE_NAME)_FRAMEWORKS = Preferences
$(BUNDLE_NAME)_EXTRA_FRAMEWORKS = Cephei


include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/bundle.mk
SUBPROJECTS += cardculatorccmodule
include $(THEOS_MAKE_PATH)/aggregate.mk

