//
//  Event.m
//  Decarbonate
//
//  Created by Adrian Kenepah-Martin on 5/17/17.
//  Copyright © 2017 Austin Rogers. All rights reserved.
//

#import "Event.h"

@implementation Event

-(instancetype)initWithDictionary:(NSDictionary *)json{
    self = [super init];
    
    if (self) {
        _id = json[@"id"];
        _name = json[@"name"];
        _eventDescription = json[@"description"];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
        NSDate *date = [dateFormatter dateFromString:json[@"start"]];
        NSTimeZone *pdt = [NSTimeZone timeZoneWithAbbreviation:@"PDT"];
        [dateFormatter setTimeZone:pdt];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        _start = [dateFormatter stringFromDate:date];
        
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'hh:mm:ss"];
//        NSString *dateString = json[@"start"];
//        NSLog(@"DATE STRING: %@", dateString);
//        NSDateFormatter *dateF = [[NSDateFormatter alloc]init];
//        [dateF setDateFormat:@"yyyy-MM-dd"];
//        NSDate *date = [dateF dateFromString:dateString];
//        NSLog(@"DATE: %@", date);
//        _start = [dateFormatter stringFromDate:date];
        _end = json[@"end"];
        _eventId = json[@"eventId"];
        _venueId = json[@"venueId"];
        _logoId = json[@"logoId"];
        _categoryId = json[@"categoryId"];
        _paid = json[@"paid"];
        _category = json[@"category"];
        _img = json[@"img"];
        _address = json[@"address"];
    }
    
    return self;
}

@end
