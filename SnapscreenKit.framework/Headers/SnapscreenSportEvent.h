//
//  SnapscreenSportEvent.h
//  SnapscreenKit
//
//  Created by Martin Reichart on 28/02/2017.
//  Copyright © 2017 Snapscreen Application GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SnapscreenSportEventCompetitor;

/**
 
 Represents a match
 
 */
@interface SnapscreenSportEvent : NSObject

/** Internal identifier for this event */
@property (readonly, nonatomic) long long eventId;

/** External identifier for this event */
@property (readonly, nullable) NSString* externalId;

/** The queued start date of the event */
@property (readonly, nonnull) NSDate* startTime;

/** The queued end date of the event */
@property (readonly, nonnull) NSDate* endTime;

/** An internal channel identifier */
@property (readonly, nonatomic) long long tvChannelId;

/** The category of the event */
@property (readonly, nullable) NSString* category;

/** The name of the sport */
@property (readonly, nullable) NSString* sport;

/** The name of the tournament */
@property (readonly, nullable) NSString* tournament;

/** Information about the competitors in this event */
@property (readonly, nonnull) NSArray<SnapscreenSportEventCompetitor*>* competitors;

@end