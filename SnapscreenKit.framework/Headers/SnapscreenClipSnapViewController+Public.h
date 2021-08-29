//
//  SnapscreenClipSnapViewController+Public.h
//  SnapscreenKit
//
//  Created by Martin Fitzka-Reichart on 06.11.20.
//  Copyright © 2020 Snapscreen Application GmbH. All rights reserved.
//
#import <UIKit/UIKit.h>

@class SnapscreenClipSharingConfiguration, SnapscreenClipSnapViewController, SnapscreenTvSearchResultEntry;

/**
 Enum for the status update events sent to the SnapscreenClipSnapViewControllerDelegate
 */
typedef NS_OPTIONS(NSInteger, SnapscreenClipSnapStatus) {
    SnapscreenClipSnapStatusSnapDetectingTV,
    SnapscreenClipSnapStatusSnapCalculatingFingerprint,
    SnapscreenClipSnapStatusSnapSendingFingerprint,
    SnapscreenClipSnapStatusSnapWaitingForResponse,
    SnapscreenClipSnapStatusSnapError,
    SnapscreenClipSnapStatusSnapNoResults
};

@protocol SnapscreenClipSharingDelegate;

/**
 Delegate to let the user of the SnapViewController know if manual snapping should be enabled
 */
@protocol SnapscreenClipSnapViewControllerDelegate<NSObject>

/**
 Informs the delegate about whether a manual snap button should be enabled or not
 */
- (void) clipSnapViewController: (SnapscreenClipSnapViewController*) clipSnapViewController shouldSetManualSnapButtonEnabled: (BOOL) enabled;

/**
 Informs the delegate that a snap result was captured
 */
- (void) clipSnapViewController: (SnapscreenClipSnapViewController*) clipSnapViewController didSnapResultEntry: (SnapscreenTvSearchResultEntry*) snapResultEntry;

@optional

/**
 Informs the delegate about a change of the viewfinder size. The viewfinder is always positioned in the center of the full view.
 */
- (void) clipSnapViewController: (SnapscreenClipSnapViewController*) clipSnapViewController didResizeViewFinderToSize: (CGSize) viewFinderSize;

/**
 Informs the delegate when the setup of the snap view is complete and camera capture has started. Also called when the camera feed is restarted, e.g. after the application got inactive or the user navigated away from the viewcontroller and back again.
 */
- (void) clipSnapViewControllerDidStartImageCapture: (SnapscreenClipSnapViewController*) clipSnapViewController;

/**
 Informs the delegate that camera capture has stopped
 */
- (void) clipSnapViewControllerDidStopImageCapture: (SnapscreenClipSnapViewController*) clipSnapViewController;

/**
 Asks the delegate whether standard status updates should be shown - including progress and error messages. Defaults to YES if not implemented.
 If the delegate returns NO, the delegate should respond to the clipSnapViewController:showStatus: callbacks.
 */
- (BOOL) clipSnapViewControllerShouldShowStandardStatusUpdates: (SnapscreenClipSnapViewController*) clipSnapViewController;

/**
 Informs the delegate that a certain status update should be shown
 */
- (void) clipSnapViewController: (SnapscreenClipSnapViewController*) clipSnapViewController didUpdateStatus: (SnapscreenClipSnapStatus) status;

@end

/**
 View Controller to provide clip snapping functionality as a standalone feature without any of the surrounding flow and UI.
 */
@interface SnapscreenClipSnapViewController : UIViewController

/**
 Provides the direct user of this view controller to hide the standard viewfinder and quadrangle detection UI.
 */

@property (nonatomic, assign) BOOL shouldHideStandardViewFinderAndQuadrangleDetection;

/**
 Initialize the view controller with a sharing configuration and a delegate that receives the callbacks at the end of the snap process.

 @param configuration the sharing configuration
 @param delegate the delegate to receive callbacks
 */
- (instancetype) initWithConfiguration: (SnapscreenClipSharingConfiguration*) configuration delegate: (id<SnapscreenClipSnapViewControllerDelegate>) delegate;

/**
 Initiates a manual snap
 */
- (void) takeManualSnap;

/**
 Manually stops camera capture
 */
- (void) stopCameraCapture;

/**
 Manually starts camera capture if possible
 */
- (void) startCameraCapture;

@end
