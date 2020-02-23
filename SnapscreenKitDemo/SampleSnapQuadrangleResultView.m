//
//  SampleSnapQuadrangleResultView.m
//  SnapscreenKitDemo
//
//  Created by Martin on 15.12.17.
//  Copyright © 2017 Snapscreen Application GmbH. All rights reserved.
//

#import "SampleSnapQuadrangleResultView.h"

@interface SampleSnapQuadrangleResultView()
@property (nonatomic, strong) CAShapeLayer* quadrangleLayer;
@end

@implementation SampleSnapQuadrangleResultView

- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame: frame])) {
        self.quadrangleLayer = [CAShapeLayer layer];
        self.quadrangleLayer.lineWidth = 3;
        self.quadrangleLayer.opacity = 1;
        self.quadrangleLayer.fillColor = [UIColor redColor].CGColor;
        self.quadrangleLayer.lineCap = kCALineCapRound;
        self.quadrangleLayer.lineJoin = kCALineJoinRound;
        [self.layer addSublayer: self.quadrangleLayer];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.quadrangleLayer.frame = self.bounds;
}

- (void)setQuadranglePath:(UIBezierPath *)quadranglePath {
    BOOL hadQuadrangle = self.quadranglePath != nil;
    UIBezierPath* oldPath = self.quadranglePath;
    
    _quadranglePath = quadranglePath;
    
    if (self.quadranglePath != nil) {
        self.quadrangleLayer.opacity = 0.25;
        
        if (hadQuadrangle) {
            self.quadrangleLayer.path = self.quadranglePath.CGPath;
            [self.quadrangleLayer removeAllAnimations];
            
            CABasicAnimation* pathAnimation = [CABasicAnimation animationWithKeyPath: @"path"];
            pathAnimation.fromValue = (id) oldPath;
            pathAnimation.toValue = (id) quadranglePath;
            pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            pathAnimation.fillMode = kCAFillModeForwards;
            pathAnimation.removedOnCompletion = false;
            pathAnimation.duration = 0.15;
            [self.quadrangleLayer addAnimation: pathAnimation forKey: pathAnimation.keyPath];
        } else {
            self.quadrangleLayer.path = self.quadranglePath.CGPath;
        }
    } else {
        self.quadrangleLayer.opacity = 0;
    }
}

@end
