//
//  XHMyGatherTableViewCell.m
//  XingHui
//
//  Created by wangpei on 15/6/9.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHMyGatherTableViewCell.h"
#import "XHGather.h"
#import "UIImageView+Category.h"
@implementation XHMyGatherTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(id)initWithGather:(XHGather *)gather
{
    self=[[[NSBundle mainBundle] loadNibNamed:@"XHMyGatherTableViewCell" owner:nil options:nil] objectAtIndex:0];
 
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
    
        
        self.lb_distance.text =gather.distance;
        self.lb_location.text=gather.place;
        self.lb_time.text=gather.time;
        self.lb_title.text=gather.title;
        //[self.img setImage:[UIImage imageNamed:gather[@"mt_picture"]]];
        [self.img sd_setImageWithURL:[NSURL URLWithString:gather.img]];
        self.img.contentMode=UIViewContentModeScaleAspectFit;
        int xi=123;int w =5;int yi=75;
        for (int i=0; i<gather.joiner.count; i++) {
            UIImageView *hpic=[[UIImageView alloc] initWithFrame:CGRectMake(xi, yi, 18, 18)];
            hpic.layer.masksToBounds=YES;
            hpic.layer.cornerRadius=9;
            if ([[[gather.joiner objectAtIndex:i] objectForKey:@"user_pic"] isEqualToString:@""]) {
                [hpic setImageFromString:[[[gather.joiner objectAtIndex:i] objectForKey:@"user_realname"] substringToIndex:1] fontsize:14 paddintTop:0];
            }
            else
            {
              [hpic sd_setImageWithURL:[NSURL URLWithString:[NSString PicUrlString:[[gather.joiner objectAtIndex:i] objectForKey:@"user_pic"]]] placeholderImage:[UIImage imageNamed:@"head_deault"]];
            }

            xi=xi+w+18;
            [self.contentView addSubview:hpic];
        }
        UILabel *lb_info=[[UILabel alloc] init];
        lb_info.text=[NSString stringWithFormat:@"等%lu位好友参加",(unsigned long)gather.joiner.count];
        [lb_info setFont:[UIFont systemFontOfSize:12]];
        [lb_info setTextColor:[UIColor darkGrayColor]];
        [lb_info setFrame:CGRectMake(xi, yi, 100, 20)];
        [self.contentView addSubview:lb_info];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
