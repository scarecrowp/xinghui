//
//  GatherDetailBottom.m
//  XingHui
//
//  Created by wangpei on 15/8/18.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "GatherDetailBottom.h"
@interface GatherDetailBottom()
{
   
}
@property(nonatomic,strong) UIButton *bt_coment;
@property(nonatomic,strong) UIButton *bt_join;
@property(nonatomic,strong) UIButton *bt_focus;
@end
@implementation GatherDetailBottom
-(instancetype)init
{
    self=[super initWithFrame:CGRectMake(0, SCREEN_HEIGHT-43-64, SCREEN_WIDTH, 43)];
    [self setBackgroundColor:[AciMath getColor:@"f2f2f2"]];
    [self addSubview:self.bt_coment];
    [self addSubview:self.bt_focus];
    [self addSubview:self.bt_join];
   
    return self;
}
-(void)setJoinStatus:(BOOL)isJoin isFocus:(BOOL)isFocus
{
    self.isFocus =isFocus;
    self.isJoin = isJoin;
    if (isJoin) {
    
        [self setHasJoin:isJoin];
    }
    if(isFocus)
    {
        [self setHasFocus:isFocus];
    }
}
-(UIButton *)bt_coment
{
    if (!_bt_coment) {
        _bt_coment=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 43)];
        [_bt_coment setImage:[UIImage imageNamed:@"bt_comment"] forState:UIControlStateNormal];
 
        [_bt_coment setTitle:@"评论" forState:UIControlStateNormal];
        _bt_coment.titleEdgeInsets=UIEdgeInsetsMake(0, 20, 0, 0);
        [_bt_coment setTitleColor:[AciMath getColor:@"487ef2"] forState:UIControlStateNormal];
        [_bt_coment addTarget:self action:@selector(comment) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bt_coment;
}
-(UIButton *)bt_join
{
    if (!_bt_join) {//222.102
        _bt_join = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-180, 3, 80, 34)];
        [_bt_join setImage:[UIImage imageNamed:@"detail_icon_focus"] forState:UIControlStateNormal];
               [_bt_join.titleLabel setFont:Font(15)];
        [self setHasJoin:NO];
        [_bt_join addTarget:self action:@selector(join) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bt_join;
}
-(UIButton *)bt_focus
{
    if (!_bt_focus) {
        _bt_focus = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-84, 3, 80, 34)];
        [_bt_focus setImage:[UIImage imageNamed:@"detail_icon_join"] forState:UIControlStateNormal];
        [self setHasFocus:NO];
        [_bt_focus.titleLabel setFont:Font(15)];
        [_bt_focus addTarget:self action:@selector(focus) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bt_focus;

}
-(void)comment
{
    [_delegate didcomment];
}
-(void)setHasFocus:(BOOL)isfocus
{
    self.isFocus = isfocus;
    if (isfocus) {
         [_bt_focus setTitle:@"已关注" forState:UIControlStateNormal];
        [_bt_focus setBackgroundImage:[UIImage imageNamed:@"bt_red_bg_en@3x"] forState:UIControlStateNormal];
          _bt_focus.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 30);
    }
     else
     {
          [_bt_focus setTitle:@"关注" forState:UIControlStateNormal];
         [_bt_focus setBackgroundImage:[AciMath getScImage:@"bt_red_bg@3x" top:6 bottom:6 left:6 right:6] forState:UIControlStateNormal];
          _bt_focus.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 10);

     }
   
}
-(void)setHasJoin:(BOOL)isJoin
{
    self.isJoin = isJoin;
    if (isJoin) {
     
        [_bt_join setTitle:@"已报名" forState:UIControlStateNormal];
        _bt_join.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 32);
        [_bt_join setBackgroundImage:[UIImage imageNamed:@"bt_red_bg_en@3x"] forState:UIControlStateNormal];

    }
    else
    {
        _bt_join.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 10);
        [_bt_join setTitle:@"报名" forState:UIControlStateNormal];
        [_bt_join setBackgroundImage:[AciMath getScImage:@"bt_green_bg@3x" top:6 bottom:6 left:6 right:6] forState:UIControlStateNormal];

    }
}
-(void)focus
{
    [self setHasFocus:!self.isFocus];
    [_delegate didfocus];
}
-(void)join
{
    [self setHasJoin:!self.isJoin];
    [_delegate didJoin];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
