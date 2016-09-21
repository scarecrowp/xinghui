//
//  MyCustomTableViewCell.m
//  XingHui
//
//  Created by wangpei on 15/8/25.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "MyCustomTableViewCell.h"
#define  separatorViewTag  10456
@implementation MyCustomTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setSeparatorWithInset:(UIEdgeInsets)insets{
    
    if (customSeparatorView) {
        customSeparatorView.frame = CGRectMake(insets.left, insets.top,self.frame.size.width - insets.left - insets.right, self.originSeparatorView.height-insets.bottom - insets.top);
        self.originSeparatorView.hidden = YES;
        self.originSeparatorView.alpha = 0;
    }else{
        for (int i = ([self.contentView.superview.subviews count] - 1); i >= 0; i--) {
            UIView *subView = self.contentView.superview.subviews[i];
            if ([NSStringFromClass(subView.class) hasSuffix:@"SeparatorView"]) {
                self.originSeparatorView = subView;
                subView.hidden = YES;
                subView.alpha = 0;
                subView.frame = CGRectMake(insets.left, insets.top,self.frame.size.width - insets.left - insets.right, subView.height-insets.bottom - insets.top);
                
                customSeparatorView = [[subView superview] viewWithTag:separatorViewTag];
                if (!customSeparatorView) {
                    customSeparatorView = [[UIView alloc] initWithFrame:subView.frame];
                    
                    customSeparatorView.tag = separatorViewTag;
                    [[subView superview] addSubview:customSeparatorView];
                    customSeparatorView.backgroundColor = [subView backgroundColor];
                }
                [[subView superview] bringSubviewToFront:customSeparatorView];
                break;
            }
        }
    }
}


-(void)setSeparatorColorWithColor:(UIColor *)sepColor{
    if (customSeparatorView) {
        customSeparatorView.backgroundColor = sepColor;
        
        self.originSeparatorView.hidden = YES;
        self.originSeparatorView.alpha = 0;
    }else {
        for (int i = ([self.contentView.superview.subviews count] - 1); i >= 0; i--) {
            UIView *subView = self.contentView.superview.subviews[i];
            if ([NSStringFromClass(subView.class) hasSuffix:@"SeparatorView"]) {
                self.originSeparatorView = subView;
                
                if (sepColor) {
                    subView.hidden = YES;
                    subView.alpha = 0;
                    subView.backgroundColor = sepColor;
                    
                    customSeparatorView = [[subView superview] viewWithTag:separatorViewTag];
                    if (!customSeparatorView) {
                        customSeparatorView = [[UIView alloc] initWithFrame:subView.frame];
                        
                        customSeparatorView.tag = separatorViewTag;
                        [[subView superview] addSubview:customSeparatorView];
                        customSeparatorView.backgroundColor = [subView backgroundColor];
                    }
                    [[subView superview] bringSubviewToFront:customSeparatorView];
                }
                break;
            }
        }
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self setSeparatorWithInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self setSeparatorColorWithColor:[UIColor colorWithRed:31/255.0 green:32/255.0f blue:35/255.0 alpha:0.2]];
}
@end
