//
//  XHApplyStatusVC.m
//  XingHui
//
//  Created by gaoyuerui on 15/10/21.
//  Copyright © 2015年 wangpei. All rights reserved.
//

#import "XHApplyStatusVC.h"

@interface XHApplyStatusVC ()

@end

@implementation XHApplyStatusVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:Color(@"f3f3f3")];
    UIView *view_status = [[UIView alloc] init];
    [self.view addSubview:view_status];
    UIImageView *img_apply_bg = [[UIImageView alloc] init];
    [view_status addSubview:img_apply_bg];
    img_apply_bg.image=[UIImage imageNamed:@"apply_status_bg"];
    img_apply_bg.contentMode = UIViewContentModeCenter;
    [view_status mas_makeConstraints:^(MASConstraintMaker *make){
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(self.view.mas_width).multipliedBy(0.5);
        make.top.equalTo(self.view).with.offset(5);
        make.leading.equalTo(self.view);
    }];
    [img_apply_bg mas_makeConstraints:^(MASConstraintMaker *make){
        make.edges.equalTo(view_status);
    }];
    
    UILabel *lb_1 = [[UILabel alloc] init];
    lb_1.text=@"恭喜您！您已经是幸会大型活动经理！";
    lb_1.textColor = Color(@"2ebe00");
    lb_1.textAlignment = NSTextAlignmentCenter;
    [lb_1 mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.right.equalTo(view_status);
    }];
    if (self.applyDic) {
        if ([self.applyDic[@"apply_status"] integerValue]==1) {
            [self setTitle:@"申请状态"];
            UILabel *lb_status = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, 30)];
            lb_status.text = @"您的申请已经受理，管理员正在审核中";
            [self.view addSubview:lb_status];
        }
        else  if ([self.applyDic[@"apply_status"] integerValue]==2)//申请成功
        {
            
        }
    }
    // Do any additional setup after loading the view.
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
