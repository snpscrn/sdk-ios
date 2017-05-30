//
//  SnapscreenWebSearchService.h
//  SnapscreenKit
//
//  Created by Martin Reichart on 20/08/16.
//  Copyright © 2016 Snapscreen Application GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SnapscreenWebSearchResponse.h"

@class SnapscreenWebSearchSiteResult, SnapscreenWebSearchImageResult, SnapscreenWebSearchVideoResult;

/**
  
 Service class for fetching web resources for a program.
 
 The SnapscreenWebSearchService provides methods to fetch web resources for a specific program with custom search queries. You can retrieve an instance via SnapscreenKit which automatically configured the service.
 */
@interface SnapscreenWebSearchService : NSObject

/**
 
 Fetch websites matching a search query for a specific channel.
 
 @param tvChannelCode The channel code of the TV channel you want to search for (this needs to be the Snapscreen-specific channel code that can be retrieved as channelCode from `SnapscreenTvChannel`)
 @param query Any custom search query
 @param timestampRef Unit timestamp (milliseconds since 1.1.1970) used to identify the program playing on the given channel. Either use the timestamp of a `SnapscreenTvSearchResultEntry` or ```[SnapscreenKit sharedSnapscreenKit].currentSnapscreenTimestamp``` for the current time
 @param page The page for which to fetch results for
 @param size Page size you want to retrieve (always use the same size if you implemented multiple page fetching)
 @param completionBlock The completion block when the operation finishes or fails. Always called on the main thread.
 
 */
- (void) searchSitesForSnapscreenTvChannelCode: (NSString* _Nonnull) tvChannelCode query: (NSString* _Nonnull) query timestamp: (long long) timestampRef page: (NSInteger) page size: (NSInteger) size completion: (void (^_Nonnull)(SnapscreenWebSearchResponse<NSArray<SnapscreenWebSearchSiteResult*>*>* _Nullable response)) completionBlock;

/**
 
 Fetch images matching a search query for a specific channel.
 
 @param tvChannelCode The channel code of the TV channel you want to search for (this needs to be the Snapscreen-specific channel code that can be retrieved as channelCode from `SnapscreenTvChannel`)
 @param query Any custom search query
 @param timestampRef Unit timestamp (milliseconds since 1.1.1970) used to identify the program playing on the given channel. Either use the timestamp of a `SnapscreenTvSearchResultEntry` or ```[SnapscreenKit sharedSnapscreenKit].currentSnapscreenTimestamp``` for the current time
 @param page The page for which to fetch results for
 @param size Page size you want to retrieve (always use the same size if you implemented multiple page fetching)
 @param completionBlock The completion block when the operation finishes or fails. Always called on the main thread.
 
 */
- (void) searchImagesForSnapscreenTvChannelCode: (NSString* _Nonnull) tvChannelCode query: (NSString* _Nonnull) query timestamp: (long long) timestampRef page: (NSInteger) page size: (NSInteger) size completion: (void (^_Nonnull)(SnapscreenWebSearchResponse<NSArray<SnapscreenWebSearchImageResult*>*>* _Nullable response)) completionBlock;

/**
 
 Fetch video matching a search query for a specific channel.
 
 @param tvChannelCode The channel code of the TV channel you want to search for (this needs to be the Snapscreen-specific channel code that can be retrieved as channelCode from `SnapscreenTvChannel`)
 @param query Any custom search query
 @param timestampRef Unit timestamp (milliseconds since 1.1.1970) used to identify the program playing on the given channel. Either use the timestamp of a `SnapscreenTvSearchResultEntry` or ```[SnapscreenKit sharedSnapscreenKit].currentSnapscreenTimestamp``` for the current time
 @param page The page for which to fetch results for
 @param size Page size you want to retrieve (always use the same size if you implemented multiple page fetching)
 @param completionBlock The completion block when the operation finishes or fails. Always called on the main thread.
 
 */
- (void) searchVideosForSnapscreenTvChannelCode: (NSString* _Nonnull) tvChannelCode query: (NSString* _Nonnull) query timestamp: (long long) timestampRef page: (NSInteger) page size: (NSInteger) size completion: (void (^_Nonnull)(SnapscreenWebSearchResponse<NSArray<SnapscreenWebSearchVideoResult*>*>* _Nullable response)) completionBlock;

@end
