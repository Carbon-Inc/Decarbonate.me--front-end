//
//  CarbonCalcViewController.m
//  Decarbonate
//
//  Created by Kent Rogers on 5/18/17.
//  Copyright © 2017 Austin Rogers. All rights reserved.
//

#import "CarbonCalcViewController.h"
#import "AuthManager.h"

@import MapKit;

@interface CarbonCalcViewController ()

@end

@implementation CarbonCalcViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@", self.selectedEvent.name);
    [[AuthManager shared] calculateCarbonFootprintForEvent:self.selectedEvent withDistance:@"1000"];
    [self getLocationFromAddressString:@"2409 141st pl SE, Mill Creek, WA"];
}

- (IBAction)calculateButtonPressed:(id)sender {
    NSString *startString = self.startPointTextField.text;
    NSString *endString = self.endPointTextField.text;
    CLLocationCoordinate2D startCoor = [self getLocationFromAddressString:startString];
    CLLocationCoordinate2D endCoor = [self getLocationFromAddressString:endString];
    
    CLLocationDistance calcDistance = [self getDistanceFromPoints:&startCoor destination:&endCoor];
    
}

- (IBAction)payButtonPressed:(id)sender {
}



-(CLLocationCoordinate2D) getLocationFromAddressString: (NSString*) addressStr {
    double latitude = 0, longitude = 0;
    NSString *esc_addr =  [addressStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *req = [NSString stringWithFormat:@"https://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", esc_addr];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    if (result) {
        NSScanner *scanner = [NSScanner scannerWithString:result];
        if ([scanner scanUpToString:@"\"lat\" :" intoString:nil] && [scanner scanString:@"\"lat\" :" intoString:nil]) {
            [scanner scanDouble:&latitude];
            if ([scanner scanUpToString:@"\"lng\" :" intoString:nil] && [scanner scanString:@"\"lng\" :" intoString:nil]) {
                [scanner scanDouble:&longitude];
            }
        }
    }
    CLLocationCoordinate2D center;
    center.latitude=latitude;
    center.longitude=longitude;
    NSLog(@"View Controller get Location Logitute : %f",center.latitude);
    NSLog(@"View Controller get Location Latitute : %f",center.longitude);
    return center;
    
}

-(CLLocationDistance) getDistanceFromPoints: (CLLocationCoordinate2D*) source destination: (CLLocationCoordinate2D*) destination {
    
    CLLocationCoordinate2D* Location1 = source;
    CLLocationCoordinate2D* Location2 = destination;
    
    CLLocation *originLocation = [[CLLocation alloc] initWithLatitude:Location1->latitude longitude:Location1->longitude];
    CLLocation *destinationLocation = [[CLLocation alloc] initWithLatitude:Location2->latitude longitude:Location2->longitude];
    CLLocationDistance distance = [originLocation distanceFromLocation:destinationLocation];
    
    NSLog(@"%f METERS", distance);
    return distance;
}

@end
