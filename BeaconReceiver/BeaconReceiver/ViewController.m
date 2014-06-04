//
//  ViewController.m
//  BeaconReceiver
//
//  Created by Christopher Ching on 2013-11-28.
//  Copyright (c) 2013 AppCoda. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.statusLabel.text = @"Loading";
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)locationManager:(CLLocationManager*)manager didEnterRegion:(CLRegion *)region
{
    self.statusLabel.text = @"Finding beacons.";
    [self.locationManager startRangingBeaconsInRegion:self.myBeaconRegion];
}

-(void)locationManager:(CLLocationManager*)manager didExitRegion:(CLRegion *)region
{
    self.statusLabel.text = @"None found.";
    [self.locationManager stopRangingBeaconsInRegion:self.myBeaconRegion];
}

-(void)locationManager:(CLLocationManager*)manager
       didRangeBeacons:(NSArray*)beacons
              inRegion:(CLBeaconRegion*)region
{
    // Beacon found!
    self.statusLabel.text = @"Beacon found!";
    
    CLBeacon *foundBeacon = [beacons firstObject];
    
    // You can retrieve the beacon data from its properties
    //NSString *uuid = foundBeacon.proximityUUID.UUIDString;
    //NSString *major = [NSString stringWithFormat:@"%@", foundBeacon.major];
    //NSString *minor = [NSString stringWithFormat:@"%@", foundBeacon.minor];
}

- (IBAction)startButtonClicked:(id)sender {
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:self.uuidField.text];
    
    self.myBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                             identifier:@"roflkopter"];
    [self.locationManager startMonitoringForRegion:self.myBeaconRegion];
    
    if (![CLLocationManager isMonitoringAvailableForClass:[CLBeaconRegion class]]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Monitoring not available" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil]; [alert show]; return;
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Starting monitoring" message:nil delegate:nil cancelButtonTitle:@"Great!" otherButtonTitles:nil, nil];
        [alert show];
    }
}

@end
