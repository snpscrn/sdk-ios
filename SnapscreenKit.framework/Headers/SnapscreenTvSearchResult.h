//
//  SnapscreenTvSearchResult.h
//  SnapscreenKit
//
//  Created by Martin Reichart on 20/08/16.
//  Copyright © 2016 Snapscreen Application GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SnapscreenTvSearchResultEntry;

/**
 
 Represent the result from a tv search.
 
 */
@interface SnapscreenTvSearchResult : NSObject

/** The individual entries for this search result. In most cases 1 result, but may contain multiple results that are ordered descending by their score, so that the first entry is the most likely match. */
@property (nonnull, nonatomic, readonly) NSArray<SnapscreenTvSearchResultEntry*>* resultEntries;

@end
