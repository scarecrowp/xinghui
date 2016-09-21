//
//  XHCreateGatherViewController.m
//  XingHui
//
//  Created by gaoyuerui on 15/6/7.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHCreateGatherViewController.h"
#import "XHDatePicker.h"
#import "XHSearchPlaceViewController.h"
#import "PassValueDelegate.h"
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import "AFNetworking.h"

#import "XHSetPicViewController.h"
#import "XHDatePicker.h"
#import "GatherManage.h"
#import "XHGather.h"
#import "XHRelationBigVC.h"
#import "NSDate+Category.h"
@interface XHCreateGatherViewController ()<PassValueDelegate,UIScrollViewDelegate,BMKPoiSearchDelegate,DatePickerDeleGate,GatherManageDelegate,UITableViewDataSource,UITableViewDelegate>
{
  
    int pickTag;
    NSData *imageData;
    NSArray *arrType;
    NSArray *payType;
    NSArray *tableSection;
    NSArray *titleArr;
    NSDictionary *bmkpoiinfo;
    BMKPoiSearch *_poisearch;
    BMKPoiDetailSearchOption* option ;
    GatherManage *gatherManage;
    NSString *bigID;
}
@property (nonatomic , strong) UIScrollView *scrollview;
@property (nonatomic , strong) XHDatePicker *datepicker;
@property (nonatomic , strong) UITableView *tableview;
@property (nonatomic , strong) UITextField *tb_title;
@property (nonatomic , strong) UIButton *img_head;
@end

@implementation XHCreateGatherViewController
-(instancetype)init
{
    self=[super init];
    if (self) {
        arrType=[[NSArray alloc] initWithObjects:@"咖啡",@"聚餐",@"会面",@"聚会", nil];
        payType =[[NSArray alloc] initWithObjects:@"我请客",@"AA", nil];
        tableSection=[[NSArray alloc] initWithObjects:@(7),@(3),@(1), nil];
        titleArr=[[NSArray alloc] initWithObjects:@"聚会名称",@"",@"聚会类型",@"费用分摊方式",@"人数限制",@"添加标签",@"活动地点", nil];
        pickTag=1;
        gatherManage = [GatherManage new];
        bigID =@"";
    }
   
    return self;
}
#pragma mark - life
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"创建聚会"];
    gatherManage.delegate=self;
    
    [self.view addSubview:self.scrollview];
    [self.view addSubview:self.datepicker];
 
    _tb_info.inputAccessoryView=[AciMath getKeybordToolbar:self action:@selector(HiddenKeyBoard:)];
    _tb_personNum.inputAccessoryView=[AciMath getKeybordToolbar:self action:@selector(HiddenKeyBoard:)];
    
    option = [[BMKPoiDetailSearchOption alloc] init];
    imageData =[@"" dataUsingEncoding:NSUTF8StringEncoding];
 
    NSDate *now =[[NSDate alloc] init];
    NSString *benginTimeStr =[NSString stringWithFormat:@"%ld-%ld-%ld 10:00",(long)now.year,(long)now.month,now.day+2];
 
    NSString *endTimeStr =[NSString stringWithFormat:@"%ld-%ld-%ld 12:00",(long)now.year,(long)now.month,now.day+2];
    _lb_begintime.text =benginTimeStr;
    _lb_endtime.text = endTimeStr;
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if(self.navigationController.navigationBarHidden)
    {
        [self.navigationController setNavigationBarHidden:NO];
    }
    _datepicker.hidden=YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -

#pragma mark - tableDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[tableSection objectAtIndex:section] integerValue];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    cell=[tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"gatherTitle"]];
                    if (!cell) {
                        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"gatherTitle"];
                        [cell addSubview:self.tb_title];
                    }
                    break;
                case 1:
                    cell=[tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"pic"]];
                    if (!cell) {
                       cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"pic"];
                        [cell addSubview:self.img_head];
                        
                    }
                default:
                    break;
            }
            break;
            
        default:
            break;
    }
    return cell;
}
-(double)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark -
#pragma mark - UIview Action
- (IBAction)selectBeginTime:(id)sender {
    _datepicker.hidden=NO;
    pickTag=1;
}

- (IBAction)selectEndTime:(id)sender {
    _datepicker.hidden=NO;
    pickTag=2;
}
- (IBAction)selectPic:(id)sender {
    [super selectPicMode:sender];

}
- (IBAction)selectGatherType:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"咖啡",@"聚餐",@"会面",@"聚会", nil];
    actionSheet.tag=2;
    [actionSheet showInView:self.view];
}
- (IBAction)chosePayType:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"我请客",@"AA", nil];
    actionSheet.tag=3;
    [actionSheet showInView:self.view];
    
}

- (IBAction)chosePlace:(id)sender {
    XHSearchPlaceViewController *place =[[XHSearchPlaceViewController alloc] init];
    place.passvalue=self;
    [self.navigationController pushViewController:place animated:YES];
}

- (IBAction)selectGather:(id)sender {
    XHRelationBigVC *big =[[XHRelationBigVC alloc] init];
    big.passdelegate =self;
    [self.navigationController pushViewController:big animated:YES];
}
#pragma mark -
#pragma mark - UIActionSheetDelegate
 -(void)selectSheet:(UIActionSheet *)sheet index:(NSInteger)index
{
    if (sheet.tag==2) {
        if (index!=4) {
            _lb_gatherType.text=[arrType objectAtIndex:index];
        }
    }
    else if (sheet.tag==3)
    {
        if (index!=2) {
            _lb_paytype.text=[payType objectAtIndex:index];
        }
        
    }

}
-(void)didfinishSetImg:(UIImage *)image
{
    imageData = UIImageJPEGRepresentation(image, 0.5);
    [_img_head setImage:image forState:UIControlStateNormal];
}

