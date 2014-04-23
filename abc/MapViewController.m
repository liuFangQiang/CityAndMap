//
//  MapViewController.m
//  abc
//
//  Created by Ibokan on 14-4-23.
//  Copyright (c) 2014年 CainiaoLiu. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _mapView = [[MKMapView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _mapView.mapType = MKMapTypeStandard;
    _mapView.delegate = self;
    [self.view addSubview: _mapView];
 
    _locManager  = [[CLLocationManager alloc]init];
    _locManager.delegate = self;
    _locManager.desiredAccuracy = kCLLocationAccuracyBest;
    [_locManager startUpdatingLocation];
    
    CLGeocoder * geocoder = [[CLGeocoder alloc]init];
    [geocoder geocodeAddressString:self.city completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"");
        CLPlacemark * placeMark = [placemarks objectAtIndex:0];
      
        
       
    
//        NSLog(@"country:%@,locality:placeMark.locality=%@,placeMark.administrativeArea=====%@,placeMark.region====%@",placeMark.country,placeMark.locality,placeMark.administrativeArea,placeMark.region);
        
        CLLocationCoordinate2D coor = CLLocationCoordinate2DMake([self.att[0] floatValue], [self.att[1] floatValue]);
        _mapView.centerCoordinate = placeMark.location.coordinate;
        MKPointAnnotation * annotationView = [[MKPointAnnotation alloc] init];
        annotationView.title = self.city;
        annotationView.coordinate = coor;
        MKCoordinateSpan span = MKCoordinateSpanMake(1, 1);
        _mapView.region = MKCoordinateRegionMake(coor, span);
        [_mapView addAnnotation:annotationView];
        
        [_mapView selectAnnotation:annotationView animated:YES];
        
    }];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
