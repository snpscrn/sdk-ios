//
//  SnapscreenKit.h
//  SnapscreenKit
//
//  Created by Martin Reichart on 20/08/16.
//  Copyright © 2016 Snapscreen Application GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SnapscreenKit/SnapscreenAccessToken.h>
#import <SnapscreenKit/SnapscreenAccessTokenHolder.h>
#import <SnapscreenKit/SnapscreenErrors.h>
#import <SnapscreenKit/SnapscreenLocationProvider.h>
#import <SnapscreenKit/SnapscreenLoggingHandler.h>
#import <SnapscreenKit/SnapscreenNSLogLoggingHandler.h>
#import <SnapscreenKit/SnapscreenCustomerConfiguration.h>

#import <SnapscreenKit/SnapscreenSnapViewController.h>
#import <SnapscreenKit/SnapscreenSnapResultsViewController.h>
#import <SnapscreenKit/SnapscreenSnapConfiguration.h>

#import <SnapscreenKit/SnapscreenSearchResult.h>
#import <SnapscreenKit/SnapscreenTvSearchResult.h>
#import <SnapscreenKit/SnapscreenTvSearchResultEntry.h>
#import <SnapscreenKit/SnapscreenTvChannel.h>
#import <SnapscreenKit/SnapscreenEpgUnit.h>
#import <SnapscreenKit/SnapscreenEpgUnitCredits.h>
#import <SnapscreenKit/SnapscreenEpgUnitPerson.h>

#import <SnapscreenKit/SnapscreenAdvertisementSearchResult.h>
#import <SnapscreenKit/SnapscreenAdvertisementSearchResultEntry.h>
#import <SnapscreenKit/SnapscreenAdvertisement.h>

#import <SnapscreenKit/SnapscreenSportEventSearchResult.h>
#import <SnapscreenKit/SnapscreenSportEventSearchResultEntry.h>
#import <SnapscreenKit/SnapscreenSportEvent.h>
#import <SnapscreenKit/SnapscreenSportEventCompetitor.h>

#import <SnapscreenKit/SnapscreenWebSearchService.h>
#import <SnapscreenKit/SnapscreenPageMetadata.h>
#import <SnapscreenKit/SnapscreenWebSearchResponse.h>
#import <SnapscreenKit/SnapscreenWebSearchResult.h>
#import <SnapscreenKit/SnapscreenWebSearchSiteResult.h>
#import <SnapscreenKit/SnapscreenWebSearchImageResult.h>
#import <SnapscreenKit/SnapscreenWebSearchVideoResult.h>

#import <SnapscreenKit/SnapscreenResultQuadrangle.h>

#import <SnapscreenKit/SnapscreenARSnapViewController.h>

/// Project version number for SnapscreenKit.
FOUNDATION_EXPORT double SnapscreenKitVersionNumber;

/// Project version string for SnapscreenKit.
FOUNDATION_EXPORT const unsigned char SnapscreenKitVersionString[];

/**
 
 Delegate for important callbacks of SnapscreenKit. Implement this to listen for any issues that might make SnapscreenKit unavailable in your application.
 
 */
@protocol SnapscreenKitDelegate<NSObject>
/**
 
 Initializing SnapscreenKit failed and Snapscreen functionality is not available to your application. 
 
 @param error An error object containing an error with a `SnapscreenErrorCode`. See `SnapscreenErrorCode` for a list of possible error codes.
 
 */
- (void) snapscreenKitDidFailWithError: (NSError* _Nonnull) error;
@end

/**
SnapscreenKit offers integration of the Snapscreen functions in your app. Before using, make sure to initially SnapscreenKit with the appropriate clientID and clientSecret and provide optional additional handlers.
 */
@interface SnapscreenKit : NSObject

/** Initialize SnapscreenKit
 
 @param clientID The client ID of your application - provided by Snapscreen
 @param clientSecret The client secret of your application - provided by Snapscreen
 @param connectToTestEnvironment Whether you want SnapscreenKit connect to the test environment of Snapscreen. Pass NO for production use in Release Builds.
 @param loggingHandler An optional logging handler. Pass if you want to receive log messages from SnapscreenKit in your application and attach them to your custom logging solution. For logging to NSLog there is a default implementation in `SnapscreenNSLogLoggingHandler`
 @param locationProvider An optional location provider. If your application determines the user's location in some way, provide this and SnapscreenKit will also use the user's location to improve result quality.
 @param delegate The SnapscreenKit delegate
 
 */
+ (instancetype _Nonnull) sharedSnapscreenKitWithClientID: (NSString* _Nonnull) clientID clientSecret: (NSString* _Nonnull) clientSecret testEnvironment: (BOOL) connectToTestEnvironment loggingHandler: (id<SnapscreenLoggingHandler> _Nullable) loggingHandler locationProvider: (id<SnapscreenLocationProvider> _Nullable) locationProvider delegate: (id<SnapscreenKitDelegate> _Nullable) delegate;

