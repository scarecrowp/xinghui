//
//  XHGatherCreaterCell.m
//  XingHui
//
//  Created by gaoyuerui on 15/12/3.
//  Copyright © 2015年 wangpei. All rights reserved.
//
#import "XHGatherCreaterCell.h"
#import "UIImage+Category.h"
@implementation XHGatherCreaterCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)init
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XHGatherCreaterCell"];
    if (self) {
        [self setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 76)];
        [self setBackgroundColor:Color(@"EEEEEE")];
        UIView *content =[[UIView alloc] init];
        self.selectionStyle=UITableViewCellSeparatorStyleNone;
        [content setBackgroundColor:Color(@"ffffff")];
        [self addSubview:content];
        [content mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.right.bottom.equalTo(self);
            make.top.equalTo(self).with.offset(10);
        }];
        _img_head=[[UIImageView alloc] init];
        [_img_head addTarget:self action:@selector(ToCreaterDetail)];
        [_img_head setBackgroundColor:[AciMath getColor:@"7595f1"]];
        _img_head.layer.cornerRadius=28;
        _img_head.layer.masksToBounds=YES;

        [content addSubview:_img_head];
        [_img_head mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(content).with.offset(15);
            make.top.equalTo(content).with.offset(10);
            make.size.mas_equalTo(CGSizeMake(56, 56));
        }];
        _lb_name = [UILabel new];
        [content addSubview:_lb_name];
        [_lb_name setFont:Bold(15)];
        [_lb_name setTextColor:Color(@"000000")];
        
      
        [_lb_name mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(_img_head.mas_right).with.offset(10);
            make.top.equalTo(content).with.offset(10);
            make.height.mas_equalTo(21);
            make.right.equalTo(content);
        }];
        
        //好友度
        _lb_relation =[UILabel new];
        [_lb_relation setBackgroundColor:Color(@"3EC07B")];
        [content addSubview:_lb_relation];
        _lb_relation.layer.masksToBounds = YES;
        _lb_relation.layer.cornerRadius = 2;
        _lb_relation.textColor = Color(@"ffffff");
        [_lb_relation setFont:Font(12)];
        
        _lb_job = [UILabel new];
        _lb_job.layer.masksToBounds = YES;
        _lb_job.layer.cornerRadius = 2;
        [_lb_job setBackgroundColor:Color(@"B06EDA")];
        [_lb_job setTextColor:Color(@"ffffff")];
        [_lb_job setFont:Font(12)];
        [content addSubview:_lb_job];
        
        _lb_distance = [UILabel new];
        [content addSubview:_lb_distance];
        [_lb_distance setTextColor:Color(@"9E9E9E")];
        [_lb_distance setFont:Font(17)];

        
        [_lb_relation mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(_lb_name);
            make.top.equalTo(_lb_name.mas_bottom).with.offset(5);
            make.height.mas_equalTo(21);
            make.width.mas_equalTo(30);
            make.right.equalTo(_lb_job.mas_left).with.offset(-10);
        }];
        
        
        [_lb_job mas_makeConstraints:^(MASConstraintMaker *make){
            make.height.centerY.equalTo(_lb_relation);
            make.left.equalTo(_lb_relation.mas_right).with.offset(10);
           // make.right.equalTo(_lb_distance.mas_right);
            
        
        }];
        
        [_lb_distance mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.equalTo(content).with.offset(10);
            make.centerY.equalTo(content);
            make.height.mas_equalTo(25);
            make.width.mas_equalTo(100);
          //  make.left.equalTo(_lb_job.mas_right);
        }];
    }
    return self;
}
-(void)setCreaterData:(XHUser *)user
{
    _lb_name.text = user.userRealName;
    _lb_relation.text =[NSString stringWithFormat:@" %d度 ", user.myfriend];
    _lb_job.text =[NSString stringWithFormat:@" %@ ",user.job] ;
    _lb_distance.text=user.distance;
    [_img_head sd_setImageWithURL:[NSURL URLWithString:user.userpic] placeholderImage:[UIImage imageFromString:@"王" size:_img_head.bounds.size fontsize:30 top:10]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)ToCreaterDetail
{
    [_delegate ToCreaterDetail];
}
@end
