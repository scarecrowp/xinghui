//
//  MyCustomTableViewCell.h
//  XingHui
//
//  Created by wangpei on 15/8/25.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCustomTableViewCell : UITableViewCell
{
    UIView *customSeparatorView;
    CGFloat separatorHight;
}
@property (nonatomic,weak)UIView *originSeparatorView;
@end
