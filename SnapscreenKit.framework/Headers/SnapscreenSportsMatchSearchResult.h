//
//  SnapscreenSportsMatchSearchResult.h
//  SnapscreenKit
//
//  Created by Martin Reichart on 28/02/2017.
//  Copyright © 2017 Snapscreen Application GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SnapscreenSportsMatchSearchResultEntry;

/**
 
 Represents the result from a sports match search.
 
 */
@interface SnapscreenSportsMatchSearchResult : NSObject

/** The individual entries for this search result. In most cases 1 result, but may contain multiple results that are ordered descending by their score, so that the first entry is the most likely match */
@property (nonnull, nonatomic, readonly) NSArray<SnapscreenSportsMatchSearchResultEntry*>* results;

@end
