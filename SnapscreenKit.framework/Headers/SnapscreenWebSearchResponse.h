//
//  SnapscreenWebSearchResponse.h
//  SnapscreenKit
//
//  Created by Martin Reichart on 19/10/2016.
//  Copyright © 2016 Snapscreen Application GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SnapscreenPageMetadata;

/**
 
 Response object for a web search
 
 */
@interface SnapscreenWebSearchResponse<__covariant ObjectType> : NSObject

/** The result if the web search was successful and returned results. nil if an error occured */
@property (nonatomic, strong, readonly, nullable) ObjectType result;

/** Metadata about the response and underlying data. nil if an error occured */
@property (nonatomic, strong, readonly, nullable) SnapscreenPageMetadata* metadata;

/** An optional error if the web search failed */
@property (nonatomic, strong, readonly, nullable) NSError* error;

@end
