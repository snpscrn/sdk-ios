//
//  SnapscreenSportsMatch.h
//  SnapscreenKit
//
//  Created by Martin Reichart on 28/02/2017.
//  Copyright © 2017 Snapscreen Application GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SnapscreenSportsCompetitors;

/**
 
 Represents a match
 
 */
@interface SnapscreenSportsMatch : NSObject

/** The queued date of the match */
@property (readonly, nonnull) NSDate* matchDate;

/** Information about the competitors in this match */
@property (readonly, nonnull) SnapscreenSportsCompetitors* competitors;

@end
