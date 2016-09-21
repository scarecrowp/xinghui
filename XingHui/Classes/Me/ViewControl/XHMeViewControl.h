//
//  XHMeViewControl.h
//  XingHui
//
//  Created by wangpei on 15/5/18.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHMeViewControl : BasicViewController
@property (weak, nonatomic) IBOutlet UIImageView *img_head;


@property (weak, nonatomic) IBOutlet UIView *view_top;
@property (strong, nonatomic) IBOutlet UIView *head_view;
@property(nonatomic,strong)NSString *s;
@end
