//
//  PassValueDelegate.h
//  QiaoGu
//
//  Created by JackLiu on 14-8-21.
//  Copyright (c) 2014年 ZXInsight. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PassValueDelegate <NSObject>

@optional

- (void)passbackObject:(id)object sender:(NSString *)sender;
@end

