//
//  CarbonCalcViewController.m
//  Decarbonate
//
//  Created by Kent Rogers on 5/18/17.
//  Copyright © 2017 Austin Rogers. All rights reserved.
//

#import "CarbonCalcViewController.h"
#import "AuthManager.h"
#import <SafariServices/SafariServices.h>

@import MapKit;

@interface CarbonCalcViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *transportTypeSegment;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITextField *startPointTextField;
@property (weak, nonatomic) IBOutlet UITextField *endPointTextField;
@property (weak, nonatomic) IBOutlet UILabel *offsetCostLabel;
@property (weak, nonatomic) IBOutlet UILabel *carbonFootprintLabel;
@property (weak, nonatomic) IBOutlet UIButton *calculateButton;
@property (weak, nonatomic) IBOutlet UIButton *payButton;
@property(strong, nonatomic) NSString *selectedTransportation;

@end

@implementation CarbonCalcViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    self.carbonFootprintLabel.text = @"0 lbs";
    self.offsetCostLabel.text = @"$0.00";
    
    self.calculateButton.layer.cornerRadius = self.calculateButton.bounds.size.height / 2;
    self.calculateButton.layer.masksToBounds = YES;
    self.endPointTextField.text = self.selectedEvent.address;
    
    [self.payButton setTitle:[NSString stringWithFormat:@"Pay Offset: %@", self.offsetCostLabel.text] forState:normal];
    self.payButton.layer.cornerRadius = self.payButton.bounds.size.height / 2;
    self.payButton.layer.masksToBounds = YES;
    self.payButton.enabled = NO;
    self.payButton.alpha = 0.5;
    
    [self segementedControlAction:self.transportTypeSegment];
}

- (IBAction)calculateButtonPressed:(id)sender {
    NSString *startString = self.startPointTextField.text;
    
    if ([startString isEqualToString:@""]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Invalid Address" message:@"Please make sure you enter a valid address." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okayAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okayAction];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    
    CLLocationCoordinate2D startCoor = [self getLocationFromAddressString:startString];
    CLLocationCoordinate2D endCoor = [self getLocationFromAddressString:self.endPointTextField.text];
    
    
    CLLocationDistance calcDistance = [self getDistanceFromPoints:&startCoor destination:&endCoor];
    NSNumber *distance = [NSNumber numberWithInt:calcDistance / 1000];
    [[AuthManager shared]calculateCarbonFootprintForEvent:self.selectedEvent transportation: self.selectedTransportation withDistance:distance completion:^(NSDictionary *dataObject) {
        NSLog(@"%@", dataObject);
        NSLog(@"%@", dataObject[@"price"]);
        NSNumber *price = dataObject[@"price"];
        self.offsetCostLabel.text = [NSString stringWithFormat:@"$%.2f", [price floatValue]];
        self.carbonFootprintLabel.text = [NSString stringWithFormat:@"%@ lbs", dataObject[@"footprint"]];
        [self.payButton setTitle:[NSString stringWithFormat:@"Pay Offset: $%.2f", [price floatValue]] forState:normal];
        self.payButton.enabled = YES;
        self.payButton.alpha = 1.0;
    }];
}

- (IBAction)segementedControlAction:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.selectedTransportation = @"automobile";
            break;
        case 1:
            self.selectedTransportation = @"bus";
            break;
        case 2:
            self.selectedTransportation = @"plane";
            break;
        default:
            break;
    }
}

- (IBAction)payButtonPressed:(UIButton *)sender {
    NSURL *url = [NSURL URLWithString:@"https://www.terrapass.com/product/individuals-families"];
    SFSafariViewController *safariVC = [[SFSafariViewController alloc]initWithURL:url];
    [self presentViewController:safariVC animated:YES completion:^{
        self.selectedEvent.paid = @1;
    }];
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
