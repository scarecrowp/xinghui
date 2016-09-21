//
//  XHSetPicViewController.h
//  XingHui
//
//  Created by wangpei on 15/8/8.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "BasicViewController.h"

@interface XHSetPicViewController : BasicViewController
-(void)didfinishSetImg:(UIImage *)img;
- (void)selectPicMode:(id)sender;
-(void)selectSheet:(UIActionSheet *)sheet index:(NSInteger)index;
@end
//@protocol SheetActionDelegate <NSObject>
//
//-(void)selectSheet:(UIActionSheet *)sheet index:(NSInteger)index;
//-(void)didfinishSetImg:(UIImage *)image;
//@end