//
//  XHTableViewCell.m
//  XingHui
//
//  Created by wangpei on 15/6/5.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHTableViewCell.h"

@implementation XHTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(id)initWithViewType:(int)viewtype title:(NSString *)title defaultTxt:(NSString *)defaultTxt
{
    self =[super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XHTableViewCell"];
    if (self) {
        UILabel *lb_title =[[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 25)];
        lb_title.text =title;
        [self.contentView addSubview:lb_title];
              switch (viewtype) {
            case 1://输入框
                  if (YES) {
                      UITextField *tb = [[UITextField alloc] initWithFrame:CGRectMake(self.frame.size.width-100, 5, 100, 25)];
                      tb.borderStyle = UITextBorderStyleNone;
                      tb.placeholder=defaultTxt;

                  }
                      
                break;
                case 2://跳转Label
                      if (YES) {
                          UILabel *lb=[[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-100, 5, 100, 25)];
                          lb.text=defaultTxt;
                          UIImageView *img =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellright"]];
                          [self.contentView addSubview:lb];
                          [img setFrame:CGRectMake(CGRectGetMaxX(lb.frame)-9, 5, 9, 15)];
                          [self.contentView addSubview:img];
                      }
                      break;
                      case 3://图片
                      if(YES)
                      {
                          UIImageView *img =[[UIImageView alloc] initWithImage:[UIImage imageNamed:defaultTxt]];
                          [img setFrame:CGRectMake(self.frame.size.width-60, 5, 57, 57)];
                          [self.contentView addSubview:img];
                      }
                      
            default:
                break;
        }
        
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
