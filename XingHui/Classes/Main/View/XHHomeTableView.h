//
//  XHHomeTableView.h
//  XingHui
//
//  Created by wangpei on 15/5/25.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XHHomeTableViewDelegate;
@interface XHHomeTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
-(id)initWithFrame:(CGRect)rect;
-(void)storeArr:(NSMutableArray *)dataArr;
@property(nonatomic,weak) id<XHHomeTableViewDelegate>homedelegate;
 
@end
@protocol XHHomeTableViewDelegate <NSObject>

-(void)seletegather:(NSDictionary *)index;

@end
