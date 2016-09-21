//
//  XHCreateStudy.h
//  XingHui
//
//  Created by gaoyuerui on 15/10/19.
//  Copyright © 2015年 wangpei. All rights reserved.
//

#import "BasicViewController.h"

@interface XHCreateStudyVC : BasicViewController<UIActionSheetDelegate,PassValueDelegate>

@property(nonatomic,strong)id<PassValueDelegate>passdelegate;
@end
