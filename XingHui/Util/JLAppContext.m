//
//  AppContext.m
//  EvenTouch
//
//  Created by Jack Liu on 14-5-9.
//  Copyright (c) 2014年 Jack Liu. All rights reserved.
//

#import "JLAppContext.h"
#import <QuartzCore/QuartzCore.h>

static NSDictionary *Names;
static NSArray *Keys;


@implementation JLAppContext

+ (void)initialize
{
	NSLog(@"AppContext init");
	
	NSString *path = [[NSBundle mainBundle] pathForResource:@"ServerAddress" ofType:@"plist"];
	NSDictionary *dict =[[NSDictionary alloc] initWithContentsOfFile:path];
	Names = dict;
    
    NSLog(@"Dictionary %@", Names);
	
	NSArray *array = [[Names allKeys] sortedArrayUsingSelector:@selector(compare:)];
	Keys = array;
    
    NSLog(@"Array %@", Keys);
}

/*
 根据key取接口地址
 */
+(NSString *) getServiceUrl:(NSString *) serviceKey
{
    NSString *serviceAddress = [Names objectForKey:[NSString stringWithFormat:@"AppServer%@",[Names objectForKey:@"AppMode"]]];
    
    return [NSString stringWithFormat:@"%@%@",serviceAddress,[Names objectForKey:serviceKey]];
}

@end
