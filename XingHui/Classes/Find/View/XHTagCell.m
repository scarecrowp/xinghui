//
//  XHTagCell.m
//  XingHui
//
//  Created by gaoyuerui on 15/10/14.
//  Copyright © 2015年 wangpei. All rights reserved.
//

#import "XHTagCell.h"
#import "XHTagView.h"
#import <UITableView+FDTemplateLayoutCell.h>
@interface XHTagCell()


@end
@implementation XHTagCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)init
{
    self =[super init];
    if (self) {
        
        UIImageView *icon_same=[[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 24, 24)];
        UILabel *lb_same=[[UILabel alloc] initWithFrame:CGRectMake(icon_same.maxX+10, 5, 200, 24)];
        [lb_same setTextColor:[AciMath getColor:@"333333"]];
        [icon_same setImage:[UIImage imageNamed:@"icon_tag@3x"]];
        lb_same.text=@"他的标签";
        [self addSubview:icon_same];
        [self addSubview:lb_same];
        
        
        
        UIButton *bt_addTag=[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-120, 5, 100, 25)];
        [bt_addTag setTitle:@"给他添加标签" forState:UIControlStateNormal];
        [bt_addTag setTitleColor:[AciMath getColor:@"16bf00"] forState:UIControlStateNormal];
        [bt_addTag addTarget:self action:@selector(addtag) forControlEvents:UIControlEventTouchUpInside];
        [bt_addTag.titleLabel setFont:Font(16)];
        
        
        [self addSubview:bt_addTag];
        
        [self addSubview:self.tagview];
        
        
        
        self.fd_enforceFrameLayout=YES;
    }
    return self;

}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier tagArr:(NSMutableArray *)tagArr

{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *icon_same=[[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 24, 24)];
        UILabel *lb_same=[[UILabel alloc] initWithFrame:CGRectMake(icon_same.maxX+10, 5, 200, 24)];
        [lb_same setTextColor:[AciMath getColor:@"333333"]];
        [icon_same setImage:[UIImage imageNamed:@"icon_tag@3x"]];
        lb_same.text=@"他的标签";
        [self addSubview:icon_same];
        [self addSubview:lb_same];
        UIButton *bt_addTag=[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-120, 5, 100, 25)];
        [bt_addTag setTitle:@"给他添加标签" forState:UIControlStateNormal];
        [bt_addTag setTitleColor:[AciMath getColor:@"16bf00"] forState:UIControlStateNormal];
        [bt_addTag addTarget:self action:@selector(addtag) forControlEvents:UIControlEventTouchUpInside];
        [bt_addTag.titleLabel setFont:Font(16)];
     
        
        [self addSubview:bt_addTag];
        
        [self addSubview:self.tagview];
        
        _height =[self.tagview setTagArr:tagArr];
        [self setFrame:CGRectMake(0, 0, SCREEN_WIDTH, _height+40)];
    }
    return self;
}
-(void)addtag
{
    [_delegate addNewtag];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(XHTagView *)tagview
{
    if (!_tagview) {
        _tagview=[[XHTagView alloc] initWithArr:nil];
    }
    return _tagview;
}
- (CGSize)sizeThatFits:(CGSize)size {
 
    return CGSizeMake(size.width, 40+[self.tagview sizeThatFits:size].height);
}

@end
