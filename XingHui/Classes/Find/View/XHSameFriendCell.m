//
//  XHPersonCell.m
//  XingHui
//
//  Created by gaoyuerui on 15/10/14.
//  Copyright © 2015年 wangpei. All rights reserved.
//

#import "XHSameFriendCell.h"
#import <UITableView+FDTemplateLayoutCell.h>

@interface XHSameFriendCell()
@property(nonatomic,strong)UILabel *lb_commenFriend;
@end
@implementation XHSameFriendCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *icon_same=[[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 24, 24)];
        UILabel *lb_same=[[UILabel alloc] initWithFrame:CGRectMake(icon_same.maxX+10, 5, 200, 24)];
        [lb_same setTextColor:[AciMath getColor:@"333333"]];

 
        UIView *view_sname_sub=[[UIView alloc] initWithFrame:CGRectMake(0, 1, SCREEN_WIDTH, 40)];
        [view_sname_sub setBackgroundColor:[UIColor whiteColor]];
        
        
        [icon_same setImage:[UIImage imageNamed:@"icon_same_friend@3x"]];
        [view_sname_sub addSubview:icon_same];
        WS(ws);
        lb_same.text=@"共同好友";
        
        [view_sname_sub addSubview:lb_same];
        [view_sname_sub addSubview:self.lb_commenFriend];//266
        
        [self addSubview:view_sname_sub];
        
        [view_sname_sub mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(ws);
            make.top.equalTo(ws);
            make.right.equalTo(ws);
            make.height.mas_equalTo(42);
        }];
        
        [icon_same mas_makeConstraints:^(MASConstraintMaker *make){
            make.size.mas_equalTo(CGSizeMake(24, 24));
            make.left.equalTo(ws.mas_left).with.offset(10);
            make.centerY.equalTo(view_sname_sub);
        }];
        
        [lb_same mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(icon_same.mas_right).with.offset(10);
            make.centerY.equalTo(icon_same);
            make.size.mas_equalTo(CGSizeMake(100, 40));
        }];
        [_lb_commenFriend mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(lb_same.mas_right);
            make.centerY.equalTo(icon_same);
            make.right.equalTo(view_sname_sub.mas_right).with.offset(-40);
            make.height.mas_equalTo(40);
        }];
        self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        self.fd_enforceFrameLayout=YES;
    }
    return self;
}
-(void)setData:(NSMutableArray *)friendArr
{
      NSString *sameFriend=@"无共同好友";
    if(friendArr.count>0)
    {
        if (friendArr.count>1) {
            sameFriend=[NSString stringWithFormat:@"%@,%@等%lu位共同好友",friendArr[0][@"user_realname"],friendArr[1][@"user_realname"],(unsigned long)friendArr.count];
        }
        else
        {
            sameFriend=friendArr[0][@"user_realname"];
        }
    }
    
    _lb_commenFriend.text=sameFriend;

}
-(UILabel *)lb_commenFriend
{
    if (!_lb_commenFriend) {
        _lb_commenFriend=[[UILabel alloc] init];
        _lb_commenFriend.textAlignment=NSTextAlignmentRight;
        [_lb_commenFriend setFont:Font(14)];
        [_lb_commenFriend setTextColor:Color(@"787878")];

    }
   
    return _lb_commenFriend;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(size.width, 42);
}

@end
