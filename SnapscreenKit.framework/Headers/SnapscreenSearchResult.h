//
//  SnapscreenSearchResult.h
//  SnapscreenKit
//
//  Created by Martin Reichart on 20/08/16.
//  Copyright © 2016 Snapscreen Application GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SnapscreenTvSearchResult;
@class SnapscreenAdvertisementSearchResult;

/**
 
 Represent the result from a search.
 
 */
@interface SnapscreenSearchResult : NSObject

/** An optional TV search result if the SnapscreenSnapConfiguration specified to search for TV results and a result was found */
@property (nullable, nonatomic, readonly) SnapscreenTvSearchResult* tvSearchResult;

/** An optional advertisements search result if the SnapscreenSnapConfiguration specified to search for advertisements and a result was found */
@property (nullable, nonatomic, readonly) SnapscreenAdvertisementSearchResult* advertisementSearchResult;

@end
