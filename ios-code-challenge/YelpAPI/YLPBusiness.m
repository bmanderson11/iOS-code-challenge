//
//  YLPBusiness.m
//  ios-code-challenge
//
//  Created by Dustin Lange on 1/21/18.
//  Copyright © 2018 Dustin Lange. All rights reserved.
//

#import "YLPBusiness.h"


@implementation YLPBusiness


- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    if(self = [super init]) {
        
        
        NSMutableArray *categories = [NSMutableArray new];
       
        _rating = [NSString stringWithFormat:@"%@",attributes[@"rating"]];
        _totalreviews = [NSString stringWithFormat:@"%@",attributes[@"review_count"]];
        _price = attributes[@"price"];
        _identifier = attributes[@"id"];
        _name = attributes[@"name"];
        _thumbnail = attributes[@"image_url"];
        _isFavorite = false;
        
        NSArray *catDict = [attributes objectForKey:@"categories"];
        for (NSDictionary* o in catDict)
        {
            NSDictionary *placeholder = o;
            [categories addObject:[placeholder valueForKey:@"title"]];
            
        }
        
        NSDictionary *coordinatesDict = [attributes objectForKey:@"coordinates"];
       
        NSNumber *longitude = [coordinatesDict valueForKey:@"longitude"];
        NSNumber *latitude = [coordinatesDict valueForKey:@"latitude"];
        
        
        if ([longitude isKindOfClass:[NSNull class]]){
            CLLocation *location = [[CLLocation alloc] initWithLatitude:0 longitude:0];
           
            _location = location;
        }else{
            
            
        CLLocation *location = [[CLLocation alloc] initWithLatitude:[latitude doubleValue] longitude:[longitude doubleValue]];
            _location = location;
        }
        
        _category = [categories componentsJoinedByString:@", "];
        
    }
    
    return self;
}




@end
