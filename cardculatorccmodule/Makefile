TARGET := iphone:clang:14.5:14.0
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = CardculatorCCModule
CardculatorCCModule_BUNDLE_EXTENSION = bundle
CardculatorCCModule_FILES = CardculatorCCModule.m
CardculatorCCModule_CFLAGS = -fobjc-arc
CardculatorCCModule_INSTALL_PATH = /Library/ControlCenter/Bundles/
CardculatorCCModule_PRIVATE_FRAMEWORKS = ControlCenterUIKit

include $(THEOS_MAKE_PATH)/bundle.mk
