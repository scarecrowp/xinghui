//
//  XHEmptyView.m
//  XingHui
//
//  Created by wangpei on 15/9/6.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHEmptyView.h"

@implementation XHEmptyView
-(instancetype)init
{
    self=[super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/2)];
    
    UILabel *lb=[[UILabel alloc] init];
    lb.text=@"暂无数据";
    [lb setTextColor:[AciMath getColor:@"656565"]];
   
    [lb sizeToFit];
     lb.center=self.center;
    [self addSubview:lb];
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
