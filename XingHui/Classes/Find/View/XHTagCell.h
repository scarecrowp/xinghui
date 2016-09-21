//
//  XHTagCell.h
//  XingHui
//
//  Created by gaoyuerui on 15/10/14.
//  Copyright © 2015年 wangpei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TagCellDelegate;
@class XHTagView;
@interface XHTagCell : UITableViewCell
{
    
}
@property(nonatomic,strong)id<TagCellDelegate>delegate;
@property(nonatomic,strong)  XHTagView *tagview;
 
@property CGFloat height;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier tagArr:(NSMutableArray *)tagArr;
@end
@protocol TagCellDelegate <NSObject>

-(void)addNewtag;

@end