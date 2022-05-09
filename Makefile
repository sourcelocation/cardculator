THEOS_DEVICE_IP = 192.168.1.106
THEOS_DEVICE_PORT = 22

TARGET := iphone:clang:latest:14.0
INSTALL_TARGET_PROCESSES = SpringBoard


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Cardculator

Cardculator_FILES = $(shell find Sources/Cardculator -name '*.swift') $(shell find Sources/CardculatorC -name '*.m' -o -name '*.c' -o -name '*.mm' -o -name '*.cpp')
Cardculator_SWIFTFLAGS = -ISources/CardculatorC/include
Cardculator_CFLAGS = -fobjc-arc -ISources/CardculatorC/include
Cardculator_LIBRARIES += activator
#	Cardculator_SWIFT_BRIDGING_HEADER = Cardculator-Bridging-Header.h
#	not needed for now

include $(THEOS_MAKE_PATH)/tweak.mk
