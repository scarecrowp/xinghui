//
//  BasicViewController.h
//  QiaoGu
//
//  Created by JackLiu on 14-8-11.
//  Copyright (c) 2014年 ZXInsight. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MBProgressHUD.h"
@interface BasicViewController : UIViewController

@property (nonatomic,strong)UIView *topNavView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIButton *leftButton;
@property (nonatomic,strong)UIButton *rightButton;
@property(nonatomic,strong)AppDelegate *appdelegate;

@property (nonatomic)bool isEnterForeground;

- (void)setTitle:(NSString *)title;
- (void)leftButtonAction;
- (void)rightButtonAction;
- (void)topNavTapAction;
//- (void)viewTapAction;

 

-(void)hideKayBoard;

 
@end
