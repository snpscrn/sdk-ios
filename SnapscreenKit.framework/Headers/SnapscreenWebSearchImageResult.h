//
//  SnapscreenWebSearchImageResult.h
//  SnapscreenKit
//
//  Created by Martin Reichart on 26/09/16.
//  Copyright © 2016 Snapscreen Application GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SnapscreenWebSearchResult.h"

/**
 
 A single resource representing an image.
 
 */
@interface SnapscreenWebSearchImageResult : SnapscreenWebSearchResult

/** The title of this search result, e.g. the title of a web page containing the image as taken from the actual HTML page */
@property (readonly, nullable) NSString* resultTitle;

/** The description of this search result as taken from the HTML meta description of the web page containing the image */
@property (readonly, nullable) NSString* resultDescription;

/** The target URL of this search result, for information purposes only. This is usually the actual URL of the image. Use this only for displaying the target URL to the user and always use the visitURL for actually displaying the result. */
@property (readonly, nullable) NSURL* url;

/** The source URL of this search result, for information purposes only. This is usually the URL of the web page containing the image. Use this only for displaying the source URL of this resource and always use the visitURL for actually display the result.
 
 */
@property (readonly, nullable) NSURL* sourceURL;

/** The actual, full size of the image if available. CGSizeZero if no size information is available */
@property (readonly) CGSize size;

/** The Thumbnail URL of this search result, Use this to display a thumbnail preview of the search result if applicable */
@property (readonly, nullable) NSURL* thumbnailURL;

/** The size of the thumbnail preview image for this resource. CGSizeZero if no thumbnail information is available */
@property (readonly) CGSize thumbnailSize;

/** Initializer - for internal use only */
- (instancetype _Nonnull) initWithDictionary: (NSDictionary* _Nonnull) dictionary;

@end
