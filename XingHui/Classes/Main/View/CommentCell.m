//
//  CommentCell.m
//  XingHui
//
//  Created by wangpei on 15/8/10.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "CommentCell.h"
#import "UILable+Category.h"
#import "UIImage+Category.h"
#import "UIView+Category.h"
#import "NSDate+Category.h"
@implementation CommentCell

- (void)awakeFromNib {
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self addSubview:self.headpic];
        [self addSubview:self.lb_name];
        [self addSubview:self.lb_time];
        [self addSubview:self.lb_comment];
        [self addSubview:self.bt_comment];
    }
    return self;
}
-(void)repay
{
    [_delegate repayComment:self.user];
}
-(void)ToPersionInfo
{
    [_delegate ToUserDetail:self.user];
}
-(void)setdada:(NSDictionary *)dic
{
    self.user=[[XHUser alloc] initWithDic:dic];
    _lb_name.text=dic[@"user_realname"];
    NSString *str_date=[dic[@"cmt_create"] ToString];
    NSDate *s=[AciMath getDate:str_date] ;
    
    _lb_time.text=[s formattedDateDescription];
    _lb_comment.text=dic[@"cmt_content"];
   
    if ([[dic[@"user_pic"] ToString] isEqualToString:@""]) {
        [_headpic setImage:[UIImage imageFromString:dic[@"user_realname"] size:_headpic.frame.size fontsize:26 top:5]];
        [_headpic setBackgroundColor:[AciMath getColor:@"7595f1"]];
    }
    else
    {
        [_headpic sd_setImageWithURL:[NSURL URLWithString:self.user.userpic] placeholderImage:[UIImage imageNamed:@"default_head_img"]];
    }
    [_lb_comment setAutoHeight];
    CGRect rect=self.frame;
    rect.size.height=CGRectGetMaxY(_lb_comment.frame);
    if ([_lb_comment maxY]<60) {
        rect.size.height=60;
    }
    [self setFrame:rect];
    

    }
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(UILabel *)lb_name
{
    if (!_lb_name) {
         _lb_name=[[UILabel alloc] initWithFrame:CGRectMake([self.headpic maxX]+10, 10,80, 21)];
    }
    return _lb_name;
}
-(UILabel *)lb_time
{
    if (!_lb_time) {
        _lb_time=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-150, 10, 140, 21)];
        [_lb_time setFont:[UIFont systemFontOfSize:14]];
        [_lb_time setTextColor:[AciMath getColor:@"a0a0a0"]];
  
        [_lb_time setFont:[UIFont systemFontOfSize:13]];
        _lb_time.textAlignment=NSTextAlignmentRight;
    }
    return _lb_time;
}
-(UIView *)headpic
{
    if(!_headpic)
    {
        _headpic=[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 48, 48)];
        _headpic.layer.cornerRadius=24;
        _headpic.layer.masksToBounds=YES;
        [_headpic addTarget:self action:@selector(ToPersionInfo)];
    }
    return _headpic;
}
-(UILabel *)lb_comment
{
    if (!_lb_comment) {
        _lb_comment=[[UILabel alloc] initWithFrame:CGRectMake([_headpic maxX]+10, [_lb_name maxY]+5, SCREEN_WIDTH-[_headpic maxX]-34-10, 20)];
        [_lb_comment setFont:[UIFont systemFontOfSize:12]];
        [_lb_comment setTextColor:[AciMath getColor:@"a0a0a0"]];
    }
    return _lb_comment;
}
-(UIButton *)bt_comment
{
    //评论按钮
    if (!_bt_comment) {
        _bt_comment=[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-34, [_lb_time maxY]+5, 14, 14)];
        [_bt_comment setImage:[UIImage imageNamed:@"bt_comment"] forState:UIControlStateNormal];
        [_bt_comment addTarget:self action:@selector(repay) forControlEvents:UIControlEventTouchUpInside];
  
    }
    return _bt_comment;
}
@end
