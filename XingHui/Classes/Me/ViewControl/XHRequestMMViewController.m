//
//  XHRequestMMViewController.m
//  XingHui
//
//  Created by gaoyuerui on 15/9/18.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHRequestMMViewController.h"
#import "UIPlaceHolderTextView.h"
#import "XHWebViewController.h"
#import "UIViewController+DismissKeyboard.h"
#import "UIViewController+HUD.h"
@interface XHRequestMMViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UITextField *tb_name;
@property(nonatomic,strong)UITextField *tb_com;
@property(nonatomic,strong)UITextField *tb_position;
@property(nonatomic,strong)UITextField *tb_tell;
@property(nonatomic,strong)UITextField *tb_mail;
@property(nonatomic,strong)UITextField *tb_city;
@property(nonatomic,strong)UIPlaceHolderTextView *tb_note;
@end

@implementation XHRequestMMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"申请成为会议经理"];
    UILabel *top_tip= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 43)];
    [top_tip setBackgroundColor:Color(@"2ebe00")];
    top_tip.textAlignment= NSTextAlignmentCenter;
    [top_tip setTextColor:Color(@"ffffff")];
    [top_tip setFont:Font(16)];
    top_tip.text = @"幸会将对您的信息进行审核，请确认内容真实有效";
    _tb_name.text=[XHDefaultUser sharedUser].userRealName;
    _tb_tell.text=[XHDefaultUser sharedUser].tell;
    WS(ws);
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.edges.equalTo(ws.view);
    }];
    UIView *view_foot=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    view_foot.backgroundColor = Color(@"f3f3f3");
    UIButton *bt_submit = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, SCREEN_WIDTH-10, 50)];
    [bt_submit setBackgroundColor:Color(@"2ebe00")];
    [bt_submit setTitle:@"提交申请" forState:UIControlStateNormal];
    [bt_submit addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    [view_foot addSubview:bt_submit];
    self.tableView.tableHeaderView = top_tip;
    self.tableView.tableFooterView = view_foot;
    [self setupForDismissKeyboard];
    if(self.navigationController.navigationBarHidden)
    {
        [self.navigationController setNavigationBarHidden:NO];
    }
    // Do any additional setup after loading the view from its nib.
}
-(void)setTableCellLine
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [self scrollTopWhenPutin:-200];
    return YES;
}
- (IBAction)submit:(id)sender {
    NSString *sname =[_tb_name.text isEqualToString:@""]?_tb_name.placeholder:_tb_name.text;
    NSString *stell =[_tb_tell.text isEqualToString:@""]?_tb_tell.placeholder:_tb_tell.text;
    NSString *smail =[_tb_mail.text isEqualToString:@""]?_tb_mail.placeholder:_tb_mail.text;
    NSString *posi =[_tb_position.text isEqualToString:@""]?_tb_position.placeholder:_tb_position.text;
    NSString *scom =[_tb_com.text isEqualToString:@""]?_tb_com.placeholder:_tb_com.text;
    if (!smail) {
        smail=@"";
    }
    NSDictionary *param =@{@"name":sname,
                           @"tell":stell,
                           @"note":_tb_note.text,
                           @"city":_tb_city.text,
                           @"mail":smail,
                           @"position":posi,
                           @"com_name":scom};
    [[XHNetWork sharedNetWork] Post:[NSString APIURLString:@"managerequest.ashx"]
                         parameters:param
                           complete:^(NSDictionary *dic){
                               [[XHDefaultUser sharedUser] saveApplyStatus:2];
                              
                               [self showHUDin2s:dic[@"message"] complete:@selector(ToApplyStatus)];
       
    }];
}
-(void)ToApplyStatus
{
    XHWebViewController *webview =[[XHWebViewController alloc] init];
    webview.webtitle = @"申请成为会议经理";
    NSString *url =[NSString stringWithFormat:@"applystatus.aspx?uname=%@",[XHDefaultUser sharedUser].username];
    webview.webUrl = WapUrl(url);
    [self.navigationController pushViewController:webview animated:YES];
}
- (IBAction)hiddenKeyBoard:(id)sender {
    [self scrollBack];
    [self hideKayBoard];
}
#pragma mark - UITableViewDelegate
-(double)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
    view.backgroundColor = Color(@"f3f3f3");
    return view;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 6;
            break;
        case 1:
            return 1;
            break;
        default:return 1;
            break;
    };
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                {
                    cell=[tableView dequeueReusableCellWithIdentifier:@"school"];
                    if (!cell) {
                        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"school"];
                        
                        cell.textLabel.text=@"真实姓名";
                        [ cell.textLabel setFont:Bold(16)];
                        [ cell.textLabel setTextColor:Color(@"595959")];
                        
                        _tb_name = [[UITextField alloc] initWithFrame:CGRectMake(100, 0, SCREEN_WIDTH-100-30, 43)];
                        _tb_name.placeholder =[XHDefaultUser sharedUser].userRealName;
                        _tb_name.textAlignment = NSTextAlignmentRight;
                        _tb_name.inputAccessoryView = [AciMath getKeybordToolbar:self action:@selector(hiddenKeyBoard:)];
                        [cell addSubview:_tb_name];
                    }
                }
                    break;
                case 1:
                {
                    cell=[tableView dequeueReusableCellWithIdentifier:@"major"];
                    if (!cell) {
                        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"major"];
                        cell.textLabel.text=@"任职机构";
                        [cell.textLabel setFont:Bold(16)];
                        [cell.textLabel setTextColor:Color(@"595959")];
                        _tb_com = [[UITextField alloc] initWithFrame:CGRectMake(100, 0, SCREEN_WIDTH-100-30, 43)];
                        _tb_com.placeholder = [XHDefaultUser sharedUser].company;
                        _tb_com.textAlignment = NSTextAlignmentRight;
                        _tb_com.inputAccessoryView = [AciMath getKeybordToolbar:self action:@selector(hiddenKeyBoard:)];
                        [cell addSubview:_tb_com];
                    }
                    
                }
                    break;
                case 2:
                {
                    cell=[tableView dequeueReusableCellWithIdentifier:@"edu"];
                    if (!cell) {
                        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"edu"];
                        cell.textLabel.text=@"头衔/职位";
                        [cell.textLabel setFont:Bold(16)];
                        [cell.textLabel setTextColor:Color(@"595959")];
                        _tb_position = [[UITextField alloc] initWithFrame:CGRectMake(100, 0, SCREEN_WIDTH-100-30, 43)];
                        _tb_position.placeholder = [XHDefaultUser sharedUser].job;
                        [cell addSubview:_tb_position];
                        _tb_position.textAlignment = NSTextAlignmentRight;
                          _tb_position.inputAccessoryView = [AciMath getKeybordToolbar:self action:@selector(hiddenKeyBoard:)];
                      //  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    }
                }
                    break;
                case 3:
                {
                    cell=[tableView dequeueReusableCellWithIdentifier:@"time"];
                    if (!cell) {
                        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"time"];
                        cell.textLabel.text=@"您的手机";
                        [cell.textLabel setFont:Bold(16)];
                        [cell.textLabel setTextColor:Color(@"595959")];
                        _tb_tell = [[UITextField alloc] initWithFrame:CGRectMake(100, 0, SCREEN_WIDTH-100-30, 43)];
                        _tb_tell.placeholder = [XHDefaultUser sharedUser].tell;
                        _tb_tell.textAlignment = NSTextAlignmentRight;
                        [cell addSubview:_tb_tell];
                           _tb_tell.inputAccessoryView = [AciMath getKeybordToolbar:self action:@selector(hiddenKeyBoard:)];
                      //  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    }
                    
                }
                    break;
                    case  4:
                {
                    cell=[tableView dequeueReusableCellWithIdentifier:@"mail"];
                    if (!cell) {
                        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mail"];
                        cell.textLabel.text=@"您的邮箱";
                        [cell.textLabel setFont:Bold(16)];
                        [cell.textLabel setTextColor:Color(@"595959")];
                        _tb_mail = [[UITextField alloc] initWithFrame:CGRectMake(100, 0, SCREEN_WIDTH-100-30, 43)];
                        _tb_mail.placeholder = [[XHDefaultUser sharedUser].mail ToString];
                        _tb_mail.textAlignment = NSTextAlignmentRight;
                          _tb_mail.inputAccessoryView = [AciMath getKeybordToolbar:self action:@selector(hiddenKeyBoard:)];
                        [cell addSubview:_tb_mail];
                       // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    }

                }
                    break;
                    case 5:
                {
                    cell=[tableView dequeueReusableCellWithIdentifier:@"city"];
                    if (!cell) {
                        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"city"];
                        cell.textLabel.text=@"所在城市";
                        [cell.textLabel setFont:Bold(16)];
                        [cell.textLabel setTextColor:Color(@"595959")];
                        _tb_city = [[UITextField alloc] initWithFrame:CGRectMake(100, 0, SCREEN_WIDTH-100-30, 43)];
                        _tb_city.text = @"";
                          _tb_city.inputAccessoryView = [AciMath getKeybordToolbar:self action:@selector(hiddenKeyBoard:)];
                        _tb_city.textAlignment = NSTextAlignmentRight;
                        [cell addSubview:_tb_city];
                    //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    }

                }
                    break;
                default:
                    break;
            }
            break;
        case 1:
        {
            _tb_note = [[UIPlaceHolderTextView alloc] initWithFrame:CGRectMake(5, 0, SCREEN_WIDTH-10, 100)];
            cell = [tableView dequeueReusableCellWithIdentifier:@"note"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"note"];
            }
            _tb_note.placeholder=@"申请成为活动经理的简要理由";
            _tb_note.delegate =self;
            _tb_note.inputAccessoryView = [AciMath getKeybordToolbar:self action:@selector(hiddenKeyBoard:)];
            [cell addSubview:_tb_note];
        }
            break;
            
        default:
            cell =[tableView dequeueReusableCellWithIdentifier:@"tips"];
            if (!cell) {
                cell = [[UITableViewCell alloc ]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tips"];
            }
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0: return 44;  break;
        case 1: return 100; break;
        default:return 100;
            break;
    }
    return 54;
}

@end
