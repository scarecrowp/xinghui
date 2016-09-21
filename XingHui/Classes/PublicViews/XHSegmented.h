//
//  XHSegmented.h
//  ;
//
//  Created by wangpei on 15/6/10.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XHSegmentedDelegate;
@interface XHSegmented : UIView
{
    UIView *bottom_line;
    NSUInteger btNum;
}
-(id)initWithTitle:(NSArray *)arr;
-(void)setSelectSeg:(NSInteger)index;
@property(nonatomic,weak)id<XHSegmentedDelegate> delegate;
@end

@protocol XHSegmentedDelegate <NSObject>

-(void)SegmentClickDelegateWithIndex:(NSInteger)index;

@end