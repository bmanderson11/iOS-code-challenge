//
//  YLPSearchQuery.m
//  ios-code-challenge
//
//  Created by Dustin Lange on 1/21/18.
//  Copyright © 2018 Dustin Lange. All rights reserved.
//

#import "YLPSearchQuery.h"

@interface YLPSearchQuery()

@property (nonatomic, copy) NSString *location;
@property (nonatomic) int offset;
@property (nonatomic, copy) CLLocation *cord;
@property (nonatomic, copy) NSString *bID;

@end

@implementation YLPSearchQuery

- (instancetype)initWithLocation:(NSString *)location
{
    if(self = [super init]) {
        _location = location;
    }
    
    return self;
}

-(instancetype)initWithCord:(CLLocation *)location{
    if(self = [super init]) {
        _cord = location;
        
    }
    
    return self;
}


-(instancetype)initWithOffset:(CLLocation *)location offset:(UInt32)offset{
    if(self = [super init]) {
        _cord = location;
        _offset = offset;
        
    }
   
    return self;
}




- (NSDictionary *)parameters
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if(self.location) {
        params[@"location"] = self.location;
    }
    
    
    if(self.cord) {
        params[@"longitude"] = [NSString stringWithFormat:@"%lf", self.cord.coordinate.longitude];
        params[@"latitude"] = [NSString stringWithFormat:@"%lf", self.cord.coordinate.latitude];
        params[@"sort_by"] = @"distance";
        params[@"limit"] = @"50";
        params[@"offset"] = [NSString stringWithFormat:@"%d", self.offset];
        params[@"radius"] =  @"40000";
    }
    
    if(self.term) {
        params[@"term"] = self.term;
    }
    
    if(self.radiusFilter > 0) {
        params[@"radius"] = @(self.radiusFilter);
    }
    
    if(self.categoryFilter != nil && self.categoryFilter.count > 0) {
        params[@"categories"] = [self.categoryFilter componentsJoinedByString:@","];
    }
    
    return params;
}

- (NSArray<NSString *> *)categoryFilter {
    return _categoryFilter ?: @[];
}

@end
