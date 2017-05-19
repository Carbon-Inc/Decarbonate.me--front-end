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
        _objectID = json[@"id"];
        _name = json[@"name"];
        _eventDescription = json[@"description"];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
        NSDate *date = [dateFormatter dateFromString:json[@"start"]];
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

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.objectID = [aDecoder decodeObjectForKey:@"objectID"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.eventDescription = [aDecoder decodeObjectForKey:@"eventDescription"];
        self.start = [aDecoder decodeObjectForKey:@"start"];
        self.end = [aDecoder decodeObjectForKey:@"end"];
        self.eventId = [aDecoder decodeObjectForKey:@"eventId"];
        self.venueId = [aDecoder decodeObjectForKey:@"venueId"];
        self.logoId = [aDecoder decodeObjectForKey:@"logoId"];
        self.categoryId = [aDecoder decodeObjectForKey:@"categoryId"];
        self.paid = [aDecoder decodeObjectForKey:@"paid"];
        self.category = [aDecoder decodeObjectForKey:@"category"];
        self.img = [aDecoder decodeObjectForKey:@"img"];
        self.address = [aDecoder decodeObjectForKey:@"address"];
        self.eventImage = [aDecoder decodeObjectForKey:@"eventImage"];
    }
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.objectID forKey:@"objectID"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.eventDescription forKey:@"eventDescription"];
    [aCoder encodeObject:self.start forKey:@"start"];
    [aCoder encodeObject:self.end forKey:@"end"];
    [aCoder encodeObject:self.eventId forKey:@"eventId"];
    [aCoder encodeObject:self.venueId forKey:@"venueId"];
    [aCoder encodeObject:self.logoId forKey:@"logoId"];
    [aCoder encodeObject:self.categoryId forKey:@"categoryId"];
    [aCoder encodeObject:self.paid forKey:@"paid"];
    [aCoder encodeObject:self.category forKey:@"category"];
    [aCoder encodeObject:self.img forKey:@"img"];
    [aCoder encodeObject:self.address forKey:@"address"];
    [aCoder encodeObject:self.eventImage forKey:@"eventImage"];
    
}

@end