#pragma mark -
#pragma mark -DatePickerDeleGate
-(void)selectdone:(NSString *)datestr
{
    if (pickTag==1) {
        _lb_begintime.text=datestr;
        
    }
    else if (pickTag==2)
    {
        _lb_endtime.text=datestr;
    }
}


#pragma mark - BMKPoiSearchDelegate
-(void)passbackObject:(id)object sender:(NSString *)sender
{
    if ([sender isEqualToString:@"gather"]) {
        _lb_biggather.text =((XHGather *)object).title;
        bigID =((XHGather *)object).gid;
    }
    else
    {
        bmkpoiinfo=object;
        _lb_place.text=bmkpoiinfo[@"name"];
    }

    
}
-(void)onGetPoiDetailResult:(BMKPoiSearch *)searcher result:(BMKPoiDetailResult *)poiDetailResult errorCode:(BMKSearchErrorCode)errorCode
{
    if(errorCode == BMK_SEARCH_NO_ERROR){
        //在此处理正常结果
    }
}
#pragma mark -

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    CGRect rect = CGRectMake(0.0, -300,self.view.frame.size.width,self.view.frame.size.height);
    self.scrollview.frame =rect;
    [UIView commitAnimations];
    return YES;
}

- (IBAction)HiddenKeyBoard:(id)sender {
    [self hideKayBoard];
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    CGRect rect = CGRectMake(0.0, 0,self.view.frame.size.width,self.view.frame.size.height);
    self.scrollview.frame =rect;
    [UIView commitAnimations];
}

- (IBAction)submit:(id)sender {
    if (![self CheckCreateGather]) {
        return;
    }
    [self showHUD:@"正在提交"];
 
    NSString *lat=[bmkpoiinfo[@"location"][@"lat"] ToString];
    NSString *lon=[bmkpoiinfo[@"location"][@"lng"] ToString];
    NSDictionary *dic =@{@"title":_tb_title.text,
                         @"starttime":_lb_begintime.text,
                         @"endtime":_lb_endtime.text,
                         @"gtype":_lb_gatherType.text,
                         @"paytype":_lb_paytype.text,
                         @"pnum":_lb_personnum.text,
                         @"location":bmkpoiinfo[@"address"],
                         @"place":bmkpoiinfo[@"name"],
                         @"info":_tb_info.text,
                         @"uid":@([XHDefaultUser sharedUser].uid),
                         @"name":[XHDefaultUser sharedUser].username,
                         @"lat":lat,
                         @"lon":lon,
                         @"right":_sw_open.on?@"0":@"1",
                         @"bigID":bigID
                         };
 
    [gatherManage createGather:dic gatherPicData:imageData finish:^{
        [self showHUD:@"提交成功"];
        [self performSelector:@selector(hideDelayed) withObject:nil afterDelay:2.0];
    }];


}
-(void)CreateSuccess
{
    [self showHUD:@"提交成功"];
    [self performSelector:@selector(hideDelayed) withObject:nil afterDelay:2.0];
}
-(void)CreateFail:(NSString *)failReason
{
     [self hideHud];
}
-(void)hideDelayed
{
    [self hideHud];
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)swChangeValue:(id)sender {
    UISwitch *sw=(UISwitch *)sender;
    if (sw.tag==1) {
        [_sw_friendOnly setOn:!sw.isOn];
        
    }
    else
    {
        [_sw_open setOn:!sw.isOn];
    }
}

#pragma mark- UIView Init
-(UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _tableview.dataSource=self;
        _tableview.delegate=self;
        
    }
    return _tableview;
}
-(UITextField *)tb_title
{
    if (!_tb_title) {
        _tb_title=[[UITextField alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH, 41)];
        _tb_title.placeholder=[titleArr objectAtIndex:0];
    }
    return _tb_title;
}
-(UIButton *)img_head
{
    if (!_img_head) {
        _img_head = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, 90, 90)];
        _img_head.imageView.image=[UIImage imageNamed:@"create_gather"];
        
    }
    return _img_head;
}
-(XHDatePicker *)datepicker
{
    if (!_datepicker) {
        int picHeight=200;
        _datepicker=[[XHDatePicker alloc] initWithFrames:CGRectMake(0, SCREEN_HEIGHT-picHeight-64, SCREEN_WIDTH, picHeight)];
        _datepicker.hidden=YES;
        _datepicker.pickerdelegate=self;
    }
    return _datepicker;
}
-(UIScrollView *)scrollview
{
    if (!_scrollview) {
        _scrollview =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        [_baseview setFrame:CGRectMake(0, 10, SCREEN_WIDTH, _baseview.frame.size.height)];
        [_scrollview setContentSize:CGSizeMake(SCREEN_WIDTH, _baseview.frame.size.height+50)];
        [_scrollview setBackgroundColor:Color(@"F3F3F3")];
        _scrollview.delegate=self;
        [_scrollview addSubview:self.baseview];
    }
    return _scrollview;
}

#pragma mark - private Method
-(BOOL)CheckCreateGather
{
    if (_tb_title.text.length==0) {
        [self showHUDin2s:@"标题不能为空"];
        return NO;
    }
    if (imageData.length==0) {
        [self showHUDin2s:@"图片不能为空"];
        return NO;
    }
    return YES;
}
@end
@interface TitleLable : UILabel
-(instancetype)initWitTitle:(NSString *)title;
@end
@implementation TitleLable

-(instancetype)initWitTitle:(NSString *)title
{
    self=[super init];
    if (self) {
        [self setFont:Bold(18)];
        self.text=title;
    }
    return self;
}

@end