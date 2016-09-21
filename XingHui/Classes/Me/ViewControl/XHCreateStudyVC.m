//
//  XHCreateStudy.m
//  XingHui
//
//  Created by gaoyuerui on 15/10/19.
//  Copyright © 2015年 wangpei. All rights reserved.
//

#import "XHCreateStudyVC.h"
#import "XHJobDatePickView.h"
#import "UIViewController+DismissKeyboard.h"
#import "UIPlaceHolderTextView.h"
@interface XHCreateStudyVC ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,PickViewDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    UITableView *tableview;
    NSString *begintime;
    NSString *endtime;
    NSArray *eduArr;
    XHJobDatePickView *pick;
}
@property(nonatomic,strong)UITextField *tb_schoolName;
@property(nonatomic,strong)UITextField *tb_major;
@property(nonatomic,strong)UILabel *lb_education;
@property(nonatomic,strong)UILabel *lb_time;
@property(nonatomic,strong)UIPlaceHolderTextView *tv_note;
@end

@implementation XHCreateStudyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"添加教育经历"];
    eduArr =@[@"博士",@"硕士",@"本科",@"专科",@"高中"];
    [self.rightButton setTitle:@"保存" forState:UIControlStateNormal];
    tableview = [[UITableView alloc] init];
    [tableview setBackgroundColor:Color(@"f3f3f3")];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    [self setupForDismissKeyboard];
    WS(ws);
    [tableview mas_makeConstraints:^(MASConstraintMaker *make){
        make.edges.equalTo(ws.view);
    }];
    UIView *footView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    UIButton *bt_add = [[UIButton alloc] init];
    [footView addSubview:bt_add];

    tableview.tableFooterView=footView;
    [bt_add setBackgroundColor:Color(@"2ebe00")];
    [bt_add setTitle:@"保存" forState:UIControlStateNormal];
    [bt_add addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
   // [bt_add addTarget:self action:@selector(addStudy) forControlEvents:UIControlEventTouchUpInside];
    
    [bt_add mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(footView).with.offset(20);
        make.width.equalTo(footView).with.offset(-20);
        make.height.mas_equalTo(44);
        make.left.equalTo(footView).with.offset(10);
        make.right.equalTo(footView).with.offset(-10);
    }];
  
    
    // Do any additional setup after loading the view.
}
-(void)rightButtonAction
{
    WS(ws);
    NSDictionary *param = @{ @"school_name":_tb_schoolName.text,
                                   @"major":_tb_major.text,
                               @"education":_lb_education.text,
                              @"begin_year":begintime,
                                @"end_year":endtime,
                                    @"info":_tv_note.text
                            };
    [[XHNetWork sharedNetWork] Post:[NSString APIURLString:@"savestudy.ashx"] parameters:param complete:^(NSDictionary *dic){
        [ws.navigationController popViewControllerAnimated:YES];
        [ws.passdelegate passbackObject:param sender:@""];
    }];
}
#pragma mark - UITableViewDelegate
-(double)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 46;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    [view setBackgroundColor:Color(@"f3f3f3")];
    UILabel *lb_title=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 50)];
    [lb_title setFont:Font(16)];
    [lb_title setTextColor:Color(@"989898")];
    [view addSubview:lb_title];
    switch (section) {
        case 0:
            [lb_title setText:@"教育经历"];
            break;
        case 1:
            [lb_title setText:@"教育经历描述"];
            break;
        default:
            break;
    }
    return view;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 4;
            break;
          case 1:
            return 1;
            break;
        default:
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
                     
                        cell.textLabel.text=@"学校";
                        [ cell.textLabel setFont:Bold(16)];
                        [ cell.textLabel setTextColor:Color(@"333333")];
                   
                      
                        [cell addSubview:self.self.tb_schoolName];
                    }
                }
                    break;
                case 1:
                {
                    cell=[tableView dequeueReusableCellWithIdentifier:@"major"];
                    if (!cell) {
                        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"major"];
                        cell.textLabel.text=@"专业";
                        [cell.textLabel setFont:Bold(16)];
                        [cell.textLabel setTextColor:Color(@"333333")];
                      
                         [cell addSubview:self.tb_major];
                    }

                }
                    break;
                    case 2:
                {
                    cell=[tableView dequeueReusableCellWithIdentifier:@"edu"];
                    if (!cell) {
                        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"edu"];
                        cell.textLabel.text=@"学历";
                        [cell.textLabel setFont:Bold(16)];
                        [cell.textLabel setTextColor:Color(@"333333")];
                        _lb_education = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, SCREEN_WIDTH-100-30, 53)];
                        _lb_education.text = @"";
                        [cell addSubview:_lb_education];
                        _lb_education.textAlignment = NSTextAlignmentRight;
                        [_lb_education addTarget:self action:@selector(choseEdu)];
                        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    }
                }
                    break;
                    case 3:
                {
                    cell=[tableView dequeueReusableCellWithIdentifier:@"time"];
                    if (!cell) {
                        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"time"];
                        cell.textLabel.text=@"在校时间";
                        [cell.textLabel setFont:Bold(16)];
                        [cell.textLabel setTextColor:Color(@"333333")];
                        _lb_time = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, SCREEN_WIDTH-100-30, 53)];
                        _lb_time.text = @"";
                          _lb_time.textAlignment = NSTextAlignmentRight;
                        [cell addSubview:_lb_time];
                        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    }

                }
                default:
                    break;
            }
            break;
        case 1:
        {
            _tv_note = [[UIPlaceHolderTextView alloc] initWithFrame:CGRectMake(5, 0, SCREEN_WIDTH-10, 100)];
            _tv_note.inputAccessoryView = [AciMath getKeybordToolbar:self action:@selector(hideKayBoard)];
            _tv_note.placeholder = @"简单介绍一下吧";
           
            cell = [tableView dequeueReusableCellWithIdentifier:@"note"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"note"];
                 [cell addSubview:_tv_note];
            }
           
        }
            break;
            
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0: return 54;  break;
        case 1: return 100; break;
        default:
            break;
    }
    return 54;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 3:
                {
                    if (!pick) {
                        pick=[[XHJobDatePickView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-200-88, SCREEN_WIDTH, 200)];
                      //  pick =  [[[NSBundle mainBundle] loadNibNamed:@"XHJobDatePickView"owner:nil options:nil] objectAtIndex:0];
                        pick.delegate=self;
                        [self.view addSubview:pick];
                    }
                    else
                    {
                        pick.hidden=NO;
                    }

                }
                    break;
                    
                default:
                    break;
            }
            break;
            
        default:
            break;
    }
    
}
-(void)didSelectTime:(NSString *)begin endtime:(NSString *)end
{
    begintime = begin;
    endtime = end;
    _lb_time.text = [NSString stringWithFormat:@"%@ ~ %@",begin,end];
    
}
-(void)choseEdu
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"博士",@"硕士",@"本科",@"专科",@"高中", nil];
    actionSheet.tag=2;
    [actionSheet showInView:self.view];

}
#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex>eduArr.count-1) {
        return;
    }
    _lb_education.text =eduArr[buttonIndex];
}
-(void)selectSheet:(UIActionSheet *)sheet index:(NSInteger)index
{
    if (index>eduArr.count-1) {
        return;
    }
    _lb_education.text =eduArr[index];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UITextField *)tb_schoolName
{
    if (!_tb_schoolName) {
        _tb_schoolName = [[UITextField alloc] initWithFrame:CGRectMake(100, 0, SCREEN_WIDTH-100-30, 53)];
        _tb_schoolName.placeholder = @"必填";
        _tb_schoolName.textAlignment = NSTextAlignmentRight;
       _tb_schoolName.delegate = self;
       _tb_schoolName.inputAccessoryView = [AciMath getKeybordToolbar:self action:@selector(hideKayBoard)];


    }
    return _tb_schoolName;
}
-(UITextField *)tb_major
{
    if (!_tb_major) {
        _tb_major = [[UITextField alloc] initWithFrame:CGRectMake(100, 0, SCREEN_WIDTH-100-30, 53)];
        _tb_major.placeholder = @"必填";
        _tb_major.textAlignment = NSTextAlignmentRight;
        _tb_major.inputAccessoryView = [AciMath getKeybordToolbar:self action:@selector(hideKayBoard)];
        _tb_major.delegate = self;
    }
    return _tb_major;
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
