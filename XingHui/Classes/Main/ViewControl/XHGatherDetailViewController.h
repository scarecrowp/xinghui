//
//  XHGatherDetailViewController.h
//  XingHui
//
//  Created by wangpei on 15/7/25.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "BasicViewController.h"
#import "XHGather.h"
@interface XHGatherDetailViewController : BasicViewController
-(instancetype)initWithTitle:(NSString *)title;
@property (weak, nonatomic) IBOutlet UIImageView *head_pic;

@property(nonatomic,strong)XHGather *gather;
@end
@interface CommentHeadview : UIView
@property(nonatomic,strong)UILabel *lb_title;
-(id)initWithTitle:(NSString *)title;
@end