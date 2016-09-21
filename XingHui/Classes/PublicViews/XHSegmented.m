//
//  XHSegmented.m
//  XingHui
//
//  Created by wangpei on 15/6/10.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHSegmented.h"

@implementation XHSegmented
-(id)initWithTitle:(NSArray *)arr
{
    int height=40;
    self =[super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
    if (self) {
        [self setBackgroundColor:[UIColor ColorWithHexString:@"d7d7d7"]];
        btNum=arr.count;
        float btwidth=SCREEN_WIDTH/btNum-btNum+2;
        for (int i=0; i<arr.count; i++) {
            UIButton *bt =[UIButton buttonWithType:UIButtonTypeCustom];
            [bt setTitle:[arr objectAtIndex:i] forState:UIControlStateNormal];
            [bt setFrame:CGRectMake(i*SCREEN_WIDTH/btNum, 1, btwidth, height-2)];
            bt.tag=i;
            [bt setTitleColor:[UIColor ColorWithHexString:@"363636"] forState:UIControlStateNormal];
            [bt setBackgroundColor:[UIColor whiteColor]];
            [bt addTarget:self action:@selector(BottonClickEvent:) forControlEvents:UIControlEventTouchUpInside];
            [bt.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [self addSubview:bt];
        }
        
        bottom_line =[[UIView alloc] initWithFrame:CGRectMake(0, height-2, btwidth, 2)];
        [bottom_line setBackgroundColor:[UIColor ColorWithHexString:@"19b200"]];
        [self addSubview:bottom_line];
    }
    return self;
}
-(void)BottonClickEvent:(id)sender
{
    UIButton *bt =(UIButton *)sender;
    [UIView beginAnimations:nil context:nil];//动画开始
    [UIView setAnimationDuration:0.1];
    CGRect rect=bottom_line.frame;
    rect.origin.x=bt.frame.origin.x;
    bottom_line.frame = rect;
    [UIView commitAnimations];

    [_delegate SegmentClickDelegateWithIndex:bt.tag];
}
-(void)setSelectSeg:(NSInteger)index
{
 
    [UIView beginAnimations:nil context:nil];//动画开始
    [UIView setAnimationDuration:0.1];
    CGRect rect=bottom_line.frame;
    rect.origin.x=index*SCREEN_WIDTH/btNum;
    bottom_line.frame = rect;
    [UIView commitAnimations];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
