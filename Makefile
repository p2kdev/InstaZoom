include $(THEOS)/makefiles/common.mk

export ARCHS = arm64 arm64e
export TARGET = iphone:clang:13.0:13.0

TWEAK_NAME = InstaZoom
InstaZoom_FILES = Tweak.xm $(wildcard lib/*.m)
InstaZoom_FRAMEWORKS = UIKit AVFoundation AVKit
InstaZoom_CFLAGS = -fobjc-arc -Wno-deprecated-declarations -Wno-nullability-completeness

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 Instagram"
