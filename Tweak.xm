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
//static UILongPressGestureRecognizer* videoLongPressGesture;

// %hook IGViewController
//
// - (void)viewDidAppear:(_Bool)arg1{
// %orig();
// UILongPressGestureRecognizer *pressView = MSHookIvar<UILongPressGestureRecognizer *>(self, "_longPressRecognizer");
// [self.view removeGestureRecognizer:pressView];
// }
//
// %end

// %hook IGVideoClassicOverlayView
//
// // -(void)setDelegate {
// - (void)layoutSubviews {
//   	%orig();
// 		if (!videoLongPressGesture)
// 		{
// 			// for (UIGestureRecognizer *recognizer in self.gestureRecognizers)
// 			// {
// 			// 	if ([recognizer isKindOfClass:[UILongPressGestureRecognizer class]])
// 	    //     [self removeGestureRecognizer:recognizer];
// 	    // }
//
// 			UILongPressGestureRecognizer *videoLongPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressed:)];
// 			//[longPress setDelegate:(id<UIGestureRecognizerDelegate>)self];
// 			[videoLongPressGesture setMinimumPressDuration:1];
// 			[self addGestureRecognizer:videoLongPressGesture];
// 		}
// 	}
//
// 	%new
// 	- (void)longPressed:(UIGestureRecognizer *)longPress {
// 	  if (longPress.state != UIGestureRecognizerStateBegan) return;
//
// 		IGVideo *videoView = ((IGFeedItemVideoView*)self.superview).video;
//
// 		if (videoView)
// 		{
// 			NSURL *videoUrl = [videoView videoURLForCurrentNetworkConditions];
// 			AVPlayer *player = [AVPlayer playerWithURL:videoUrl];
// 			AVPlayerViewController *playerViewController = [AVPlayerViewController new];
// 			playerViewController.player = player;
// 			playerViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
// 			[[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:playerViewController animated:YES completion:^{
// 			  [playerViewController.player play];
// 			}];
// 		}
// 	}
//
// %end

%hook IGImageView
- (id)initWithFrame:(CGRect)arg1 shouldBackgroundDecode:(BOOL)arg2 shouldUseProgressiveJPEG:(BOOL)arg4 placeholderProvider:(id)arg5{
	id orig = %orig;
	if (!imageLongPressGesture)
	{
		UILongPressGestureRecognizer *imageLongPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressed:)];
		//[longPress setDelegate:(id<UIGestureRecognizerDelegate>)self];
		[imageLongPressGesture setMinimumPressDuration:1];
		[self addGestureRecognizer:imageLongPressGesture];
	}
  return orig;
}

%new
- (void)longPressed:(UIGestureRecognizer *)longPress {
  if (longPress.state != UIGestureRecognizerStateBegan) return;

	//UIImageWriteToSavedPhotosAlbum(self.image, nil, nil, nil);
	InstaZoomImageViewController *imageVC = [[%c(InstaZoomImageViewController) alloc] initWithSourceImage:self.image];

	if (imageVC)
	{
		imageVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
		imageVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
		//AppDelegate *igDelegate = [UIApplication sharedApplication].delegate;
	  [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:imageVC animated:YES completion:nil];
	}
}
%end
