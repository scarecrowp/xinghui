//
//  XHHomeMeetingCell.m
//  XingHui
//
//  Created by wangpei on 15/5/22.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHHomeMeetingCell.h"
#import "XHGather.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"
#import "UIImageView+Category.h"
@interface XHHomeMeetingCell()
{
    UIView *contentBord;
}
@property (nonatomic)  UIImageView *pic_head;
@property ( nonatomic)  UILabel *lb_name;
@property (nonatomic)  UILabel *lb_relation;
@property (nonatomic)  UILabel *lb_title;
@property (nonatomic)  UILabel *lb_location;
@property (nonatomic)  UILabel *lb_time;
@property (nonatomic)  UILabel *lb_focus;
@property (nonatomic)  UILabel *lb_distance;
@property (nonatomic)  UIImageView *pic_gather;
@property(nonatomic,strong)  UILabel *lb_info;
@end
@implementation XHHomeMeetingCell
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//
- (void)layoutSubviews {
    
    [super layoutSubviews];
   
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor =Color(@"f0f0f0");
        contentBord =[UIView new];
        contentBord.backgroundColor = Color(@"ffffff");
        [self.contentView addSubview:contentBord];
        
        _lb_title = [UILabel new];
        _lb_distance = [UILabel new];
        _pic_head = [[UIImageView alloc] init];
        UILabel *lb_creater=[[UILabel alloc] init];
        _lb_name = [[UILabel alloc] init];
        _lb_relation = [UILabel new];
        _pic_gather = [UIImageView new];
        
        [contentBord addSubview:_lb_title];
        [contentBord addSubview:_lb_distance];
        [contentBord addSubview:_pic_head];
        [contentBord addSubview:lb_creater];
        [contentBord addSubview:_lb_name];
        [contentBord addSubview:_lb_relation];
        [contentBord addSubview:_pic_gather];
        
        [contentBord mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.right.bottom.equalTo(self.contentView);
            make.top.equalTo(self.contentView.mas_top).with.offset(14);
        }];
        
      
        [_lb_title setTextColor:Color(@"333333")];
        [_lb_title setFont:Font(18)];
        
        [_lb_title mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(contentBord).with.offset(10);
            make.top.equalTo(contentBord.mas_top).with.offset(5);
            make.right.mas_equalTo(_lb_distance.mas_left);
            make.height.mas_equalTo(30);
        }];
        
        
    
       
       
      
        lb_creater.text=@"发起人:";
        [lb_creater setFont:Font(14)];
        [lb_creater mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(contentBord).with.offset(10);
            
            make.centerY.equalTo(_pic_head);
            make.height.mas_equalTo(21);
            make.width.mas_equalTo(55);
          //  make.right.equalTo(_lb_name.mas_left);
            
        }];
        
        
        [_pic_head mas_makeConstraints:^(MASConstraintMaker *make){
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.left.equalTo(lb_creater.mas_right);
            make.top.equalTo(_lb_title.mas_bottom);
        }];

 
        [_lb_name  setFont:Font(14)];
        _lb_name.textColor = Color(@"1558FA");
        [_lb_name mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(_pic_head.mas_right).with.offset(5);
            make.height.mas_equalTo(21);
            make.centerY.equalTo(_pic_head);
            make.right.equalTo(_lb_relation.mas_left).with.offset(-5);
        }];
        
        [_lb_relation setBackgroundColor:Color(@"4EAF65")];
        [_lb_relation setTextColor:Color(@"FFFFFF")];
        [_lb_relation setFont:Font(13)];
        _lb_relation.layer.masksToBounds = YES;
        _lb_relation.layer.cornerRadius = 2;
        [_lb_relation setTextAlignment:NSTextAlignmentCenter];
        [_lb_relation mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(_lb_name.mas_right).with.offset(5);
            make.centerY.equalTo(_pic_head);
            make.height.mas_equalTo(21);
            make.width.mas_equalTo(42);
            
            
        }];
       
        [_lb_distance setFont:Font(12)];
        [_lb_distance setTextColor:Color(@"AAAAAA")];
        [_lb_distance setTextAlignment:NSTextAlignmentRight];
        [_lb_distance mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(_lb_title.mas_right);
            make.height.mas_equalTo(21);
            make.centerY.equalTo(_lb_title);
            make.right.equalTo(contentBord).with.offset(-8);
        }];
       
        
     
     
        [_pic_gather mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(lb_creater);
            make.top.equalTo(_pic_head.mas_bottom).with.offset(5);
            make.size.mas_equalTo(CGSizeMake(43, 43));
        }];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [_pic_head setBackgroundColor:[UIColor ColorWithHexString:@"7595f1"]];
     //   _lb_relation.hidden=YES;
        _pic_head.contentMode = UIViewContentModeScaleAspectFill;
        _pic_head.layer.masksToBounds=YES;
        _pic_head.layer.cornerRadius =14;
      
        UIImageView *IMG_LOCATION = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"location"]];
        [contentBord addSubview:IMG_LOCATION];
        [IMG_LOCATION mas_makeConstraints:^(MASConstraintMaker *make){
            make.size.mas_equalTo(CGSizeMake(10, 10));
            make.left.equalTo(_pic_gather.mas_right).with.offset(5);
            make.top.equalTo(_pic_gather).with.offset(5);
            
        }];
        UIImageView *img_time =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"time"]];
        [contentBord addSubview:img_time];
        [img_time mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(IMG_LOCATION);
            make.top.mas_equalTo(IMG_LOCATION.mas_bottom).with.offset(10);
            make.size.mas_equalTo(CGSizeMake(12, 11));
            
        }];
        
        _lb_location = [UILabel new];
        [_lb_location setFont:Font(14)];
        [contentBord addSubview:_lb_location];
        [_lb_location mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(IMG_LOCATION.mas_right).with.offset(5);
            make.centerY.equalTo(IMG_LOCATION);
            make.height.mas_equalTo(21);
            make.right.equalTo(contentBord);
        }];
        _lb_time = [UILabel new];
        [contentBord addSubview:_lb_time];
        [_lb_time setFont:Font(13)];
        [_lb_time mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(_lb_location);
            make.centerY.equalTo(img_time);
            make.right.equalTo(_lb_title);
            make.height.mas_equalTo(21);
        }];
        [self.contentView addSubview:self.lb_info];
       
        _lb_focus = [UILabel new];
        [_lb_focus setFont:Font(11)];
        [_lb_focus setTextColor:[UIColor darkGrayColor]];
        _lb_focus.textAlignment = NSTextAlignmentRight;
        [contentBord addSubview:_lb_focus];
        [_lb_focus mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.equalTo(_lb_distance);
            make.height.mas_equalTo(21);
            make.top.equalTo(_pic_gather.mas_bottom);
            make.width.mas_equalTo(80);
        }];
    }
    return self;

}//
-(void)removeJoinView
{
    for (UIView *view in self.contentView.subviews) {
        if (view.tag>99) {
            [view removeFromSuperview];
        }
    }
}
-(void)setData:(XHGather *)gather
{
    int xi=13;int w =5;int yi=130;
    for (int i=0; i<gather.joiner.count; i++) {
        UIImageView *hpic=[[UIImageView alloc] initWithFrame:CGRectMake(xi, yi, 18, 18)];
        hpic.layer.masksToBounds=YES;
        hpic.layer.cornerRadius=9;
        [hpic setBackgroundColor:[UIColor blueColor]];
        hpic.contentMode = UIViewContentModeScaleToFill;
        if ([[[gather.joiner objectAtIndex:i] objectForKey:@"user_pic"] isEqualToString:@""]) {
            [hpic setImageFromString:[[[gather.joiner objectAtIndex:i] objectForKey:@"user_realname"] substringToIndex:1] fontsize:14 paddintTop:0];
        }
        else
        {
            [hpic sd_setImageWithURL:[NSURL URLWithString:[NSString PicUrlString:[[gather.joiner objectAtIndex:i] objectForKey:@"user_pic"]]] placeholderImage:[UIImage imageNamed:@"head_deault"]];
        }
        xi=xi+w+18;
        hpic.tag=100+i;
        [self.contentView addSubview:hpic];
    }
    if (![gather.creater.userpic isEqualToString:@""]) {
        
        [_pic_head sd_setImageWithURL:[NSURL URLWithString:gather.creater.userpic] placeholderImage:[UIImage imageNamed:@"head_deault"]];
    }
    else
    {
        [_pic_head setImage:[UIImage imageFromString:[gather.creater.userRealName substringToIndex:1] size:_pic_head.bounds.size fontsize:16 top:5]];
        
    }
    _lb_location.text=gather.location;
    _lb_name.text=gather.createrName;
    _lb_time.text=gather.time;
    _lb_title.text=gather.title;
    _lb_focus.text=[NSString stringWithFormat:@"%lu人关注",(unsigned long)gather.focuserNum];
    if (gather.creater.uid ==[XHDefaultUser sharedUser].uid) {
           _lb_relation.text = @"我";
    }
    else
    _lb_relation.text = [NSString stringWithFormat:@"%d度",gather.creater.myfriend];
    _lb_distance.text=gather.distance;//[XHDefaultUser sharedUser].coordinate
    [_pic_gather sd_setImageWithURL:[NSURL URLWithString:gather.img]];
  
    
    if (gather.joiner.count==0) {
         _lb_info.text=[NSString stringWithFormat:@"还没有好友参加"];
    }
    else
    {
         _lb_info.text=[NSString stringWithFormat:@"等%lu位好友参加",(unsigned long)gather.joiner.count];
    }
    
   
     [_lb_info setFrame:CGRectMake(13+gather.joiner.count*(18+5), 130, 100, 20)];
}

-(UILabel *)lb_info
{
    if(!_lb_info)
    {
         _lb_info=[[UILabel alloc] init];
        [_lb_info setFont:[UIFont systemFontOfSize:12]];
        [_lb_info setTextColor:[UIColor darkGrayColor]];
    }
    return _lb_info;
}
@end
