//
//  NXTBusinessTableViewCell+YLPBusiness.m
//  ios-code-challenge
//
//  Created by Dustin Lange on 1/21/18.
//  Copyright © 2018 Dustin Lange. All rights reserved.
//
#import <CoreLocation/CoreLocation.h>
#import "NXTBusinessTableViewCell+YLPBusiness.h"
#import "YLPBusiness.h"

@implementation NXTBusinessTableViewCell (YLPBusiness) 

- (void)configureCell:(YLPBusiness *)business
{
    // Business Name
    NSString *str = @"Rating: ";
    str = [str stringByAppendingString:business.rating];
    str = [str stringByAppendingString:@" ("];
    str = [str stringByAppendingString:business.totalreviews];
    str = [str stringByAppendingString:@")"];
    self.nameLabel.text = business.name;
    self.catLabel.text = business.category;
    self.reviewsLabel.text = business.totalreviews;
    
    if([business.rating isEqualToString:@"1"]) {
        self.ratingImageView.image = [UIImage imageNamed:@"1"];
           }
    else if([business.rating isEqualToString:@"1.5"]) {
        self.ratingImageView.image = [UIImage imageNamed:@"1.5"];
           }
    else if([business.rating isEqualToString:@"2"]) {
        self.ratingImageView.image = [UIImage imageNamed:@"2"];
           }
    else if([business.rating isEqualToString:@"2.5"]) {
        self.ratingImageView.image = [UIImage imageNamed:@"2.5"];
           }
    else if([business.rating isEqualToString:@"3"]) {
        self.ratingImageView.image = [UIImage imageNamed:@"3"];
           
           }
    else if([business.rating isEqualToString:@"3.5"]) {
        self.ratingImageView.image = [UIImage imageNamed:@"3.5"];
           
           }
    else if([business.rating isEqualToString:@"4"]) {
        self.ratingImageView.image = [UIImage imageNamed:@"4"];
           
           }
    else if([business.rating isEqualToString:@"4.5"]) {
        self.ratingImageView.image = [UIImage imageNamed:@"4.5"];
           
           }
    else if([business.rating isEqualToString:@"5"]) {
        self.ratingImageView.image = [UIImage imageNamed:@"1"];
    }
    
    self.distanceLabel.text = [NSString stringWithFormat:@"%.1fmi",(business.distance/1609.344)];
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:business.thumbnail]];
        if ( data == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            // WARNING: is the cell still using the same data by this point??
            self.restImageView.image = [UIImage imageWithData: data];
        });
    });
}

#pragma mark - NXTBindingDataForObjectDelegate
- (void)bindingDataForObject:(id)object
{
    [self configureCell:(YLPBusiness *)object];
}

@end
