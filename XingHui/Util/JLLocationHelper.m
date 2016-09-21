//
//  JLLocationHelper.m
//  QiaoGu
//
//  Created by JackLiu on 14-9-1.
//  Copyright (c) 2014年 ZXInsight. All rights reserved.
//

#import "JLLocationHelper.h"
#import <CoreLocation/CoreLocation.h>

@interface JLLocationHelper ()<CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    
    NSString *currentCity;

}

@end

@implementation JLLocationHelper

@synthesize delegate = _delegate;

- (id)init
{
    self = [super init];
    if (self) {
        [self initLocation];
    }
    return self;
}

- (void)initLocation
{
   
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.delegate = self;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [locationManager requestWhenInUseAuthorization];  //调用了这句,就会弹出允许框了.
}

- (void)startLacation
{
    currentCity = nil;
    [locationManager startUpdatingLocation];
}

- (void)stop
{
    [locationManager stopUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{    
    //获取所在地城市名
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks,NSError *error)
     {
         for(CLPlacemark *placemark in placemarks)
         {
             if (!currentCity)
             {
                 currentCity = [placemark.addressDictionary objectForKey:@"City"];
                 
                 if (!currentCity || currentCity.length<1)
                 {
                     currentCity = [placemark.addressDictionary objectForKey:@"State"];
                     currentCity = [currentCity substringToIndex:currentCity.length-1];
                 }
                 
                 NSMutableDictionary *addressDictionary = [NSMutableDictionary new];
                 // 市 eg:上海市
                 [addressDictionary setObject:currentCity forKey:@"city"];
                 // 纬度
                 [addressDictionary setObject:[NSString stringWithFormat:@"%f",newLocation.coordinate.latitude] forKey:@"latitude"];
                 // 经度
                [addressDictionary setObject:[NSString stringWithFormat:@"%f",newLocation.coordinate.longitude] forKey:@"longitude"];
                 // 区 eg:闸北区
//                [addressDictionary setObject:[placemark.addressDictionary objectForKey:@"SubLocality"] forKey:@"SubLocality"];
                 // 详细地址 eg:原平路918弄27号
                [addressDictionary setObject:[placemark.addressDictionary objectForKey:@"Thoroughfare"] forKey:@"detail"];
                 // 国家 eg:中国
                [addressDictionary setObject:[placemark.addressDictionary objectForKey:@"Country"] forKey:@"Country"];
                 // 带国界的详细地址 eg:中国上海市闸北区彭浦镇永和教师苑原平路918弄27号
                 [addressDictionary setObject:[placemark.addressDictionary objectForKey:@"FormattedAddressLines"] forKey:@"FormattedAddressLines"];
                 
                 [_delegate didUpdateToLocation:addressDictionary];
             }
             NSLog(@"str == %@",currentCity);
         }
     }];
    
    [self stop];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [self stop];
    [_delegate updateLocationFailWithError:error];
}

#pragma mark -

@end
