//
//  SnapscreenSportsMatchSearchResultEntry.h
//  SnapscreenKit
//
//  Created by Martin Reichart on 28/02/2017.
//  Copyright © 2017 Snapscreen Application GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SnapscreenSearchResultEntry.h"

@class SnapscreenSportsMatch, SnapscreenTvChannel;

/**
 
 A single result entry from a sports match search. This represents an individual match at a certain point in time.
 
 */
@interface SnapscreenSportsMatchSearchResultEntry : SnapscreenSearchResultEntry

/** The match this result is associated to - only set if match is found */
@property (readonly, nonatomic, nullable) SnapscreenSportsMatch* match;

/** The channel this result is associated to - only set if no match was found as fallback */
@property (readonly, nonatomic, nullable) SnapscreenTvChannel* channel;

/** The unix timestamp (milliseconds since 1.1.1970) that represents the recognized frame */
@property (readonly, nonatomic) long long timestamp;

/** A relative delta to the current snapscreen timestamp - use this for very exact syncing with the backend by adding to [SnapscreenKit currentSnapscreenTimestamp] */
@property (readonly, nonatomic) long long snapscreenTimestampDelta;

@end
