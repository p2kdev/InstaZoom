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
	@property (nonatomic,retain) UILongPressGestureRecognizer* videoLongPressGesture;
@end

// %hook IGVideoClassicOverlayView
// 	%property (nonatomic,retain) UILongPressGestureRecognizer* videoLongPressGesture;
//
// // -(void)setDelegate {
// - (void)layoutSubviews {
//   	%orig;
// 		if (!self.videoLongPressGesture)
// 		{
// 			// for (UIGestureRecognizer *recognizer in self.gestureRecognizers)
// 			// {
// 			// 	if ([recognizer isKindOfClass:[UILongPressGestureRecognizer class]])
// 	    //     [self removeGestureRecognizer:recognizer];
// 	    // }
//
// 			self.videoLongPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressed:)];
// 			//[longPress setDelegate:(id<UIGestureRecognizerDelegate>)self];
// 			[self.videoLongPressGesture setMinimumPressDuration:1];
// 			[self addGestureRecognizer:self.videoLongPressGesture];
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
	IGImageView* orig = %orig;
	//if (!imageLongPressGesture)
	//{
		UILongPressGestureRecognizer *imageLongPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressed:)];
		//[longPress setDelegate:(id<UIGestureRecognizerDelegate>)self];
		[imageLongPressGesture setMinimumPressDuration:1];
		[orig addGestureRecognizer:imageLongPressGesture];
	//}
  return orig;
}

- (id)initWithFrame:(CGRect)arg1 shouldUseProgressiveJPEG:(BOOL)arg2 placeholderProvider:(id)arg3{
	IGImageView* orig = %orig;
	//if (!imageLongPressGesture)
	//{
		UILongPressGestureRecognizer *imageLongPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressed:)];
		//[longPress setDelegate:(id<UIGestureRecognizerDelegate>)self];
		[imageLongPressGesture setMinimumPressDuration:1];
		[orig addGestureRecognizer:imageLongPressGesture];
	//}
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
