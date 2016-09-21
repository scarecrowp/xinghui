//
//  XHFriendViewController.h
//  XingHui
//
//  Created by gaoyuerui on 15/9/17.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    kFirstFriend=1,
    kSecondFriend,
    kNearFriend,
    kInvitationFriend
} kFriendType;
@interface XHFriendViewController : BasicViewController
@property(nonatomic,strong) UITableView *tableview;
@property(nonatomic,strong) NSMutableArray *friendArr;
@property int friendType;
@property int VcType;
-(void)tableReload;
@end

