//
//  XHTagView.h
//  ;
//
//  Created by wangpei on 15/8/31.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TagViewDelegate;
@interface XHTagView : UIView
@property(nonatomic,weak)id<TagViewDelegate>delegate;
-(instancetype)initWithArr:(NSMutableArray *)arr;
-(float)setTagArr:(NSArray *)arr;
@end
@interface TagView : UIView
@property(nonatomic,strong) UIImageView *bg;
@property(nonatomic,strong) UILabel *lb_tag;
@property(nonatomic,strong) UILabel *lb_num;
-(instancetype)initWithdata:(NSDictionary *)dic;
@end
@protocol TagViewDelegate <NSObject>

-(void)Addtag:(NSString *)tagStr;
-(void)removeTag:(NSString *)tagStr;
@end