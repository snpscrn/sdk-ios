//
//  DemoWebsearchViewController.m
//  SnapscreenKitDemo
//
//  Created by Martin Reichart on 27.09.16.
//  Copyright © 2016 Snapscreen Application GmbH. All rights reserved.
//

#import "DemoWebsearchViewController.h"
#import <SnapscreenKit/SnapscreenKit.h>

@interface DemoWebsearchViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *searchTypeSegmentedControl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<SnapscreenWebSearchResult*>* results;
@end

@implementation DemoWebsearchViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.results = [NSMutableArray new];
    [self changedSearchType: nil];
}

- (IBAction)changedSearchType:(id) sender {
    switch (self.searchTypeSegmentedControl.selectedSegmentIndex) {
        case 0: {
            [self.results removeAllObjects];
            [self.tableView reloadData];
            __weak DemoWebsearchViewController* me = self;
            [[SnapscreenKit sharedSnapscreenKit].webSearchService searchSitesForSnapscreenTvChannelCode: @"at-orf1" query: @"Big Bang Theory" timestamp: [SnapscreenKit sharedSnapscreenKit].currentSnapscreenTimestamp page: 0 size: 20 completion:^(SnapscreenWebSearchResponse<NSArray<SnapscreenWebSearchSiteResult *> *> * _Nullable response) {
                if (response.error == nil) {
                    [me.results addObjectsFromArray: response.result];
                    [me.tableView reloadData];
                }
            }];
        } break;
        case 1: {
            [self.results removeAllObjects];
            [self.tableView reloadData];
            __weak DemoWebsearchViewController* me = self;
            [[SnapscreenKit sharedSnapscreenKit].webSearchService searchImagesForSnapscreenTvChannelCode: @"at-orf1" query:@"Big Bang Theory" timestamp: [SnapscreenKit sharedSnapscreenKit].currentSnapscreenTimestamp page: 0 size: 20 completion:^(SnapscreenWebSearchResponse<NSArray<SnapscreenWebSearchImageResult *> *> * _Nullable response) {
                if (response.error == nil) {
                    [me.results addObjectsFromArray: response.result];
                    [me.tableView reloadData];
                }
            }];
        } break;
        case 2: {
            [self.results removeAllObjects];
            [self.tableView reloadData];
            __weak DemoWebsearchViewController* me = self;
            [[SnapscreenKit sharedSnapscreenKit].webSearchService searchVideosForSnapscreenTvChannelCode: @"at-orf1" query:@"Big Bang Theory" timestamp: [SnapscreenKit sharedSnapscreenKit].currentSnapscreenTimestamp page: 0 size: 20 completion:^(SnapscreenWebSearchResponse<NSArray<SnapscreenWebSearchVideoResult *> *> * _Nullable response) {
                if (response.error == nil) {
                    [me.results addObjectsFromArray: response.result];
                    [me.tableView reloadData];
                }
            }];
        } break;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SnapscreenWebSearchResult* resource = self.results[indexPath.row];
    
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier: @"ResultCell"];
    
    if ([resource isKindOfClass: [SnapscreenWebSearchSiteResult class]]) {
        SnapscreenWebSearchSiteResult* websiteResource = (SnapscreenWebSearchSiteResult*) resource;
        
        cell.textLabel.text = websiteResource.resultTitle;
        cell.detailTextLabel.text = websiteResource.url.absoluteString;
    } else if ([resource isKindOfClass: [SnapscreenWebSearchVideoResult class]]) {
        SnapscreenWebSearchVideoResult* videoResource = (SnapscreenWebSearchVideoResult*) resource;
        
        cell.textLabel.text = videoResource.resultTitle;
        cell.detailTextLabel.text = videoResource.url.absoluteString;
    } else if ([resource isKindOfClass: [SnapscreenWebSearchImageResult class]]) {
        SnapscreenWebSearchImageResult* imageResource = (SnapscreenWebSearchImageResult*) resource;
        
        cell.textLabel.text = imageResource.resultTitle;
        cell.detailTextLabel.text = imageResource.url.absoluteString;
    }
    
    return cell;
}

@end
