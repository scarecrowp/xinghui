//
//  XHAddFriendVC.m
//  XingHui
//
//  Created by gaoyuerui on 15/10/22.
//  Copyright © 2015年 wangpei. All rights reserved.
//

#import "XHAddFriendVC.h"
#import "UIPlaceHolderTextView.h"
#import "SSCheckBoxView.h"
@interface XHAddFriendVC ()
{
    UIPlaceHolderTextView *tb_note;
}
@property (nonatomic, strong) NSMutableArray *checkboxes;

@end
@implementation XHAddFriendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"添加好友"];
    [self.view setBackgroundColor:Color(@"f3f3f3")];
    UIView *view_main =[[UIView alloc] init];
    [self.view addSubview:view_main];
    WS(ws);
    [view_main mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.right.bottom.equalTo(ws.view);
        
        make.top.equalTo(ws.view).with.offset(10);
    }];
    UILabel *lb_1 =[UILabel new];
   
    tb_note = [[UIPlaceHolderTextView alloc] init];
    tb_note.placeholder=@"简要说明";
    tb_note.inputAccessoryView =[AciMath getKeybordToolbar:self action:@selector(hideKayBoard)];
    UILabel *lb_2 = [[UILabel alloc] init];
    [view_main addSubview:lb_1];
    [view_main addSubview:tb_note];
    [view_main addSubview:lb_2];
    lb_1.textColor = Color(@"2bb300");
    [lb_1 setFont:Font(16)];
 
    lb_1.text = [NSString stringWithFormat:@"你希望添加［%@］为好友，简要介绍下自己吧～～",self.userRealname];
    lb_2.textColor = Color(@"2bb300");
    [lb_2 setFont:Font(16)];
    lb_2.text = [NSString stringWithFormat:@"找出你们的共同点，他更容易接受哦："];
     lb_1.numberOfLines = 0;
     lb_1.lineBreakMode = NSLineBreakByTruncatingTail;
    [lb_1 mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.top.equalTo(view_main).with.offset(10);
        make.right.equalTo(view_main).with.offset(-10);
        make.height.greaterThanOrEqualTo(lb_2);
        make.bottom.equalTo(tb_note.mas_top).with.offset(-10);
    }];
    [tb_note mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(lb_1.mas_bottom).with.offset(10);
        make.left.equalTo(lb_1);
        make.right.equalTo(lb_1);
        make.height.mas_equalTo(100);
    }];
    [lb_2 mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(lb_1);
        make.top.equalTo(tb_note.mas_bottom).with.offset(10);
        make.height.mas_equalTo(30);
        make.right.equalTo(lb_1);
    }];
 
    NSArray *arr = @[@"我们有很多共同的好友",@"我们参加了很多相同的活动",@"我们在同一座城市的同一场活动上",@"我们关注共同的话题和资讯"];
    self.checkboxes = [[NSMutableArray alloc] init];
    SSCheckBoxView *cbv = nil;
    CGRect frame = CGRectMake(20, 20, 240, 30);
    for (int i = 0; i < arr.count; ++i) {
      
        cbv = [[SSCheckBoxView alloc] initWithFrame:frame
                                              style:kSSCheckBoxViewStyleGlossy
                                            checked:NO];
         [view_main addSubview:cbv];
        [cbv mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.right.equalTo(view_main).with.offset(15);
            make.size.mas_equalTo(CGSizeMake(240, 30));
            make.top.equalTo(lb_2.mas_bottom).with.offset(36*i);
        }];
        [cbv setText:arr[i]];
        
        [self.checkboxes addObject:cbv];
        [cbv setStateChangedTarget:self
                          selector:@selector(checkBoxViewChangedState:)];
        frame.origin.y += 36;
    }
    
    UIButton *bt = [[UIButton alloc] init];
    [bt setBackgroundColor:Color(@"2ebe00")];
    [bt setTitle:@"提交" forState:UIControlStateNormal];
    [bt.titleLabel setFont:Font(18)];
    [bt setTitleColor:Color(@"ffffff") forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(ApplyFriend) forControlEvents:UIControlEventTouchUpInside];
 
    [view_main addSubview:bt];
    [bt mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(lb_1);
        make.right.equalTo(lb_1);
        make.bottom.equalTo(view_main.mas_bottom).offset(-10);
        make.height.mas_equalTo(45);
    }];
    // Do any additional setup after loading the view.
}
-(void)ApplyFriend
{
    NSString *buddyName =self.username;
    if (buddyName && buddyName.length > 0) {
        [self showHudInView:self.view hint:NSLocalizedString(@"friend.sendApply", @"sending application...")];
         EMError *error;
        [[EaseMob sharedInstance].chatManager addBuddy:buddyName message:tb_note.text error:&error];
        
        [self hideHud];
        if (error) {
            [self showHint:NSLocalizedString(@"friend.sendApplyFail", @"send application fails, please operate again")];
            
        }
        else{
            [self showHint:NSLocalizedString(@"friend.sendApplySuccess", @"send successfully")];
           
            [self performSelector:@selector(hideDelayed) withObject:nil afterDelay:2.0];
        }
    }
}
-(void)hideDelayed
{
      [self.navigationController popViewControllerAnimated:YES];
}
- (void) checkBoxViewChangedState:(SSCheckBoxView *)cbv
{
    NSLog(@"checkBoxViewChangedState: %d", cbv.checked);
//    [UIHelpers showAlertWithTitle:@"CheckBox State Changed"
//                              msg:[NSString stringWithFormat:@"checkBoxView state: %d", cbv.checked]];
    // cbv.enabled = !cbv.enabled;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
