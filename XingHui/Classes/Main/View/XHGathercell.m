//
//  XHGathercell.m
//  XingHui
//
//  Created by wangpei on 15/6/10.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHGathercell.h"
#import "XHGather.h"
@implementation XHGathercell

- (void)awakeFromNib {
    _img_head.layer.cornerRadius =27;
    // Initialization code
}
-(id)initWithGather:(XHGather *)gather
{
    self=[[[NSBundle mainBundle] loadNibNamed:@"XHGathercell" owner:nil options:nil] objectAtIndex:0];
    
    if (self) {
        [self ToString];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
