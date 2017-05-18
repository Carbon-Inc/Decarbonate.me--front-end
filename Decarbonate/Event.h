//
//  Event.h
//  Decarbonate
//
//  Created by Adrian Kenepah-Martin on 5/17/17.
//  Copyright © 2017 Austin Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface Event : NSObject

@property(strong, nonatomic)NSString *id;
@property(strong, nonatomic)NSString *name;
@property(strong, nonatomic)NSString *eventDescription;
@property(strong, nonatomic)NSString *start;
@property(strong, nonatomic)NSString *end;
@property(strong, nonatomic)NSString *eventId;
@property(strong, nonatomic)NSString *venueId;
@property(strong, nonatomic)NSString *logoId;
@property(strong, nonatomic)NSString *categoryId;
@property(strong, nonatomic)NSNumber *paid;
@property(strong, nonatomic)NSString *category;
@property(strong, nonatomic)NSString *img;
@property(strong, nonatomic)NSString *address;
@property(strong, nonatomic)UIImage *eventImage;

-(instancetype)initWithDictionary:(NSDictionary *)json;

@end
