//
//  XHGatherLocationCell.m
//  XingHui
//
//  Created by gaoyuerui on 15/11/24.
//  Copyright © 2015年 wangpei. All rights reserved.
//

#import "XHGatherLocationCell.h"
#import "XHGather.h"
@implementation XHGatherLocationCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *img_name =[UIImageView new];
        [img_name setImage:[UIImage imageNamed:@"icon_home_1@3x.png"]];
        UIImageView *img_location = [UIImageView new];
        [img_location setImage:[UIImage imageNamed:@"icon_location.png"]];
        UIImageView *img_time =[UIImageView new];
        [img_time setImage:[UIImage imageNamed:@"icon_clock.png"]];
        [self addSubview:img_name];
        [self addSubview:img_location];
        [self addSubview:img_time];
        
        
        [img_name mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(17);
            make.top.mas_equalTo(5);
            make.size.mas_equalTo(CGSizeMake(10, 9));
        }];
        [img_location mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(17);
            make.top.equalTo(img_name.mas_bottom).with.offset(6);
            make.size.mas_equalTo(CGSizeMake(9, 11));
        }];
        [img_time mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(17);
            make.top.equalTo(img_location.mas_bottom).with.offset(6);
            make.size.mas_equalTo(CGSizeMake(11, 11));
        }];
        
        _lb_name =[UILabel new];
        _lb_location = [UILabel new];
        _lb_time = [UILabel new];
        [_lb_name setFont:Font(12)];
         [_lb_location setFont:Font(12)];
         [_lb_time setFont:Font(12)];
        [self addSubview:_lb_name];
        [self addSubview:_lb_location];
        [self addSubview:_lb_time];
        
        [_lb_location addTarget:self action:@selector(locationMap)];
        
        [_lb_name mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(img_name.mas_right).with.offset(5);
            make.centerY.equalTo(img_name);
            make.height.mas_equalTo(21);
            make.right.equalTo(self);
          
        }];
        [_lb_location mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(img_name.mas_right).with.offset(5);
          make.centerY.equalTo(img_location);
            make.height.mas_equalTo(21);
            make.right.equalTo(self);
        }];
        [_lb_time mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(img_name.mas_right).with.offset(5);
            make.centerY.equalTo(img_time);
            make.height.mas_equalTo(21);
            make.right.equalTo(self);
        }];
        
    }
    return self;

}
-(void)locationMap
{
    [_delegate ToLocationMap];
}
-(void)setData:(XHGather *)gather
{
    _lb_name.text = gather.title;
    _lb_location.text = gather.place;
    _lb_time.text = gather.time;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
