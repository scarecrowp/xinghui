//
//  XHPlaceCell.m
//  XingHui
//
//  Created by wangpei on 15/6/17.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHPlaceCell.h"
 
@implementation XHPlaceCell

- (void)awakeFromNib {
    // Initialization code
}
-(id)initWithdic:(NSDictionary *)dic
{
    self=[[[NSBundle mainBundle] loadNibNamed:@"XHPlaceCell" owner:nil options:nil] objectAtIndex:0];
    
    if (self) {
        _lb_title.text=dic[@"name"];
  
        _lb_address.text=dic[@"address"];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
