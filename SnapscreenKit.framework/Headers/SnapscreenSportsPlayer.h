//
//  SnapscreenSportsPlayer.h
//  SnapscreenKit
//
//  Created by Martin Reichart on 28/02/2017.
//  Copyright © 2017 Snapscreen Application GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 
 Represents a player in a match
 
 */
@interface SnapscreenSportsPlayer : NSObject

/** The name of the player */
@property (nonatomic, readonly, nonnull) NSString* name;

@end
