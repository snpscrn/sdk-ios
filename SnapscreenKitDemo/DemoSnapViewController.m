//
//  DemoSnapViewController.m
//  SnapscreenKitDemo
//
//  Created by Martin Reichart on 27.09.16.
//  Copyright © 2016 Snapscreen Application GmbH. All rights reserved.
//

#import "DemoSnapViewController.h"
#import <SnapscreenKit/SnapscreenKit.h>

@interface DemoSnapViewController ()<SnapscreenSnapViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@end

@implementation DemoSnapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.statusLabel.text = @"Start a new snap";
}

- (IBAction) startNewSnap:(id)sender {
    SnapscreenSnapViewController* snapViewController = [[SnapscreenKit sharedSnapscreenKit] instantiateSnapscreenSnapViewControllerWithDelegate: self];
    [self presentViewController: [[UINavigationController alloc] initWithRootViewController: snapViewController] animated: YES completion: nil];
}

- (void) snapscreenSnapViewController: (SnapscreenSnapViewController* _Nonnull) snapViewController didSnapResult: (SnapscreenTvSearchResult* _Nonnull) snapResult {
    [snapViewController dismissViewControllerAnimated: YES completion: nil];
    NSMutableArray* resultTextArray = [NSMutableArray new];
    [resultTextArray addObject: @"Results found:"];
    for (SnapscreenTvSearchResultEntry* resultEntry in snapResult.resultEntries) {
        [resultTextArray addObject: [NSString stringWithFormat: @"Channel: %@; Name: %@, Timestamp: %@", resultEntry.channel.channelCode, resultEntry.channel.name, @(resultEntry.timestamp)]];
    }
    self.statusLabel.text = [resultTextArray componentsJoinedByString: @"\n"];
}

- (void) snapscreenSnapViewControllerDidSnapNoResults: (SnapscreenSnapViewController* _Nonnull) snapViewController {
    [snapViewController dismissViewControllerAnimated: YES completion: nil];
    self.statusLabel.text = @"No results found";
}

- (void) snapscreenSnapViewController: (SnapscreenSnapViewController* _Nonnull) snapViewController didFailWithError: (NSError* _Nullable) error {
    [snapViewController dismissViewControllerAnimated: YES completion: nil];
    self.statusLabel.text = @"Snapping did fail";
}

- (void) snapscreenSnapViewControllerDidCancel: (SnapscreenSnapViewController* _Nonnull) snapViewController {
    [snapViewController dismissViewControllerAnimated: YES completion: nil];
    self.statusLabel.text = @"Snapping cancelled";
}

@end
