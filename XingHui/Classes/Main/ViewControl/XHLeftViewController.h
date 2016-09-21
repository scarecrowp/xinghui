//
//  XHLeftViewController.h
//  XingHui
//
//  Created by wangpei on 15/6/4.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZXRightDelegate;
@interface XHLeftViewController : UIViewController
-(void)reloadData;
@property (nonatomic,strong)id<ZXRightDelegate>delegate;

@end


@protocol ZXRightDelegate <NSObject>

@optional

-(void)didViewControlTransfor:(UIViewController *)controll;

@end