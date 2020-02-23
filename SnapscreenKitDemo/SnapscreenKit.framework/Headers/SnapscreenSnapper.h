//
//  SnapscreenSnapper.h
//  SnapscreenKit
//
//  Created by Martin Reichart on 21.02.20.
//  Copyright © 2020 Snapscreen Application GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@class SnapscreenSearchResult;
@class SnapscreenSnapConfiguration;

/**

 Provides callbacks from the SnapscreenSnapper.

 */
@protocol SnapscreenSnapperDelegate<NSObject>

/**
 Snapping did occur and did find at least one result.

 @param snapResult The result of the snap. Contains at least one result entry.

 */
- (void) snapscreenSnapperDidSnapResult: (SnapscreenSearchResult* _Nonnull) snapResult;

/**
 Snapping did occur but did not yield any results.
 */
- (void) snapscreenSnapperDidSnapNoResult;

/**
 Snapping did fail with an error.

 @param error An error object containing an error with a `SnapscreenErrorCode`. See `SnapscreenErrorCode` for a list of possible error codes.
 */
- (void) snapscreenSnapperDidFailWithError: (NSError* _Nullable) error;

/**
 Snapper did detect a quadrangle. Note that the quadrangle is detected in the orientation (= device orientation) and resolution of the provided sample buffer and may need to be scaled and rotated according to your UI presentation.

 @param topLeft top left point of the quadrangle
 @param topRight top right point of the quadrangle
 @param bottomRight bottom right point of the quadrangle
 @param bottomLeft bottom left point of the quadrangle
 */
- (void) snapscreenSnapperDidDetectQuadrangleWithTopLeft: (CGPoint) topLeft topRight: (CGPoint) topRight bottomRight: (CGPoint) bottomRight bottomLeft: (CGPoint) bottomLeft;

/**
 Snapper did not detect a quadrangle in the provided buffer
 */
- (void) snapscreenSnapperDidLoseQuadrangle;

@end

/**

 SnapscreenSnapper offers a direct API for getting snap and quadrangle results. This offers the ability to build more immersive experiences with custom UIs while still providing snap functionality.

 */
@interface SnapscreenSnapper : NSObject

/**
 The snap configuration to use when performing snaps or quadrangle detection. Needs to be set before subsequent calls.
 */
@property (nonatomic, nullable) SnapscreenSnapConfiguration* snapConfiguration;

/** The delegate of the snapper. Should be nil when you are no longer interested in snap results (e.g. after a successful snap) */
@property (weak, nullable) id<SnapscreenSnapperDelegate> delegate;

/**
 Performs a snap on the provided CVPixelBuffer. If passing a CVPixelBuffer from ARKit, make sure to also pass the timestamp of the ARFrame.

 @param pixelBuffer a CVPixelBuffer, most likely to be used for snapping the content of ARFrame.captureImage
 @param timestamp the timestamp of the provided pixel buffer, most likely to be used by passing ARFrame.timestamp
 */
- (void) performSnapForPixelBuffer: (CVPixelBufferRef _Nonnull ) pixelBuffer timestamp: (NSTimeInterval) timestamp;


/**

 */
- (void) detectQuadrangleForPixelBuffer: (CVPixelBufferRef _Nonnull) pixelBuffer timestamp: (NSTimeInterval) timestamp;

@end

