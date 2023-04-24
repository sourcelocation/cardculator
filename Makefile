ARCHS = arm64 arm64e
#INSTALL_TARGET_PROCESSES = SpringBoard
INSTALL_TARGET_PROCESSES = Preferences
TARGET := iphone:clang:16.4:13.0
export SYSROOT = $(THEOS)/sdks/iPhoneOS16.4.sdk

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Cardculator

Cardculator_PRIVATE_FRAMEWORKS = SpringBoard SpringBoardServices SpringBoardFoundation MediaRemote MobileTimer SpringBoardUI
Cardculator_FILES = $(shell find Sources/Cardculator -name '*.swift') $(shell find Sources/CardculatorC -name '*.m' -o -name '*.c' -o -name '*.mm' -o -name '*.cpp')
Cardculator_SWIFTFLAGS = -ISources/CardculatorC/include
Cardculator_CFLAGS = -fobjc-arc -ISources/CardculatorC/include

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += prefs
SUBPROJECTS += cardculatorccmodule
include $(THEOS_MAKE_PATH)/aggregate.mk
