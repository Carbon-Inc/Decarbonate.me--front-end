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
        _start = json[@"start"];
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
