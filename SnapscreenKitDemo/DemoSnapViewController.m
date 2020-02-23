//
//  DemoSnapViewController.m
//  SnapscreenKitDemo
//
//  Created by Martin Reichart on 27.09.16.
//  Copyright © 2016 Snapscreen Application GmbH. All rights reserved.
//

#import "DemoSnapViewController.h"
#import <SnapscreenKit/SnapscreenKit.h>
#import "SampleSnapQuadrangleResultView.h"
#import "ARKitDemoViewController.h"

@interface DemoSnapViewController ()<SnapscreenSnapViewControllerDelegate, SnapscreenSnapResultsViewControllerDelegate, SnapscreenARSnapViewControllerDelegate, SnapscreenClipSharingDelegate>
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (nonatomic, strong) SampleSnapQuadrangleResultView* quadrangleView;
@property (nonatomic, strong) UIView* resultPanel;
@property (nonatomic, strong) UILabel* resultLabel;
@property (nonatomic, strong) UILabel* resultLinkLabel;
@property (nonatomic, strong) UIButton* disclosureIndicatorButton;
@property (nonatomic, strong) SnapscreenARSnapViewController* arViewController;
@property (nonatomic, strong) SnapscreenSearchResult* latestARResult;

@end

@implementation DemoSnapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.statusLabel.text = @"Start a new snap";
}

- (NSString*) descriptionForResult: (SnapscreenSearchResult*) snapResult {
    if (snapResult.tvSearchResult) {
        return snapResult.tvSearchResult.results.firstObject.channel.name;
    } else if (snapResult.advertisementSearchResult) {
        return snapResult.advertisementSearchResult.results.firstObject.advertisement.advertisementTitle;
    } else if (snapResult.sportEventSearchResult) {
        NSMutableArray* resultArray = [NSMutableArray new];
        for (SnapscreenSportEventSearchResultEntry* entry in snapResult.sportEventSearchResult.results) {
            if (entry.event) {
                NSMutableArray* competitorArray = [NSMutableArray new];
                for (SnapscreenSportEventCompetitor* competitor in entry.event.competitors) {
                    [competitorArray addObject: competitor.name];
                }
                [resultArray addObject: [NSString stringWithFormat: @"Sport Event: %@ %@: %@", entry.event.sport, entry.event.tournament, [competitorArray componentsJoinedByString: @" "]]];
            } else {
                [resultArray addObject: [NSString stringWithFormat: @"Sport Event Channel Only: %@", entry.channel.name]];
            }
        }
        return [resultArray componentsJoinedByString: @"\n"];
    }
    return @"";
}

- (NSURL*) linkForResult: (SnapscreenSearchResult*) snapResult {
    if (snapResult.advertisementSearchResult) {
        return snapResult.advertisementSearchResult.results.firstObject.advertisement.landingPageURL;
    }
    return nil;
}

- (IBAction) startNewTvSnap:(id)sender {
    SnapscreenSnapConfiguration* configuration = [SnapscreenSnapConfiguration new];
    configuration.searchForTvResults = YES;
    SnapscreenSnapViewController* snapViewController = [[SnapscreenKit sharedSnapscreenKit] instantiateSnapscreenSnapViewControllerWithDelegate: self resultsDelegate: self configuration: configuration];
    [self presentViewController: [[UINavigationController alloc] initWithRootViewController: snapViewController] animated: YES completion: nil];
}

- (IBAction) startNewAdSnap:(id)sender {
    SnapscreenSnapConfiguration* configuration = [SnapscreenSnapConfiguration new];
    configuration.searchForAdvertisements = YES;
    SnapscreenSnapViewController* snapViewController = [[SnapscreenKit sharedSnapscreenKit] instantiateSnapscreenSnapViewControllerWithDelegate: self resultsDelegate: self configuration: configuration];
    [self presentViewController: [[UINavigationController alloc] initWithRootViewController: snapViewController] animated: YES completion: nil];
}

- (IBAction)startNewSportEventSnap:(id)sender {
    SnapscreenSnapConfiguration* configuration = [SnapscreenSnapConfiguration new];
    configuration.searchForSportEvents = YES;
    SnapscreenSnapViewController* snapViewController = [[SnapscreenKit sharedSnapscreenKit] instantiateSnapscreenSnapViewControllerWithDelegate: self resultsDelegate: self configuration: configuration];
    [self presentViewController: [[UINavigationController alloc] initWithRootViewController: snapViewController] animated: YES completion: nil];
}