/** Initialize SnapscreenKit and optionally tell the SDK to skip the automatic token handling. **Note: This should never be necessary by SDK users!**
 
 @param clientID The client ID of your application - provided by Snapscreen
 @param clientSecret The client secret of your application - provided by Snapscreen
 @param connectToTestEnvironment Whether you want SnapscreenKit connect to the test environment of Snapscreen. Pass NO for production use in Release Builds.
 @param loggingHandler An optional logging handler. Pass if you want to receive log messages from SnapscreenKit in your application and attach them to your custom logging solution. For logging to NSLog there is a default implementation in `SnapscreenNSLogLoggingHandler`
 @param locationProvider An optional location provider. If your application determines the user's location in some way, provide this and SnapscreenKit will also use the user's location to improve result quality.
 @param delegate The SnapscreenKit delegate
 @param customTokenHandling whether Snapscreenkit should perform automatic token handling. If no, the application itself is fully responsible for getting an access token, refreshing it and always keeping it up to date in the accessTokenHolder
 
 */
+ (instancetype _Nonnull) sharedSnapscreenKitWithClientID: (NSString* _Nonnull) clientID clientSecret: (NSString* _Nonnull) clientSecret testEnvironment: (BOOL) connectToTestEnvironment loggingHandler: (id<SnapscreenLoggingHandler> _Nullable) loggingHandler locationProvider: (id<SnapscreenLocationProvider> _Nullable) locationProvider delegate: (id<SnapscreenKitDelegate> _Nullable) delegate customTokenHandling: (BOOL) customTokenHandling;

/**
 
 Easily access SnapscreenKit once it was initialized before in your application.
 
 */
+ (instancetype _Nullable) sharedSnapscreenKit;

/**
 
 Initializes a UIViewController for performing Snaps of Live TV. Should be presented as a modal UIViewController in your application for best experience.
 
 @param delegate The delegate for the view controller that receives callbacks during the snapping process.
 @param resultsDelegate The delegate for the results view controller that provides customization capabilities for the results display.
 @param snapConfiguration The configuration for the snap

 @return SnapscreenSnapViewController A fully configured view controller for performing a snap. Returns null if you did not initialize SnapscreenKit correctly or an authentication error occured during initialization.
 
 */
- (SnapscreenSnapViewController* _Nullable) instantiateSnapscreenSnapViewControllerWithDelegate: (id<SnapscreenSnapViewControllerDelegate> _Nonnull) delegate resultsDelegate: (id<SnapscreenSnapResultsViewControllerDelegate> _Nullable) resultsDelegate configuration: (SnapscreenSnapConfiguration* _Nonnull) snapConfiguration;

/**
 
 Initializes a UIViewController for performing Live AR display of Snap results. Should be presented as a modal UIViewController in your application for best experience.
 
 @param delegate The delegate for the view controller that receives callbacks during the snapping process.
 @param snapConfiguration The configuration for the snap
 
 @return SnapscreenARSnapViewController A fully configured view controller for performing a snap and displaying live AR results. Returns null if you did not initialize SnapscreenKit correctly or an authentication error occured during initialization.
 
 */
- (SnapscreenARSnapViewController* _Nullable) instantiateARSnapscreenSnapViewControllerWithDelegate: (id<SnapscreenARSnapViewControllerDelegate> _Nonnull) delegate configuration: (SnapscreenSnapConfiguration* _Nonnull) snapConfiguration;

/**
 
 Optional delegate if you want to receive callbacks from SnapscreenKit.
 
 */
@property (nonatomic, weak, nullable) id<SnapscreenKitDelegate> delegate;

/**
 
 The country code the user is in. Affects the results that are found when snapping. Defaults to AT.
 
 */
@property (nonatomic, strong, nonnull) NSString* countryCode;

/**
 
 The locale identifier for the user. Affects the web search results that are found and how they are returned. Defaults to de_AT.
 
 */
@property (nonatomic, strong, nonnull) NSString* localeIdentifier;


/**
 
 A synchronized timestamp representing 'now' - use this if you need a current timestamp for other SnapscreenKit calls and don't want or can't use a result entry from a search.
 
 */
@property (nonatomic, readonly) long long currentSnapscreenTimestamp;

/** 
 
 Service for performing web searches based on snap results
 
 */
@property (readonly, nullable) SnapscreenWebSearchService* webSearchService;


/**
 
 Holds the logging handler that was provided when initializing SnapscreenKit.
 
 */
@property (nonatomic, strong, nullable) id<SnapscreenLoggingHandler> loggingHandler;

/**
 
 Holds the location provider that was provided when initializing SnapscreenKit.
 
 */
@property (nonatomic, strong, nullable) id<SnapscreenLocationProvider> locationProvider;

/**
 
 Container which holds the current access token of SnapscreenKit.
 
 */
@property (readonly, strong, nonnull) SnapscreenAccessTokenHolder* accessTokenHolder;

/**

 Whether SnapscreenKit performs automatic token handling (corresponds to the value passed in the initializer)

 */
@property (readonly, nonatomic) BOOL performsAutomaticTokenHandling;

/**
 
 The current customer configuration - mainly for internal use
 
 */
@property (readonly, strong, nonatomic, nullable) SnapscreenCustomerConfiguration* customerConfiguration;

@end

