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

- (IBAction) startNewTvSnap:(id)sender {
    SnapscreenSnapConfiguration* configuration = [SnapscreenSnapConfiguration new];
    configuration.searchForTvResults = YES;
    
    SnapscreenSnapViewController* snapViewController = [[SnapscreenKit sharedSnapscreenKit] instantiateSnapscreenSnapViewControllerWithDelegate: self configuration: configuration];
    [self presentViewController: [[UINavigationController alloc] initWithRootViewController: snapViewController] animated: YES completion: nil];
}

- (IBAction) startNewAdSnap:(id)sender {
    SnapscreenSnapConfiguration* configuration = [SnapscreenSnapConfiguration new];
    configuration.searchForAdvertisements = YES;
    
    SnapscreenSnapViewController* snapViewController = [[SnapscreenKit sharedSnapscreenKit] instantiateSnapscreenSnapViewControllerWithDelegate: self configuration: configuration];
    [self presentViewController: [[UINavigationController alloc] initWithRootViewController: snapViewController] animated: YES completion: nil];
}

- (IBAction)startNewSportEventMatch:(id)sender {
    SnapscreenSnapConfiguration* configuration = [SnapscreenSnapConfiguration new];
    configuration.searchForSportEvents = YES;
    
    SnapscreenSnapViewController* snapViewController = [[SnapscreenKit sharedSnapscreenKit] instantiateSnapscreenSnapViewControllerWithDelegate: self configuration: configuration];
    [self presentViewController: [[UINavigationController alloc] initWithRootViewController: snapViewController] animated: YES completion: nil];
}

- (void) snapscreenSnapViewController: (SnapscreenSnapViewController* _Nonnull) snapViewController didSnapResult: (SnapscreenSearchResult* _Nonnull) snapResult {
    [snapViewController dismissViewControllerAnimated: YES completion: nil];
    NSMutableArray* resultTextArray = [NSMutableArray new];
    [resultTextArray addObject: @"Results found:"];
    if (snapResult.tvSearchResult) {
        for (SnapscreenTvSearchResultEntry* resultEntry in snapResult.tvSearchResult.results) {
            [resultTextArray addObject: [NSString stringWithFormat: @"Channel: %@; Name: %@, Timestamp: %@", resultEntry.channel.channelCode, resultEntry.channel.name, @(resultEntry.timestamp)]];
        }
    } else if (snapResult.advertisementSearchResult) {
        for (SnapscreenAdvertisementSearchResultEntry* resultEntry in snapResult.advertisementSearchResult.results) {
            [resultTextArray addObject: [NSString stringWithFormat: @"Ad Title: %@; Timestamp: %@", resultEntry.advertisement.advertisementTitle, @(resultEntry.timestamp)]];
        }
    } else if (snapResult.sportEventSearchResult) {
        for (SnapscreenSportEventSearchResultEntry* entry in snapResult.sportEventSearchResult.results) {
            NSMutableArray* competitorArray = [NSMutableArray new];
            for (SnapscreenSportEventCompetitor* competitor in entry.event.competitors) {
                [competitorArray addObject: competitor.name];
            }
            [resultTextArray addObject: [NSString stringWithFormat: @"Sport Event: %@ %@: %@", entry.event.sport, entry.event.tournament, [competitorArray componentsJoinedByString: @" "]]];
        }
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