- (void) snapscreenSnapViewController: (SnapscreenSnapViewController* _Nonnull) snapViewController didSnapResult: (SnapscreenSearchResult* _Nonnull) snapResult {
    [snapViewController dismissViewControllerAnimated: YES completion: nil];
    
    self.statusLabel.text = [self descriptionForResult: snapResult];
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


/* AR Handling */


- (void) showARWithConfiguration: (SnapscreenSnapConfiguration*) configuration {
    self.quadrangleView = [[SampleSnapQuadrangleResultView alloc] initWithFrame: CGRectZero];
    self.quadrangleView.translatesAutoresizingMaskIntoConstraints = NO;
    self.quadrangleView.backgroundColor = [UIColor clearColor];
    
    self.resultPanel = [[UIView alloc] initWithFrame: CGRectZero];
    self.resultPanel.backgroundColor = [UIColor whiteColor];
    self.resultPanel.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.resultPanel.layer.shadowOpacity = 0.3;
    self.resultLabel.layer.shadowOffset = CGSizeMake(0, -1);
    self.resultLabel.layer.shadowRadius = 3;
    self.resultPanel.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.resultLabel = [[UILabel alloc] initWithFrame: CGRectZero];
    self.resultLabel.textAlignment = NSTextAlignmentCenter;
    self.resultLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.resultLabel.textColor = [UIColor blackColor];
    self.resultLabel.font = [UIFont boldSystemFontOfSize: 12];
    self.resultLabel.numberOfLines = 0;
    [self.resultPanel addSubview: self.resultLabel];
    
    if (configuration.searchForAdvertisements) {
        self.resultLinkLabel = [[UILabel alloc] initWithFrame: CGRectZero];
        self.resultLinkLabel.textAlignment = NSTextAlignmentCenter;
        self.resultLinkLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.resultLinkLabel.textColor = [UIColor blackColor];
        self.resultLinkLabel.font = [UIFont systemFontOfSize: 12];
        self.resultLinkLabel.numberOfLines = 1;
        self.resultLinkLabel.userInteractionEnabled = YES;
        [self.resultPanel addSubview: self.resultLinkLabel];
        
        UITapGestureRecognizer* linkTap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(openLink:)];
        [self.resultLinkLabel addGestureRecognizer: linkTap];
    }
    
    self.disclosureIndicatorButton = [UIButton buttonWithType: UIButtonTypeCustom];
    self.disclosureIndicatorButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.disclosureIndicatorButton addTarget: self action: @selector(selectARResult:) forControlEvents: UIControlEventTouchUpInside];
    [self.disclosureIndicatorButton setTitle: @"SELECT" forState: UIControlStateNormal];
    [self.disclosureIndicatorButton setTitleColor: [UIColor colorWithRed: 61.f/255.f green: 118.f/255.f blue: 197.f/255.f alpha: 1.f] forState:UIControlStateNormal];
    self.disclosureIndicatorButton.titleLabel.font = [UIFont boldSystemFontOfSize: 12];
    self.disclosureIndicatorButton.layer.cornerRadius = 4;
    self.disclosureIndicatorButton.layer.borderColor = [[UIColor colorWithRed: 61.f/255.f green: 118.f/255.f blue: 197.f/255.f alpha: 1.f] CGColor];
    self.disclosureIndicatorButton.layer.borderWidth = 1;
    [self.resultPanel addSubview: self.disclosureIndicatorButton];
    
    self.arViewController = [[SnapscreenKit sharedSnapscreenKit] instantiateARSnapscreenSnapViewControllerWithDelegate: self configuration: configuration];
    UINavigationController* navigationVC = [[UINavigationController alloc] initWithRootViewController: self.arViewController];
    [self presentViewController: navigationVC animated: YES completion: nil];
}

- (IBAction) startNewTvARSnap: (id) sender {
    SnapscreenSnapConfiguration* configuration = [SnapscreenSnapConfiguration new];
    configuration.searchForTvResults = YES;
    [self showARWithConfiguration: configuration];
}

- (IBAction) startNewSportEventARSnap: (id) sender {
    SnapscreenSnapConfiguration* configuration = [SnapscreenSnapConfiguration new];
    configuration.searchForSportEvents = YES;
    [self showARWithConfiguration: configuration];
}

- (IBAction) startNewAdARSnap: (id) sender {
    SnapscreenSnapConfiguration* configuration = [SnapscreenSnapConfiguration new];
    configuration.searchForAdvertisements = YES;
    [self showARWithConfiguration: configuration];
}

