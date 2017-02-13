//
//  SnapscreenWebSearchResult.h
//  SnapscreenKit
//
//  Created by Martin Reichart on 20/08/16.
//  Copyright © 2016 Snapscreen Application GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/// Enum to define the various web resources types that can be accessed via the SDK.
typedef NS_ENUM(NSInteger, SnapscreenWebSearchResultType) {
    /// A Website
    SnapscreenWebSearchResultTypeSite,
    /// An image
    SnapscreenWebSearchResultTypeImage,
    /// A video
    SnapscreenWebSearchResultTypeVideo
};

/**
 
 Base class for web search results fetched via web searches.
 
 */
@interface SnapscreenWebSearchResult : NSObject

/** The type of the web resource */
@property (readonly) SnapscreenWebSearchResultType type;

/** The unique ID of this result - intended for internal purposes only */
@property (readonly, nonnull) NSString* uuid;

/** The unique ID of the search request from which this result originated - intended for internal purposes only */
@property (readonly, nonnull) NSString* requestUUID;

/**

 Use this URL to open a SFSafariViewController when the user wants to visit the search result. This is required for result tracking and ordering!
 
 */
@property (readonly, nonnull) NSURL* visitURL;

@end
