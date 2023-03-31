export THEOS_PACKAGE_SCHEME=rootless
export TARGET = iphone:clang:12.4:12.0

include $(THEOS)/makefiles/common.mk

export ARCHS = arm64 arm64e

TWEAK_NAME = InstaZoom
InstaZoom_FILES = Tweak.xm $(wildcard lib/*.m)
InstaZoom_FRAMEWORKS = UIKit AVFoundation AVKit
InstaZoom_CFLAGS = -fobjc-arc -Wno-deprecated-declarations -Wno-nullability-completeness

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 Instagram"
