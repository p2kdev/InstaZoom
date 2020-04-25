#line 1 "Tweak.xm"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVPlayerViewController.h>
#import "lib/InstaZoomImageViewController.h"
#import <Foundation/Foundation.h>


@interface IGVideo
	@property (nonatomic,assign,readwrite) NSSet<NSURL*> *allVideoURLs;
	-(id)videoURLForCurrentNetworkConditions;
@end

@interface IGImageSpecifier
	@property (nonatomic,assign,readwrite) NSURL* url;
@end

@interface IGFeedItemVideoView : UIView
	@property (nonatomic,assign,readwrite) IGVideo* video;
@end

@interface IGFeedPhotoView : UIView
@end

@interface IGImageView : UIImageView
	@property (nonatomic,assign,readwrite) IGImageSpecifier* imageSpecifier;
@end

@interface IGViewController : UIViewController
@end

@interface IGVideoClassicOverlayView : IGFeedItemVideoView

@end

static UILongPressGestureRecognizer* imageLongPressGesture;






















































#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class IGImageView; @class InstaZoomImageViewController; 
static IGImageView* (*_logos_orig$_ungrouped$IGImageView$initWithFrame$shouldBackgroundDecode$shouldUseProgressiveJPEG$placeholderProvider$)(_LOGOS_SELF_TYPE_INIT IGImageView*, SEL, CGRect, BOOL, BOOL, id) _LOGOS_RETURN_RETAINED; static IGImageView* _logos_method$_ungrouped$IGImageView$initWithFrame$shouldBackgroundDecode$shouldUseProgressiveJPEG$placeholderProvider$(_LOGOS_SELF_TYPE_INIT IGImageView*, SEL, CGRect, BOOL, BOOL, id) _LOGOS_RETURN_RETAINED; static void _logos_method$_ungrouped$IGImageView$longPressed$(_LOGOS_SELF_TYPE_NORMAL IGImageView* _LOGOS_SELF_CONST, SEL, UIGestureRecognizer *); 
static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$InstaZoomImageViewController(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("InstaZoomImageViewController"); } return _klass; }
#line 89 "Tweak.xm"

static IGImageView* _logos_method$_ungrouped$IGImageView$initWithFrame$shouldBackgroundDecode$shouldUseProgressiveJPEG$placeholderProvider$(_LOGOS_SELF_TYPE_INIT IGImageView* __unused self, SEL __unused _cmd, CGRect arg1, BOOL arg2, BOOL arg4, id arg5) _LOGOS_RETURN_RETAINED{
	id orig = _logos_orig$_ungrouped$IGImageView$initWithFrame$shouldBackgroundDecode$shouldUseProgressiveJPEG$placeholderProvider$(self, _cmd, arg1, arg2, arg4, arg5);
	if (!imageLongPressGesture)
	{
		UILongPressGestureRecognizer *imageLongPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressed:)];
		
		[imageLongPressGesture setMinimumPressDuration:1];
		[self addGestureRecognizer:imageLongPressGesture];
	}
  return orig;
}


static void _logos_method$_ungrouped$IGImageView$longPressed$(_LOGOS_SELF_TYPE_NORMAL IGImageView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UIGestureRecognizer * longPress) {
  if (longPress.state != UIGestureRecognizerStateBegan) return;

	
	InstaZoomImageViewController *imageVC = [[_logos_static_class_lookup$InstaZoomImageViewController() alloc] initWithSourceImage:self.image];

	if (imageVC)
	{
		imageVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
		imageVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
		
	  [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:imageVC animated:YES completion:nil];
	}
}

static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$IGImageView = objc_getClass("IGImageView"); MSHookMessageEx(_logos_class$_ungrouped$IGImageView, @selector(initWithFrame:shouldBackgroundDecode:shouldUseProgressiveJPEG:placeholderProvider:), (IMP)&_logos_method$_ungrouped$IGImageView$initWithFrame$shouldBackgroundDecode$shouldUseProgressiveJPEG$placeholderProvider$, (IMP*)&_logos_orig$_ungrouped$IGImageView$initWithFrame$shouldBackgroundDecode$shouldUseProgressiveJPEG$placeholderProvider$);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UIGestureRecognizer *), strlen(@encode(UIGestureRecognizer *))); i += strlen(@encode(UIGestureRecognizer *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$IGImageView, @selector(longPressed:), (IMP)&_logos_method$_ungrouped$IGImageView$longPressed$, _typeEncoding); }} }
#line 118 "Tweak.xm"
