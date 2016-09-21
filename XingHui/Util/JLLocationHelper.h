//
//  JLLocationHelper.h
//  QiaoGu
//
//  Created by JackLiu on 14-9-1.
//  Copyright (c) 2014年 ZXInsight. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JLLocationHelperDelegate;

@interface JLLocationHelper : NSObject

@property (nonatomic,strong)id<JLLocationHelperDelegate>delegate;

- (void)startLacation;
- (void)stop;
@end

@protocol JLLocationHelperDelegate <NSObject>

@required

- (void)didUpdateToLocation:(NSDictionary *)addressDictionary;
- (void)updateLocationFailWithError:(NSError *)error;

@end