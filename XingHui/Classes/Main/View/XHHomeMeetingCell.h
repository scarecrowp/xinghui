//
//  XHHomeMeetingCell.h
//  XingHui
//
//  Created by wangpei on 15/5/22.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XHGather;
@interface XHHomeMeetingCell : UITableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
-(void)setData:(XHGather *)gather;
-(void)removeJoinView;
@end
