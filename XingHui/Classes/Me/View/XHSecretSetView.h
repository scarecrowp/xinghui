//
//  XHSecretSetView.h
//  XingHui
//
//  Created by gaoyuerui on 15/9/23.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SecretDelegate;
@interface XHSecretSetView : UITableView<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UILabel *head;
@property(nonatomic,strong)UILabel *foot;
@property(nonatomic,strong)NSArray *arr;
@property(nonatomic,weak) id<SecretDelegate>secdelegate;
@property int selectedIndexPath;
-(instancetype)initWithFrame:(CGRect)frame select:(int)select;
@end
@protocol SecretDelegate <NSObject>
-(void)Didselect:(int)selectIndex;

@end