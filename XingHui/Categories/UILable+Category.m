//
//  UILable+Category.m
//  QiaoGuShop
//
//  Created by wangpei on 15/6/3.
//  Copyright (c) 2015年 QiaoGu. All rights reserved.
//

#import "UILable+Category.h"

@implementation UILabel(Category)
-(float)widthWithTitle
{
    CGFloat width1=[(NSString *)self.text boundingRectWithSize:CGSizeMake(1000, 21) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size.width;
    return width1;
}
-(void)setLineHight:(float)hei
{
    NSString *labelText =self.text;
    
    [self setNumberOfLines:0];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:hei];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
    [self sizeToFit];
}
-(float)setAutoHeight
{
    self.lineBreakMode =UILineBreakModeWordWrap;
    self.numberOfLines =0;
    CGRect txtFrame=self.frame;
    txtFrame.size.height=[self.text boundingRectWithSize: CGSizeMake(txtFrame.size.width, CGFLOAT_MAX)
                                                  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                              attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.font,NSFontAttributeName, nil] context:nil].size.height;
    self.frame=txtFrame;
    return  txtFrame.size.height;
}
@end
