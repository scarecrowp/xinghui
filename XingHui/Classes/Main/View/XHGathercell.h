//
//  XHGathercell.h
//  XingHui
//
//  Created by wangpei on 15/6/10.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XHGather;
@interface XHGathercell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img_head;
-(id)initWithGather:(XHGather *)gather;
@end
