//
//  SnapscreenAdvertisementSearchResultEntry.h
//  SnapscreenKit
//
//  Created by Martin Reichart on 08/02/2017.
//  Copyright © 2017 Snapscreen Application GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SnapscreenSearchResultEntry.h"

@class SnapscreenAdvertisement;

/** 
 
 A single result entry from an advertisement search. This represent an individual advertisement at a certain point in time
 
 */
@interface SnapscreenAdvertisementSearchResultEntry : SnapscreenSearchResultEntry

/** The advertisement this result is associated to */
@property (readonly, nonatomic, nonnull) SnapscreenAdvertisement* advertisement;

/** The unix timestamp (milliseconds since 1.1.1970) that represents the recognized frame */
@property (readonly, nonatomic) long long timestamp;

/** A relative delta to the current snapscreen timestamp - use this for very exact syncing with the backend by adding to [SnapscreenKit currentSnapscreenTimestamp] */
@property (readonly, nonatomic) long long snapscreenTimestampDelta;

@end
