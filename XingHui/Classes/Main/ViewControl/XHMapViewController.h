//
//  XHMapViewController.h
//  XingHui
//
//  Created by gaoyuerui on 15/11/17.
//  Copyright © 2015年 wangpei. All rights reserved.
//

#import "BasicViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
@interface XHMapViewController : BasicViewController<BMKGeneralDelegate>
-(instancetype)initWithLocation:(CLLocationCoordinate2D)location;
@end
