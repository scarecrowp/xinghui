//
//  XHStudyCell.m
//  XingHui
//
//  Created by gaoyuerui on 15/10/19.
//  Copyright © 2015年 wangpei. All rights reserved.
//

#import "XHStudyCell.h"
 
@implementation XHStudyCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:@"jobcell"];
    if (self) {
        
        [self addSubview:self.lb_title];
        
        
        [self addSubview:self.lb_time];
        [self addSubview:self.lb_postion];
        WS(ws);
        
        [self.lb_time mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(_lb_postion.mas_right);
            make.centerY.equalTo(_lb_title);
            make.right.equalTo(ws.mas_right).with.offset(-40);
            
        }];
        [self.lb_title mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(ws.mas_left).with.offset(10);
            make.top.equalTo(ws.mas_top);
            make.bottom.equalTo(ws.mas_bottom);
            make.right.equalTo(_lb_postion.mas_left).with.offset(-10);
            
            
        }];
        
        [self.lb_postion mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(_lb_title.mas_right).with.offset(10);
            make.centerY.equalTo(_lb_title);
            make.right.equalTo(ws.lb_time.mas_left);
            
        }];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    return self;
}
-(void)SETStudyData:(NSDictionary *)jobDic
{
    self.lb_title.text = jobDic[@"school_name"];
    self.lb_time.text=[NSString stringWithFormat:@"%@ ~ %@",jobDic[@"begin_year"],jobDic[@"end_year"]];
    self.lb_postion.text =jobDic[@"major"]; 
}
-(UILabel *)lb_title
{
    if (!_lb_title) {
        _lb_title=[[UILabel alloc] init];
        [_lb_title setFont:Bold(16)];
        [_lb_title setTextColor:Color(@"3c3c3c")];
    }
    return _lb_title;
}
-(UILabel *)lb_time
{
    if (!_lb_time) {
        _lb_time = [[UILabel alloc] init];
        [_lb_time setFont:Font(12)];
        [_lb_time setTextColor:Color(@"a0a0a0")];
    }
    return _lb_time;
}
-(UILabel *)lb_postion
{
    if (!_lb_postion) {
        _lb_postion = [UILabel new];
        [_lb_postion setFont:Font(14)];
        [_lb_postion setTextColor:Color(@"3c3c3c")];
    }
    return _lb_postion;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
