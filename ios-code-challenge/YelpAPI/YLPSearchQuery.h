//
//  YLPSearchQuery.h
//  ios-code-challenge
//
//  Created by Dustin Lange on 1/21/18.
//  Copyright © 2018 Dustin Lange. All rights reserved.
//

@import Foundation;
@import CoreLocation;

NS_ASSUME_NONNULL_BEGIN

@interface YLPSearchQuery : NSObject

- (instancetype)initWithLocation:(NSString *)location;

- (instancetype)initWithCord:(CLLocation *)location;

- (instancetype)initWithOffset:(CLLocation *)location offset:(UInt32)offset;


- (NSDictionary *)parameters;

/**
 *  Optional. Search term (e.g. "food", "restaurants"). If term isn’t included we
 *  search everything. The term keyword also accepts business names such as "Starbucks".
 */
@property (nonatomic, copy, nullable) NSString *term;

/**
 *  Optional. Categories to filter the search results with.
 *  The category filter can be a list of comma delimited categories. For example,
 *  "bars,french" will filter by Bars OR French. The category identifier should be
 *  used (for example "discgolf", not "Disc Golf").
 */
@property (nonatomic, copy, null_resettable) NSArray<NSString *> *categoryFilter;

/**
 *  Optional. Search radius in meters. If the value is too large, a AREA_TOO_LARGE
 *  error may be returned. The max value is 40000 meters (25 miles).
 */
@property (nonatomic, assign) double radiusFilter;

@end

NS_ASSUME_NONNULL_END