- (IBAction) startClipSharing: (id) sender {
    // Explicitly remove user defaults value for tutorial to force presentation of tutorial
    [[NSUserDefaults standardUserDefaults] setBool: NO forKey: SnapscreenSDK_ClipSharingTutorialSeenUserDefaultsKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    SnapscreenClipSharingConfiguration* configuration = [SnapscreenClipSharingConfiguration new];
    configuration.largeSponsorImage = [UIImage imageNamed: @"sponsor_sample"];
    configuration.tutorialContent = @[[SnapscreenClipSharingTutorialContent contentWithImage: [UIImage imageNamed: @"tutorial_sample"] text: @"Point and scan your screen"],
                                      [SnapscreenClipSharingTutorialContent contentWithImage: [UIImage imageNamed: @"tutorial_sample"] text: @"Edit your clip"]];
    
    configuration.sharingIntroductionHintImage = [UIImage imageNamed: @"tutorial_sample"];
    configuration.sharingIntroductionHint = [[NSAttributedString alloc] initWithString: @"Edit your clip\nGo back and forth in time,\nadjust your clip length, preview and\ntap Share Clip when you're happy with it" attributes: @{NSForegroundColorAttributeName : configuration.mainButtonColor, NSFontAttributeName : configuration.tutorialFont}];
    
    [self presentViewController: [[SnapscreenClipSharingNavigationController alloc] initWithConfiguration: configuration delegate: self] animated: YES completion: nil];
}

- (IBAction)startARKitSnapping:(id)sender {
    UINavigationController* arKitSnapViewController = [[UINavigationController alloc] initWithRootViewController: [ARKitDemoViewController new]];
    [self presentViewController: arKitSnapViewController animated: YES completion: nil];
}

- (void) snapscreenARViewController: (SnapscreenARSnapViewController* _Nonnull) snapViewController didPrepareDrawingView: (UIView*) drawingView {
    [drawingView addSubview: self.quadrangleView];
    [drawingView addSubview: self.resultPanel];
    
    [drawingView addConstraint: [NSLayoutConstraint constraintWithItem: drawingView attribute: NSLayoutAttributeTop relatedBy: NSLayoutRelationEqual toItem: self.quadrangleView attribute: NSLayoutAttributeTop multiplier: 1 constant: 0]];
    [drawingView addConstraint: [NSLayoutConstraint constraintWithItem: drawingView attribute: NSLayoutAttributeLeading relatedBy: NSLayoutRelationEqual toItem: self.quadrangleView attribute: NSLayoutAttributeLeading multiplier: 1 constant: 0]];
    [drawingView addConstraint: [NSLayoutConstraint constraintWithItem: drawingView attribute: NSLayoutAttributeTrailing relatedBy: NSLayoutRelationEqual toItem: self.quadrangleView attribute: NSLayoutAttributeTrailing multiplier: 1 constant: 0]];
    [drawingView addConstraint: [NSLayoutConstraint constraintWithItem: drawingView attribute: NSLayoutAttributeBottom relatedBy: NSLayoutRelationEqual toItem: self.quadrangleView attribute: NSLayoutAttributeBottom multiplier: 1 constant: 0]];
    
    self.quadrangleView.hidden = YES;
    self.resultPanel.alpha = 0;
}

- (void)snapscreenARViewControllerDidLoseResult:(SnapscreenARSnapViewController *)snapViewController {
    self.latestARResult = nil;
    self.quadrangleView.hidden = YES;
    
    [UIView animateWithDuration: 0.25 animations:^{
        self.resultPanel.frame = CGRectMake(0, snapViewController.arDrawingView.bounds.size.height, snapViewController.arDrawingView.bounds.size.width, self.resultPanel.frame.size.height);
        self.resultPanel.alpha = 0;
    }];
    
}

- (void)snapscreenARViewController:(SnapscreenARSnapViewController *)snapViewController didFindResult:(SnapscreenSearchResult *)result {
    if (result.resultQuadrangle) {
        self.latestARResult = result;
        self.quadrangleView.quadranglePath = result.resultQuadrangle.quadranglePath;
        self.quadrangleView.hidden = NO;
        self.resultPanel.alpha = 1;
        self.resultLabel.text = [self descriptionForResult: result];
        CGFloat bottomInset = 0;
        if ([snapViewController.arDrawingView respondsToSelector: NSSelectorFromString(@"safeAreaInsets")]) {
            UIEdgeInsets insets = [[snapViewController.arDrawingView valueForKey: @"safeAreaInsets"] UIEdgeInsetsValue];
            bottomInset = insets.bottom;
        }
        
        if (self.resultLinkLabel) {
            self.resultLinkLabel.attributedText = [[NSAttributedString alloc] initWithString: [[self linkForResult: result] absoluteString] attributes: @{NSFontAttributeName : [UIFont systemFontOfSize: 12], NSForegroundColorAttributeName : [UIColor colorWithRed: 61.f/255.f green: 118.f/255.f blue: 197.f/255.f alpha: 1.f], NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)}];
            
            CGRect buttonRect = [[self.disclosureIndicatorButton titleForState: UIControlStateNormal] boundingRectWithSize: CGSizeMake(snapViewController.arDrawingView.bounds.size.width - 32 - 44, CGFLOAT_MAX) options: NSStringDrawingUsesLineFragmentOrigin attributes: @{NSFontAttributeName : self.disclosureIndicatorButton.titleLabel.font} context: nil];
            CGSize buttonSize = CGSizeMake(ceilf(buttonRect.size.width) + 16, ceilf(buttonRect.size.height));
            
            CGRect boundRect = [self.resultLabel.text boundingRectWithSize: CGSizeMake(snapViewController.arDrawingView.bounds.size.width - 32 - buttonSize.width - 8, CGFLOAT_MAX) options: NSStringDrawingUsesLineFragmentOrigin attributes: @{NSFontAttributeName : self.resultLabel.font} context: nil];
            CGSize size = CGSizeMake(ceilf(boundRect.size.width), ceilf(boundRect.size.height));
            
            CGRect linkBoundingRect = [self.resultLinkLabel.text boundingRectWithSize: CGSizeMake(snapViewController.arDrawingView.bounds.size.width - 32 - buttonSize.width - 8, CGFLOAT_MAX) options: NSStringDrawingUsesLineFragmentOrigin attributes: @{NSFontAttributeName : self.resultLinkLabel.font} context: nil];
            CGSize linkSize = CGSizeMake(ceilf(linkBoundingRect.size.width), ceilf(linkBoundingRect.size.height));
            
            if (CGSizeEqualToSize(self.resultPanel.frame.size, CGSizeZero)) {
                self.resultPanel.frame = CGRectMake(0, snapViewController.arDrawingView.bounds.size.height, snapViewController.arDrawingView.bounds.size.width, size.height + linkSize.height + 32 + bottomInset);
                self.disclosureIndicatorButton.frame = CGRectMake(snapViewController.arDrawingView.bounds.size.width - buttonSize.width - 16, floorf((self.resultPanel.bounds.size.height - bottomInset) / 2 - 16), buttonSize.width, 32);
                self.resultLabel.frame = CGRectMake(16, 16, self.resultPanel.frame.size.width - 32 - buttonSize.width - 8, size.height);
                self.resultLinkLabel.frame = CGRectMake(16, 16 + size.height, self.resultPanel.frame.size.width - 32 - buttonSize.width - 8, linkSize.height);
                [self.resultPanel setNeedsLayout];
                [self.resultPanel layoutIfNeeded];
            }
            [UIView animateWithDuration: 0.25 animations:^{
                self.resultPanel.frame = CGRectMake(0, snapViewController.arDrawingView.bounds.size.height - size.height - linkSize.height - 32 - bottomInset, snapViewController.arDrawingView.bounds.size.width, size.height + linkSize.height + 32 + bottomInset);
                self.disclosureIndicatorButton.frame = CGRectMake(snapViewController.arDrawingView.bounds.size.width - buttonSize.width - 16, floorf((self.resultPanel.bounds.size.height - bottomInset) / 2 - 16), buttonSize.width, 32);
                self.resultLabel.frame = CGRectMake(16, 16, self.resultPanel.frame.size.width - 32 - buttonSize.width - 8, size.height);
                self.resultLinkLabel.frame = CGRectMake(16, 16 + size.height, self.resultPanel.frame.size.width - 32 - buttonSize.width - 8, linkSize.height);
                self.resultPanel.alpha = 1;
            }];
        } else {
            CGRect buttonRect = [[self.disclosureIndicatorButton titleForState: UIControlStateNormal] boundingRectWithSize: CGSizeMake(snapViewController.arDrawingView.bounds.size.width - 32 - 44, CGFLOAT_MAX) options: NSStringDrawingUsesLineFragmentOrigin attributes: @{NSFontAttributeName : self.disclosureIndicatorButton.titleLabel.font} context: nil];
            CGSize buttonSize = CGSizeMake(ceilf(buttonRect.size.width) + 16, ceilf(buttonRect.size.height));
            
            CGRect boundRect = [self.resultLabel.text boundingRectWithSize: CGSizeMake(snapViewController.arDrawingView.bounds.size.width - 32 - buttonSize.width - 8, CGFLOAT_MAX) options: NSStringDrawingUsesLineFragmentOrigin attributes: @{NSFontAttributeName : self.resultLabel.font} context: nil];
            CGSize size = CGSizeMake(ceilf(boundRect.size.width), ceilf(boundRect.size.height));
            if (CGSizeEqualToSize(self.resultPanel.frame.size, CGSizeZero)) {
                self.resultPanel.frame = CGRectMake(0, snapViewController.arDrawingView.bounds.size.height, snapViewController.arDrawingView.bounds.size.width, size.height + 32 + bottomInset);
                self.disclosureIndicatorButton.frame = CGRectMake(snapViewController.arDrawingView.bounds.size.width - buttonSize.width - 16, floorf((self.resultPanel.bounds.size.height - bottomInset) / 2 - 16), buttonSize.width, 32);
                self.resultLabel.frame = CGRectMake(16, 16, self.resultPanel.frame.size.width - 32 - buttonSize.width - 8, size.height);
                [self.resultPanel setNeedsLayout];
                [self.resultPanel layoutIfNeeded];
            }
            [UIView animateWithDuration: 0.25 animations:^{
                self.resultPanel.frame = CGRectMake(0, snapViewController.arDrawingView.bounds.size.height - size.height - 32 - bottomInset, snapViewController.arDrawingView.bounds.size.width, size.height + 32 + bottomInset);
                self.disclosureIndicatorButton.frame = CGRectMake(snapViewController.arDrawingView.bounds.size.width - buttonSize.width - 16, floorf((self.resultPanel.bounds.size.height - bottomInset) / 2 - 16), buttonSize.width, 32);
                self.resultLabel.frame = CGRectMake(16, 16, self.resultPanel.frame.size.width - 32 - buttonSize.width - 8, size.height);
                self.resultPanel.alpha = 1;
            }];
        }
    } else {
        self.latestARResult = nil;
        self.quadrangleView.hidden = YES;
        [UIView animateWithDuration: 0.25 animations:^{
            self.resultPanel.frame = CGRectMake(0, snapViewController.arDrawingView.bounds.size.height, snapViewController.arDrawingView.bounds.size.width, self.resultPanel.frame.size.height);
            self.resultPanel.alpha = 0;
        }];
    }
}

