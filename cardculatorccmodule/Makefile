TARGET := iphone:clang:latest:12.2

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = CardculatorCCModule

CardculatorCCModule_BUNDLE_EXTENSION = bundle
CardculatorCCModule_FILES = $(shell find Sources/CardculatorCCModule -name '*.swift') $(shell find Sources/CardculatorCCModuleC -name '*.m' -o -name '*.c' -o -name '*.mm' -o -name '*.cpp')
CardculatorCCModule_SWIFTFLAGS = -ISources/CardculatorCCModuleC/include
CardculatorCCModule_INSTALL_PATH = /Library/ControlCenter/Bundles/
CardculatorCCModule_PRIVATE_FRAMEWORKS = ControlCenterUIKit
CardculatorCCModule_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk