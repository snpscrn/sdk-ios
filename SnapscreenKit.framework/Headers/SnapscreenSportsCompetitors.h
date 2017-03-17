//
//  SnapscreenSportsCompetitors.h
//  SnapscreenKit
//
//  Created by Martin Reichart on 28/02/2017.
//  Copyright © 2017 Snapscreen Application GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SnapscreenSportsPlayer;

/**
 
 Represents the competitors in a match
 
 */
@interface SnapscreenSportsCompetitors : NSObject

/** The players in this match */
@property (nonatomic, readonly, nonnull) NSArray<SnapscreenSportsPlayer*>* players;

/** A list of names representing this match and it's players */
@property (nonatomic, readonly, nonnull) NSArray<NSString*>* texts;

@end
