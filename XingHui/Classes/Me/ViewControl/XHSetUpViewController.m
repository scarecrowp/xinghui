//
//  XHSetUpViewController.m
//  XingHui
//
//  Created by wangpei on 15/6/5.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHSetUpViewController.h"
#import "UIImageView+Category.h"
#import "UIImage+Category.h"
#import "XHCreateJobHistory.h"
#import "XHUserTagViewController.h"
#import "XHJobHistoryListVC.h"
#import "XHStudyListVC.h"
#import "XHSetIndustryViewController.h"
@interface XHSetUpViewController ()<PassValueDelegate,UITextFieldDelegate>
{
 
    UIScrollView *scrollview;
}
@end

@implementation XHSetUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"完善个人基本资料"];
    [self initLayout];
    [self initAction];
    [self initData];
    // Do any additional setup after loading the view from its nib.
}
-(void)initLayout
{
    [self.leftButton setImage:[UIImage imageNamed:@"bt_close_gray"] forState:UIControlStateNormal];
    [self.rightButton setTitle:@"保存" forState:UIControlStateNormal];
    scrollview= [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:scrollview];
    _img_head.layer.cornerRadius = 28;
    _img_head.layer.masksToBounds = YES;
    _view_base.frame =CGRectMake(0, 0, SCREEN_WIDTH, _view_base.frame.size.height);
    CGRect rect_base = _view_base.frame;
    rect_base.origin.y=10;
    
    [_view_base setFrame:rect_base];
    [scrollview addSubview:_view_base];
    CGRect ot=_view_other.frame;
    ot.size.width=SCREEN_WIDTH;
    ot.origin.y=CGRectGetMaxY(_view_base.frame)+10;
    [_view_other setFrame:ot];
    
    [scrollview addSubview:_view_other];
    CGRect cc=_view_connect.frame;
    cc.size.width=SCREEN_WIDTH;
    cc.origin.y=CGRectGetMaxY(_view_other.frame)+10;
    _view_connect.frame=cc;
    _view_connect.layer.masksToBounds = YES;
    _view_other.layer.masksToBounds = YES;
    [scrollview addSubview:_view_connect];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [scrollview setContentSize:CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(_view_connect.frame)+64)];
}
-(void)initData
{
    _lb_name.text=[XHDefaultUser sharedUser].userRealName;
    _lb_sex.text=[[XHDefaultUser sharedUser].sex isEqualToString:@"1"]?@"男":@"女";
    _lb_job.text=[XHDefaultUser sharedUser].job;
    _lb_industry.text=[XHDefaultUser sharedUser].industry;
    _lb_com.text=[XHDefaultUser sharedUser].company;
    _tb_mail.text = [XHDefaultUser sharedUser].mail;
    _tb_wechat.text = [XHDefaultUser sharedUser].wechat;
    _tb_QQ.text = [XHDefaultUser sharedUser].QQ;
    [_img_head sd_setImageWithURL:[NSURL URLWithString:[XHDefaultUser sharedUser].userpic]
                 placeholderImage:[UIImage imageNamed:@"noHead@3x"]];

    if ([XHDefaultUser sharedUser].workHistory.count>0) {
        NSDictionary *dic=[[XHDefaultUser sharedUser].workHistory objectAtIndex:0];
        _lb_jobhistory.text=[NSString stringWithFormat:@"%@~%@ %@ %@",dic[@"begin_time"],dic[@"end_time"],dic[@"com_name"],dic[@"job_position"]];

    }
    
    if ([XHDefaultUser sharedUser].studyHistory.count>0) {
        NSDictionary *dic=[[XHDefaultUser sharedUser].studyHistory objectAtIndex:0];
        _lb_study.text=[NSString stringWithFormat:@"%@~%@ %@ %@",dic[@"begin_year"],dic[@"end_year"],dic[@"school_name"],dic[@"major"]];
        
    }
    if ([XHDefaultUser sharedUser].tagArr.count>0) {
        NSString *sTag=@"";
        for (NSDictionary *dic in [XHDefaultUser sharedUser].tagArr) {
            sTag =[sTag stringByAppendingString:dic[@"tag_title"]];
         
        }
        _lb_tag.text =sTag;
    }
    _tb_wechat.delegate =self;
    _tb_QQ.delegate = self;
    _tb_mail.delegate = self;
   
}
-(void)initAction
{
    [_img_head setTarget:self action:@selector(selectPicMode:)];
    [_lb_jobhistory addTarget:self action:@selector(editJobHistory)];
    [_lb_tag addTarget:self action:@selector(editTag)];
    [_lb_study addTarget:self action:@selector(editStudy)];
    [_lb_industry addTarget:self action:@selector(setindustry)];
    _tb_mail.inputAccessoryView = [AciMath getKeybordToolbar:self action:@selector(HIDDENKEYBOARD:)];
    _tb_QQ.inputAccessoryView = [AciMath getKeybordToolbar:self action:@selector(HIDDENKEYBOARD:)];
    _tb_wechat.inputAccessoryView = [AciMath getKeybordToolbar:self action:@selector(HIDDENKEYBOARD:)];
    _lb_com.inputAccessoryView = [AciMath getKeybordToolbar:self action:@selector(HIDDENKEYBOARD:)];
    _lb_job.inputAccessoryView = [AciMath getKeybordToolbar:self action:@selector(HIDDENKEYBOARD:)];
    _lb_name.inputAccessoryView = [AciMath getKeybordToolbar:self action:@selector(HIDDENKEYBOARD:)];
         
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==_tb_mail||textField ==_tb_QQ||textField==_tb_wechat) {
//        [scrollview scrollRectToVisible:CGRectMake(0, _view_connect.frame.origin.y, scrollview.frame.size.width, scrollview.frame.size.height) animated:YES];
        [scrollview setContentOffset:CGPointMake(0,  _view_connect.frame.origin.y) animated:NO];
    }
    return YES;
}
-(void)editJobHistory
{
    XHJobHistoryListVC *jobhistory=[[XHJobHistoryListVC alloc] init];
    [self.navigationController pushViewController:jobhistory animated:YES];
}
-(void)editTag
{
    XHUserTagViewController *tag =[[XHUserTagViewController alloc] init];
    tag.passdelegate=self;
    [self.navigationController pushViewController:tag animated:YES];
}
-(void)editStudy
{
    XHStudyListVC *study = [[XHStudyListVC alloc] init];
    study.passdelegate = self;
    [self.navigationController pushViewController:study animated:YES];
}
-(void)setindustry
{
    XHSetIndustryViewController *industry = [[XHSetIndustryViewController alloc] init];
    industry.passdelegate = self;
    
    [self.navigationController pushViewController:industry animated:YES];
}
-(void)didfinishSetImg:(UIImage *)image
{
    [_img_head setImage:image];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    
 
    [[XHNetWork sharedNetWork] PostData:[NSString APIURLString:@"uploadpic.ashx"]  data:imageData parameters:nil complete:^(NSDictionary *dic) {
        
        [XHDefaultUser sharedUser].userpic=[NSString PicUrlString:[dic objectForKey:@"content"]];
        [[XHDefaultUser sharedUser] saveUserPic:[dic objectForKey:@"content"]];

    } error:^(NSString *error) {
        [self showHUDin2s:error];
    }];
    
    
}
-(void)selectSheet:(UIActionSheet *)sheet index:(NSInteger)index
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setHeadPic
{
    
}
-(void)rightButtonAction
{
    [[XHDefaultUser sharedUser] saveDefaultUser];
    NSDictionary *dic=@{@"user_head":[XHDefaultUser sharedUser].userpic,
                         @"user_job":[XHDefaultUser sharedUser].job,
                         @"user_com":[XHDefaultUser sharedUser].company,
                    @"user_industry":_lb_industry.text,
                        @"user_mail":_tb_mail.text,
                      @"user_wechat":_tb_wechat.text,
                          @"user_qq":_tb_QQ.text,
                        @"user_realname":_lb_name.text
                        };
    [[XHNetWork sharedNetWork] Post:[NSString APIURLString:@"setuserinfo.ashx"] parameters:dic complete:^(NSDictionary *dic){
        [self showHUDin2s:@"提交成功"];
        [JLCommonUtil saveUserInfo:[[dic objectForKey:@"content"] objectAtIndex:0]];
        
    }];
}
-(void)passbackObject:(id)object sender:(NSString *)sender
{
    if ([object isKindOfClass:[NSDictionary class]]) {
         NSDictionary *dic=object;
        if ([sender isEqualToString:@"study"]) {
           
            _lb_study.text = [NSString stringWithFormat:@"%@~%@ %@",[dic[@"begin_year"] ToString],[dic[@"end_year"] ToString],[dic[@"school_name"] ToString]];
            
        }
        else if([sender isEqualToString:@"industry"])
        {
            
            _lb_industry.text = [NSString stringWithFormat:@"%@ %@",dic[@"name1"],dic[@"name2"]];
            [XHDefaultUser sharedUser].industry = _lb_industry.text;
        }
        else
        {
            
            [[XHDefaultUser sharedUser].workHistory addObject:dic];
          
            _lb_jobhistory.text=[NSString stringWithFormat:@"%@~%@ %@",[dic[@"begin_time"] ToString],[dic[@"end_time"] ToString],[dic[@"com_name"] ToString]];

        }
       
    }
    else
    {
        NSMutableArray *arr=object;
        NSString *stag=@"";
        for (NSDictionary *dic in arr) {
            stag =[stag stringByAppendingString:dic[@"tag_title"]];
        }
        _lb_tag.text=stag;
    }
 }

- (IBAction)HIDDENKEYBOARD:(id)sender {
    [self hideKayBoard];
 
        if (scrollview.contentOffset.y== _view_connect.frame.origin.y) {
            //        [scrollview scrollRectToVisible:CGRectMake(0, _view_connect.frame.origin.y, scrollview.frame.size.width, scrollview.frame.size.height) animated:YES];
            [scrollview setContentOffset:CGPointMake(0, 0) animated:NO];
        }
    
}
@end
