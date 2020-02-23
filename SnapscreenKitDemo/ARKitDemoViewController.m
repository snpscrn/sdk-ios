//
//  ARKitDemoViewController.m
//  SnapscreenKitDemo
//
//  Created by Martin Reichart on 23.02.20.
//  Copyright © 2020 Snapscreen Application GmbH. All rights reserved.
//

#import "ARKitDemoViewController.h"
#import <ARKit/ARKit.h>
#import <SnapscreenKit/SnapscreenKit.h>

@interface ARKitDemoViewController ()<SnapscreenSnapperDelegate, ARSessionDelegate>
@property (nonatomic, strong) ARSCNView* sceneView;
@property (nonatomic, strong) UIButton* snapButton;

@property (nonatomic, assign) BOOL snapNextFrame;
@end

@implementation ARKitDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemCancel target: self action: @selector(cancel)];

    self.view.backgroundColor = [UIColor blackColor];

    self.sceneView = [ARSCNView new];
    self.sceneView.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview: self.sceneView];

    self.snapButton = [UIButton buttonWithType: UIButtonTypeCustom];
    [self.snapButton setTitle: @"Snap" forState: UIControlStateNormal];
    [self.snapButton setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
    self.snapButton.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent: 0.75];
    self.snapButton.layer.cornerRadius = 5;
    self.snapButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview: self.snapButton];

    [NSLayoutConstraint activateConstraints: @[
        [self.sceneView.leftAnchor constraintEqualToAnchor: self.view.leftAnchor],
        [self.sceneView.rightAnchor constraintEqualToAnchor: self.view.rightAnchor],
        [self.sceneView.topAnchor constraintEqualToAnchor: self.view.topAnchor],
        [self.sceneView.bottomAnchor constraintEqualToAnchor: self.view.bottomAnchor],

        [self.snapButton.centerXAnchor constraintEqualToAnchor: self.view.centerXAnchor],
        [self.snapButton.heightAnchor constraintEqualToConstant: 50],
        [self.snapButton.widthAnchor constraintEqualToConstant: 150],
        [self.snapButton.bottomAnchor constraintEqualToAnchor: self.view.safeAreaLayoutGuide.bottomAnchor constant: -50]
    ]];

    [self.snapButton addTarget: self action: @selector(snap:) forControlEvents: UIControlEventTouchUpInside];

    [SnapscreenKit sharedSnapscreenKit].snapper.delegate = self;
    SnapscreenSnapConfiguration* configuration = [SnapscreenSnapConfiguration new];
    configuration.searchForTvResults = YES;
    [SnapscreenKit sharedSnapscreenKit].snapper.snapConfiguration = configuration;

    self.sceneView.session.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];

    ARWorldTrackingConfiguration* configuration = [ARWorldTrackingConfiguration new];
    [configuration setLightEstimationEnabled: YES];
    [self.sceneView.session runWithConfiguration: configuration];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];

    [self.sceneView.session pause];
}

- (void) cancel {
    [self dismissViewControllerAnimated: YES completion: nil];
}

- (void) snap: (id) sender {
    self.snapNextFrame = YES;
}

- (void)session:(ARSession *)session didUpdateFrame:(ARFrame *)frame {
    if (self.snapNextFrame) {
        self.snapNextFrame = NO;
        [[SnapscreenKit sharedSnapscreenKit].snapper performSnapForPixelBuffer: frame.capturedImage timestamp: frame.timestamp];
    } else {
        [[SnapscreenKit sharedSnapscreenKit].snapper detectQuadrangleForPixelBuffer: frame.capturedImage timestamp: frame.timestamp];
    }
}

- (void)snapscreenSnapperDidDetectQuadrangleWithTopLeft:(CGPoint)topLeft topRight:(CGPoint)topRight bottomRight:(CGPoint)bottomRight bottomLeft:(CGPoint)bottomLeft {

}

- (void)snapscreenSnapperDidFailWithError:(NSError * _Nullable)error {

}

- (void)snapscreenSnapperDidLoseQuadrangle {

}

- (void)snapscreenSnapperDidSnapNoResult {

}

- (void)snapscreenSnapperDidSnapResult:(SnapscreenSearchResult * _Nonnull)snapResult {

}

@end
