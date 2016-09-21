//
//  XHCreateJobHistory.m
//  XingHui
//
//  Created by wangpei on 15/8/24.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHCreateJobHistory.h"
#import "XHJobDatePickView.h"
@interface XHCreateJobHistory ()<UITextViewDelegate,PickViewDelegate>
{
    NSString *beginTime;
    NSString *endTime;
    UIPickerView *datePic;
    XHJobDatePickView *pick;
}
@end

@implementation XHCreateJobHistory

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"添加工作经历"];
    [self.rightButton setTitle:@"保存" forState:UIControlStateNormal];
    _lb_job_not.delegate=self;
    if (_jobDic) {
        [self fillJobData];
    }
}
-(void)fillJobData
{
    _tb_comName.text = _jobDic[@"com_name"];
    _tb_position.text = _jobDic[@"job_position"];
    beginTime=_jobDic[@"begin_time"] ;
    endTime =_jobDic[@"end_time"];
    [_bt_jobTime setTitle:[NSString stringWithFormat:@"%@ - %@",beginTime ,endTime] forState:UIControlStateNormal];
    _txt_bg.text = _jobDic[@"job_node"];
}
-(void)rightButtonAction
{
    NSDictionary *parm=@{@"com_name":_tb_comName.text,
                         @"job_position":_tb_position.text,
                         @"begin_time":beginTime,
                         @"end_time":endTime,
                         @"job_note":_lb_job_not.text,
                         @"uid":@([XHDefaultUser sharedUser].uid)};
    [[XHNetWork sharedNetWork] Post:[NSString APIURLString:@"addjob.ashx"]
                         parameters:parm
                           complete:^(NSDictionary *dic){
          [self.navigationController popViewControllerAnimated:YES];
          [self.passdelegate passbackObject:parm sender:@""];
      }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text

{    if (![text isEqualToString:@""])
    {
        _txt_bg.hidden = YES;
    }
    
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1)
    {
        _txt_bg.hidden = NO;
    }
    return YES;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)editJObTime:(id)sender {
    [self hideKayBoard];
    if (!pick) {
        pick=[[XHJobDatePickView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-200-88, SCREEN_WIDTH, 200)];
        pick.delegate=self;
        [self.view addSubview:pick];
    }
    else
    {
        pick.hidden=NO;
    }
  
    
}

- (IBAction) :(id)sender {
    [self rightButtonAction];
}
-(void)didSelectTime:(NSString *)begintime endtime:(NSString *)endtime
{
    beginTime=begintime;
    endTime=endtime;
    [_bt_jobTime setTitle:[NSString stringWithFormat:@"%@ - %@",begintime,endTime] forState:UIControlStateNormal];
}
@end