// ad -> show url and on tap -> open browser

- (void) selectARResult: (id) sender {
    SnapscreenSearchResult* result = self.latestARResult;
    self.arViewController.arDelegate = nil;
    [self dismissViewControllerAnimated: YES completion: nil];
    self.quadrangleView = nil;
    self.resultLabel = nil;
    self.resultPanel = nil;
    self.resultLinkLabel = nil;
    self.arViewController = nil;
    
    self.statusLabel.text = [self descriptionForResult: result];
}

- (void) openLink: (id) sender {
    NSURL* url = [self linkForResult: self.latestARResult];
    if (url) {
        self.arViewController.arDelegate = nil;
        [self dismissViewControllerAnimated: YES completion: nil];
        self.quadrangleView = nil;
        self.resultLabel = nil;
        self.resultPanel = nil;
        self.resultLinkLabel = nil;
        self.arViewController = nil;
        
        [[UIApplication sharedApplication] openURL: url options: nil completionHandler: nil];
    }
}

- (void) snapscreenARSnapViewControllerDidCancel: (SnapscreenARSnapViewController* _Nonnull) snapViewController {
    snapViewController.arDelegate = nil;
    [self dismissViewControllerAnimated: YES completion: nil];
    self.quadrangleView = nil;
    self.resultLabel = nil;
    self.resultPanel = nil;
    self.resultLinkLabel = nil;
    self.arViewController = nil;
}

- (void)clipSharingViewControllerDidCancel:(SnapscreenClipSharingViewController *)sharingViewController {
    [sharingViewController dismissViewControllerAnimated: YES completion: nil];
}

- (void)clipSharingViewController:(SnapscreenClipSharingViewController *)sharingViewController didShareVideoSnippet:(SnapscreenClipShareInformation *)shareInformation {
    __weak DemoSnapViewController* me = self;
    [sharingViewController dismissViewControllerAnimated: YES completion:^{
        UIActivityViewController* activityViewController = [[UIActivityViewController alloc] initWithActivityItems: @[shareInformation.videoPlayerURL] applicationActivities: nil];
        [me presentViewController: activityViewController animated: YES completion: nil];
    }];
}

@end
