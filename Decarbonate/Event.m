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
        
//        NSDateComponents *components = [NSCalendar currentCalendar]
        
        NSTimeZone *pdt = [NSTimeZone timeZoneWithAbbreviation:@"PDT"];
        [dateFormatter setTimeZone:pdt];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        if ([self isValidDate:date]) {
            _start = [dateFormatter stringFromDate:date];
        } else {
            return nil;
        }
        
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

-(BOOL)isValidDate:(NSDate *)eventDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:@"2017-01-01"];
    switch ([eventDate compare:date]) {
        case NSOrderedAscending:
            NSLog(@"Invalid");
            return NO;
            break;
        case NSOrderedDescending:
            NSLog(@"Valid");
            return YES;
            break;
        case NSOrderedSame:
            NSLog(@"Same");
            return YES;
            break;
    }
}

@end
