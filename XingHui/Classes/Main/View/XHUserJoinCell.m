//
//  XHUserJoinCell.m
//  XingHui
//
//  Created by wangpei on 15/6/10.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHUserJoinCell.h"
#import "XHOtherUser.h"
#import "UIImage+Category.h"
#import "UIView+Category.h"
#import "XHPersonDetailViewController.h"
@implementation XHUserJoinCell

- (void)awakeFromNib {
    // Initialization code
    
}
-(id)initWithGather:(NSDictionary *)user
{
    self=[[[NSBundle mainBundle] loadNibNamed:@"XHUserJoinCell" owner:nil options:nil] objectAtIndex:0];
    
    if (self) {
        self.user =[[XHUser alloc] initWithDic:user];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        _img_head.layer.masksToBounds=YES;
        _img_head.userInteractionEnabled=YES;
        [_img_head addTarget:self action:@selector(toUserInfo)];
        _img_head.layer.cornerRadius =19;
        _lb_ralation.layer.masksToBounds=YES;
        _lb_ralation.layer.cornerRadius=2;
        
        _lb_ralation.text=[NSString stringWithFormat:@"%d度",self.user.myfriend];
        if ([[user[@"user_pic"] ToString] isEqualToString:@""]) {
      
            [_img_head setImage:[UIImage imageFromString:[user[@"user_realname"] substringToIndex:1] size:_img_head.frame.size]];
             [_img_head setBackgroundColor:[AciMath getColor:@"7595f1"]];
        }
        else
        {
            [_img_head sd_setImageWithURL:[NSURL URLWithString:[NSString PicUrlString:user[@"user_pic"]]]];
        }
        _lb_name.text=user[@"user_realname"];
        _job.text=[NSString stringWithFormat:@"%@ %@",user[@"user_company"],user[@"user_job"]];
        
        if (self.user.myfriend==1) {
            [_bt_action setImage:[UIImage imageNamed:@"bt_chat"] forState:UIControlStateNormal];
            _bt_action.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 10);
            [_bt_action setTitle:@"" forState:UIControlStateNormal];
            [_bt_action addTarget:self action:@selector(chat) forControlEvents:UIControlEventTouchUpInside];
        }
        else if(self.user.uid != [XHDefaultUser sharedUser].uid)
        {
            [_bt_action addTarget:self action:@selector(addFriend:) forControlEvents:UIControlEventTouchUpInside];
            [_bt_action setTitle:@"+" forState:UIControlStateNormal];
        }
    }
    return self;
}

-(void)chat
{
    [_delegate ChatWithUser:self.user];
}
-(void)toUserInfo
{
    [self.delegate ToUserDetail:self.user];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)addFriend:(id)sender {
 
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
//                                                        message:NSLocalizedString(@"saySomething", @"say somthing")
//                                                       delegate:self
//                                              cancelButtonTitle:NSLocalizedString(@"cancel", @"Cancel")
//                                              otherButtonTitles:NSLocalizedString(@"ok", @"OK"), nil];
//        [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
//        [alert show];
    [self.delegate addFriend:self.user.username realName:self.user.userRealName];
        //    [[XHNetWork sharedNetWork] Get:[NSString APIURLString:@"addFriend.ashx"] param:@{@"fid":user.uid} complete:^(NSDictionary *dic){
        //
        //    }];
    

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([alertView cancelButtonIndex] != buttonIndex) {
        UITextField *messageTextField = [alertView textFieldAtIndex:0];
        
        NSString *messageStr = @"";
        NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
        NSString *username = [loginInfo objectForKey:kSDKUsername];
        if (messageTextField.text.length > 0) {
            messageStr = [NSString stringWithFormat:@"%@：%@", username, messageTextField.text];
        }
        else{
            messageStr = [NSString stringWithFormat:NSLocalizedString(@"friend.somebodyInvite", @"%@ invite you as a friend"), username];
        }
 
        [self sendFriendApplyAtIndexPath:self.user.username
                                 message:self.user.userRealName];
    }
}

- (void)sendFriendApplyAtIndexPath:(NSString *)username
                           message:(NSString *)message
{
    [_delegate addFriend:username realName:message];
}


@end
