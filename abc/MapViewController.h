//
//  MapViewController.h
//  abc
//
//  Created by Ibokan on 14-4-23.
//  Copyright (c) 2014年 CainiaoLiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface MapViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>
{

    MKMapView * _mapView;
    CLLocationManager * _locManager;


}
@property(nonatomic,strong)NSMutableArray * att;

@property(nonatomic,strong)NSString * city;
@end
