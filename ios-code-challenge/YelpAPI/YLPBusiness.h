//
//  YLPBusiness.h
//  ios-code-challenge
//
//  Created by Dustin Lange on 1/21/18.
//  Copyright © 2018 Dustin Lange. All rights reserved.
//

@import Foundation;
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLPBusiness : NSObject

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

- (void) setName:(NSString * _Nonnull)name;

/**
 *  Yelp id of this business.
 */
@property (nonatomic, readonly, copy) NSString *identifier;

@property (nonatomic, readonly, copy) NSString *category;

@property (nonatomic, readonly, copy) NSString *rating;

@property (nonatomic, readonly, copy) NSString *totalreviews;

@property (nonatomic, readwrite) BOOL isFavorite;

@property (nonatomic, readonly) CLLocation *location;

@property (nonatomic, readwrite, copy) CLLocation *location2;

@property (nonatomic, readonly, copy) NSString *thumbnail;

@property (nonatomic, readonly, copy) NSString *price;

@property (nonatomic, readwrite) double distance;




/**
 *  Name of this business.
 */
@property (nonatomic, readwrite, copy) NSString *name;

@end

NS_ASSUME_NONNULL_END
