//
//  SnapscreenKitTrackingDelegate.h
//  SnapscreenKit
//
//  Created by Martin Fitzka-Reichart on 19.11.20.
//  Copyright © 2020 Snapscreen Application GmbH. All rights reserved.
//

#ifndef SnapscreenKitTrackingDelegate_h
#define SnapscreenKitTrackingDelegate_h


#endif /* SnapscreenKitTrackingDelegate_h */

/**
 Enum for tracking events sent by the SDK to a SnapscreenKitTrackingDelegate
 */
typedef NS_OPTIONS(NSInteger, SnapscreenTrackingEvent) {
    SnapscreenTrackingEventInit,
    SnapscreenTrackingEventTokenAcquired,
    SnapscreenTrackingEventTokenAcquisitionFailed,
    SnapscreenTrackingEventSnapViewOpen,
    SnapscreenTrackingEventSnapViewClose,
    SnapscreenTrackingEventSnapViewSnap,
    SnapscreenTrackingEventSnapViewSnapResult,
    SnapscreenTrackingEventSnapViewSnapNegative,
    SnapscreenTrackingEventSnapViewSnapFail,
    SnapscreenTrackingEventClipShareOpen,
    SnapscreenTrackingEventClipShareNotFound,
    SnapscreenTrackingEventClipShareOpenFail,
    SnapscreenTrackingEventClipSharePreviewPlay,
    SnapscreenTrackingEventClipSharePreviewClose,
    SnapscreenTrackingEventClipShareCreate,
    SnapscreenTrackingEventClipShareCreated,
    SnapscreenTrackingEventClipShareCreateFail,
    SnapscreenTrackingEventClipShareShare,
    SnapscreenTrackingEventClipShareShared,
    SnapscreenTrackingEventClipShareSharedTo,
    SnapscreenTrackingEventClipShareCancel,
    SnapscreenTrackingEventClipShareClose,
    SnapscreenTrackingEventAskForCameraPermission,
    SnapscreenTrackingEventAskForCameraPermissionGranted,
    SnapscreenTrackingEventAskForCameraPermissionDenied
};

#define kSnapscreenTrackingInfoKeySnapDuration @"SnapscreenTrackingInfoKeySnapDuration"
#define kSnapscreenTrackingInfoKeySnapNegativeResultErrorMessage @"SnapscreenTrackingInfoKeySnapNegativeResultErrorMessage"
#define kSnapscreenTrackingInfoKeySnapFailErrorMessage @"SnapscreenTrackingInfoKeySnapFailErrorMessage"
#define kSnapscreenTrackingInfoKeySnapResult @"SnapscreenTrackingSnapResult"

/**
 Delegate for tracking events of the Snapscreen SDK. Implement this to get informed about events from the SDK to implement tracking or statistical analysis.
 */
@protocol SnapscreenKitTrackingDelegate<NSObject>

/**
 Informs the delegate about an event that happened

 @param event An event type of enum type SnapscreenTrackingEvent
 @param infoDictionary An event dictionary with additional values for the tracking event. See kSnapscreenTrackingInfoKey constants for specific keys
 */
- (void) snapscreenKitDidTrackEvent: (SnapscreenTrackingEvent) event infoDictionary: (NSDictionary<NSString*,id>* _Nullable) value;

@end
