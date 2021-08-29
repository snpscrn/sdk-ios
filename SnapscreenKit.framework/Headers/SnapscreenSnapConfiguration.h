//
//  SnapscreenSnapConfiguration.h
//  SnapscreenKit
//
//  Created by Martin Reichart on 10/02/2017.
//  Copyright © 2017 Snapscreen Application GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 
 Configuration object to be passed when snapping. Allows you to specifiy what result types you are interested in and additional behaviour of the snapping process.
 
 */
@interface SnapscreenSnapConfiguration : NSObject

/** Search for TV results of type `SnapscreenTvSearchResult` */
@property (nonatomic, assign) BOOL searchForTvResults;

/** Search for advertisements of type `SnapscreenAdvertisementSearchResult` */
@property (nonatomic, assign) BOOL searchForAdvertisements;

/** Search for sport event results of type `SnapscreenSportEventSearchResult` */
@property (nonatomic, assign) BOOL searchForSportEvents;

/** Perform automatic snapping (provided that the specified result types support autosnapping */
@property (nonatomic, assign) BOOL automaticSnap;

/** The minimum interval between automatic snap attempts in seconds; Defaults to 0.5 */
@property (nonatomic, assign) NSTimeInterval autosnapIntervalInSeconds;

/** The time interval after which automatic snapping stops when no results are found; Defaults to 30 seconds */
@property (nonatomic, assign) NSTimeInterval autosnapTimeoutDuration;

/** Perform quadrangle detection and highlighting. Defaults to YES */
@property (nonatomic, assign) BOOL quadrangleDetection;

/** Whether to use a custom logo in snap view or the original snapscreen logo. If true and no logo is provided, no logo is shown */
@property (nonatomic, assign) BOOL useCustomSnapLogo;

/** A custom logo to display during snapping. The logo is shown as is and not modified in any way */
@property (nonatomic, strong) UIImage* customSnapLogoImage;

/** The size for the custom snap logo. If not provided the implicit image size will be used */
@property (nonatomic, assign) CGSize customSnapLogoImageSize;

@end
