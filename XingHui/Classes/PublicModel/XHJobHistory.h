//
//  XHJobHistory.h
//  XingHui
//
//  Created by gaoyuerui on 15/10/19.
//  Copyright © 2015年 wangpei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHJobHistory : NSObject
@property(nonatomic,strong)NSString *com_name;
@property(nonatomic,strong)NSString *begin_time;
@property(nonatomic,strong)NSString *end_time;
@property(nonatomic,strong)NSString *job_position;
@property(nonatomic,strong)NSString *job_note;
@property NSInteger uid;
@end
