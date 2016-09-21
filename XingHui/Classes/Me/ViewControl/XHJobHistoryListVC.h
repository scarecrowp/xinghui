//
//  XHJobHistoryListVC.h
//  XingHui
//
//  Created by gaoyuerui on 15/10/19.
//  Copyright © 2015年 wangpei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassValueDelegate.h"
@interface XHJobHistoryListVC : BasicViewController
@property(nonatomic,strong)NSMutableArray *JobArr;
@property (nonatomic, strong)id<PassValueDelegate> passdelegate;
@end
