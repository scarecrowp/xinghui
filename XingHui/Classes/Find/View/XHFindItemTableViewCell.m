//
//  XHFindItemTableViewCell.m
//  XingHui
//
//  Created by wangpei on 15/6/1.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHFindItemTableViewCell.h"

@implementation XHFindItemTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifiers data:(NSDictionary *)dic xibfile:(NSString *)xibfile
{
    self =  [[[NSBundle mainBundle] loadNibNamed:xibfile owner:nil options:nil] objectAtIndex:0];
    
    if (self) {
        
        self.line.hidden=YES;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.restorationIdentifier=reuseIdentifiers;
        [self setRestorationIdentifier:reuseIdentifiers];
        self.lb_title.text=dic[@"title"];
        [self.img_noti setHidden:YES];
        
        [self.icon setImage:[UIImage imageNamed:dic[@"icon"]]];
        if (dic[@"noti"]) {
            if ([[dic[@"noti"] ToString] isEqualToString:@"1"]) {
                [_img_noti setHidden:NO];
                _img_noti.layer.cornerRadius=4;
            }
        }
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
