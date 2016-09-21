//
//  XHDataSourceArray.h
//  XingHui
//
//  Created by gaoyuerui on 15/11/30.
//  Copyright © 2015年 wangpei. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^TableViewCellConfigureBlock)(id cell, id item);
@interface XHDataSourceArray : NSObject<UITableViewDataSource>
- (id)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
 configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;
@end
