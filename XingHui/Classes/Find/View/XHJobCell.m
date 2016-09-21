//
//  XHJobCell.m
//  XingHui
//
//  Created by gaoyuerui on 15/10/14.
//  Copyright © 2015年 wangpei. All rights reserved.
//

#import "XHJobCell.h"
#import "UILable+Category.h"
#import <UITableView+FDTemplateLayoutCell.h>
@interface XHJobCell()
@property(nonatomic,strong) UILabel *lb_note;
@property(nonatomic,strong) UILabel *lb_position;
@property(nonatomic,strong) UILabel *lb_comName;
@property(nonatomic,strong) UILabel *lb_time;
@end
@implementation XHJobCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *icon_same=[[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 24, 24)];
        UILabel *lb_same=[[UILabel alloc] initWithFrame:CGRectMake(icon_same.maxX+10, 5, 200, 24)];
        [lb_same setTextColor:[AciMath getColor:@"333333"]];

        [icon_same setImage:[UIImage imageNamed:@"icon_jobhistory@3x"]];
        lb_same.text=@"工作背景";
        [self addSubview:icon_same];
        [self addSubview:lb_same];
        [self addSubview:self.lb_comName];
        [self addSubview:self.lb_time];
        [self addSubview:self.lb_position];
        [self addSubview:self.lb_note];
        self.fd_enforceFrameLayout=YES;
    }
        return self;
}
-(void)setData:(NSDictionary *)dic
{

         
      
         
     self.lb_comName.text=[dic objectForKey:@"com_name"];
     self.lb_time.text=[NSString stringWithFormat:@"%@~%@",dic[@"begin_time"],dic[@"end_time"]];
 
    
    self.lb_position.text=dic[@"job_position"];
 
     [self.lb_note setText:dic[@"job_note"]];
     [self.lb_note setAutoHeight];
     [self setFrame:CGRectMake(0, 0, SCREEN_WIDTH, _lb_note.maxY)];
    
   
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(size.width, self.lb_note.maxY);
}
-(UILabel *)lb_note
{
    if (!_lb_note) {
          _lb_note=[[UILabel alloc] initWithFrame:CGRectMake(15, 59+25, SCREEN_WIDTH, 0)];
        [_lb_note setFont:Font(14)];
        [_lb_note setTextColor:Color(@"808080")];
    }
    return _lb_note;
}
-(UILabel *)lb_position
{
    if (!_lb_position) {
        _lb_position=[[UILabel alloc] initWithFrame:CGRectMake(15,59, SCREEN_WIDTH, 25)];
      
        [_lb_position setFont:Font(14)];
        [_lb_position setTextColor:Color(@"808080")];

    }
    return _lb_position;
}
-(UILabel *)lb_comName
{
    if (!_lb_comName) {
        _lb_comName=[[UILabel alloc] initWithFrame:CGRectMake(15, 29, SCREEN_WIDTH-100, 30)];
        [_lb_comName setTextColor:[AciMath getColor:@"2ebe00"]];
    }
    return _lb_comName;
}
-(UILabel *)lb_time
{
    if (!_lb_time) {
        _lb_time=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-120,29, 100, 30)];
      
        _lb_time.textAlignment=NSTextAlignmentRight;
        [_lb_time setTextColor:Color(@"c5c5c5")];
        [_lb_time setFont:Font(14)];

    }
    return _lb_time;
}
@end
