//
//  SnapscreenWebSearchSiteResult.h
//  SnapscreenKit
//
//  Created by Martin Reichart on 26/09/16.
//  Copyright © 2016 Snapscreen Application GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SnapscreenWebSearchResult.h"

/**
 
 A single resource representing a website.
 
 */
@interface SnapscreenWebSearchSiteResult : SnapscreenWebSearchResult

/** The title of this search result, e.g. the title of a web page as taken from the actual HTML page */
@property (readonly, nullable) NSString* resultTitle;

/** The description of this search result as taken from the HTML meta description */
@property (readonly, nullable) NSString* resultDescription;

/** The target URL of this search result, for information purposes only. Use this only for displaying the target URL to the user and always use the visitURL for actually displaying the result. */
@property (readonly, nullable) NSURL* url;

/** The Thumbnail URL of this search result, Use this to display a thumbnail preview of the website if available */
@property (readonly, nullable) NSURL* thumbnailURL;

/** If the search result offers a thumbnail (= a preview of the actual target website), this contains the size of the thumbnail. CGSizeZero if no size information is available */
@property (readonly) CGSize thumbnailSize;

/** Initializer - for internal use only */
- (instancetype _Nonnull) initWithDictionary: (NSDictionary* _Nonnull) dictionary;

@end
