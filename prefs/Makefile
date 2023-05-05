ARCHS = arm64 arm64e
TARGET := iphone:clang:16.4:14.5

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = prefs

prefs_EXTRA_FRAMEWORKS = Comet
prefs_FRAMEWORKS = SwiftUI
prefs_FILES = $(shell find Sources/prefs -name '*.swift') $(shell find Sources/prefsC -name '*.m' -o -name '*.c' -o -name '*.mm' -o -name '*.cpp')
prefs_SWIFTFLAGS = -ISources/prefsC/include
prefs_INSTALL_PATH = /Library/PreferenceBundles
prefs_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk
