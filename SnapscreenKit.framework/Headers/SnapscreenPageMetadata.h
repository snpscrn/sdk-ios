//
//  SnapscreenPageMetadata.h
//  SnapscreenKit
//
//  Created by Martin Reichart on 19/10/2016.
//  Copyright © 2016 Snapscreen Application GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 
 Metadata for a paged server response.
 
 */
@interface SnapscreenPageMetadata : NSObject

/** The total number of elements available */
@property (readonly, nonatomic) NSInteger totalElements;

/** The total number of pages available */
@property (readonly, nonatomic) NSInteger totalPages;

/** The current page index */
@property (readonly, nonatomic) NSInteger currentPage;

/** The page size */
@property (readonly, nonatomic) NSInteger pageSize;

@end
