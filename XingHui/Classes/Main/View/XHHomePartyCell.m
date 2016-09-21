//
//  XHHomePartyCell.m
//  XingHui
//
//  Created by wangpei on 15/5/25.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHHomePartyCell.h"
#import "XHGather.h"
#import "UIImageView+WebCache.h"
#import "UILable+Category.h"
#import "UIImageView+Category.h"
@implementation XHHomePartyCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier data:(XHGather *)gather
{
    self=[super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XHHomePartyCell"];
  
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //顶部灰色
        UIView *view_top =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        [view_top setBackgroundColor:[UIColor ColorWithHexString:@"F0F0F0"]];
        [self.contentView addSubview:view_top];
        //大图
        UIImageView *bigPic =[[UIImageView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, SCREEN_WIDTH/2)];
        [bigPic sd_setImageWithURL:[NSURL URLWithString:gather.img]];
        bigPic.contentMode=UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:bigPic];
        
     
        //圆头像
        UIImageView *img =[[UIImageView alloc] initWithFrame:CGRectMake(10, [bigPic maxY]+8, 51, 51)];
        img.layer.masksToBounds=YES;
        img.layer.cornerRadius =25;
        img.contentMode = UIViewContentModeScaleAspectFit;
        [img sd_setImageWithURL:[NSURL URLWithString:gather.img] placeholderImage:[UIImage imageNamed:@"head_deault"]];
        [self.contentView addSubview:img];
        
        //标题
        UILabel *lb_title =[[UILabel alloc] initWithFrame:CGRectMake(73, [bigPic maxY]+8, SCREEN_WIDTH-73, 21)];
        [lb_title setFont:[UIFont systemFontOfSize:15]];
        [self.contentView addSubview:lb_title];
        lb_title.text =gather.title;
        
        //时间
        UILabel *lb_time=[[UILabel alloc] initWithFrame:CGRectMake(0,  [bigPic maxY]+8, 0, 21)];
        lb_time.font=[UIFont systemFontOfSize:12];
        lb_title.textColor=[AciMath getColor:@"989898"];
        lb_time.text=gather.time;
        
        float wd=[lb_time widthWithTitle];
        [lb_time setFrame:CGRectMake(SCREEN_WIDTH-wd-10, [bigPic maxY]+8, wd, 21)];
        [self.contentView addSubview:lb_time];
        //time图标
        UIImageView *icon_time=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"time"]];
        [icon_time setFrame:CGRectMake(lb_time.frame.origin.x-13, lb_time.frame.origin.y+5, 10, 10)];
        [self.contentView addSubview:icon_time];
        
        //设置关注人头像
        int xi=74;int w =5;int yi=[lb_title maxY]+5;
        for (int i=0; i<gather.joiner.count; i++) {
            UIImageView *hpic=[[UIImageView alloc] initWithFrame:CGRectMake(xi, yi, 18, 18)];
            hpic.layer.masksToBounds=YES;
            hpic.layer.cornerRadius=9;
            if ([[[gather.joiner objectAtIndex:i] objectForKey:@"user_pic"] isEqualToString:@""]) {
                [hpic setImageFromString:[[[gather.joiner objectAtIndex:i] objectForKey:@"user_realname"] substringToIndex:1] fontsize:14 paddintTop:0];
            }
            else
            {
                [hpic sd_setImageWithURL:[NSURL URLWithString:[NSString PicUrlString2:[[gather.joiner objectAtIndex:i] objectForKey:@"user_pic"]]]];
            }

            xi=xi+w+18;
            [self.contentView addSubview:hpic];
        }
        //关注人数
        UILabel *lb_info=[[UILabel alloc] init];
        lb_info.text=[NSString stringWithFormat:@"等%lu位好友参加",(unsigned long)gather.joiner.count];
        [lb_info setFont:[UIFont systemFontOfSize:12]];
        [lb_info setTextColor:[AciMath getColor:@"989898"]];
        [lb_info setFrame:CGRectMake(xi, yi, 100, 20)];
        [self.contentView addSubview:lb_info];
        _lb_time.text=gather.time;
        _lb_title.text=gather.title;
        [self setFrame:CGRectMake(0, 0, SCREEN_WIDTH, [img maxY]+10)];
    }
    return self;
}
-(void)setData:(XHGather *)gather
{
    
}
@end
