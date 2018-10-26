//
//  ViewController.m
//  FakeGPS
//
//  Created by 曾觉新 on 2018/10/24.
//  Copyright © 2018 曾觉新. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "JXLocationConverter.h"

@interface ViewController ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLGeocoder *geocoder;

@property (nonatomic, strong) UILabel *cityLabel;

@end

@implementation ViewController

- (CLLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        [_locationManager requestWhenInUseAuthorization];
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [_locationManager requestWhenInUseAuthorization];//授权
        _locationManager.delegate = self;
        
    }
    return _locationManager;
}
- (UILabel *)cityLabel
{
    if (!_cityLabel) {
        _cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 50)];
        _cityLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _cityLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.cityLabel];
    
    [self.locationManager startUpdatingLocation];
    self.geocoder = [[CLGeocoder alloc] init];
    
//    https://lbs.amap.com/console/show/picker  //高德地图坐标查询
//    http://api.map.baidu.com/lbsapi/getpoint/index.html  //百度坐标查询
    //高德地图标准转世界地图标准
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(31.246016, 121.510002);
    coordinate = [JXLocationConverter gcj02ToWgs84:coordinate];
    NSLog(@"longitude = %f, latitude = %f", coordinate.longitude, coordinate.latitude);
}

#pragma mark- CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    
    CLLocation *location = [locations lastObject];
    
    NSLog(@"lon = %f,lat = %f",location.coordinate.longitude, location.coordinate.latitude);
    
    
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *placemark = [placemarks lastObject];
        NSLog(@"country = %@", placemark.country);
        NSLog(@"locality = %@", placemark.locality);
        NSLog(@"subLocality = %@", placemark.subLocality);
        NSLog(@"name = %@", placemark.name);
        NSLog(@"thoroughfare = %@", placemark.thoroughfare);
        NSLog(@"subThoroughfare = %@",placemark.subThoroughfare);
        NSLog(@"administrativeArea = %@", placemark.administrativeArea);
        NSLog(@"subAdministrativeArea = %@", placemark.subAdministrativeArea);
        NSLog(@"postalCode = %@", placemark.postalCode);
        NSLog(@"ISOcountryCode = %@", placemark.ISOcountryCode);
        NSLog(@"inlandWater = %@", placemark.inlandWater);
        NSLog(@"ocean = %@", placemark.ocean);
        NSLog(@"areasOfInterest = %@", [placemark.areasOfInterest lastObject]);
        
        
        self.cityLabel.text = [NSString stringWithFormat:@"%@", placemark.name];
        
    }];
    
    [manager stopUpdatingLocation];
}



@end
