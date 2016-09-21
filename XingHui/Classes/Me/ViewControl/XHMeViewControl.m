//
//  XHMeViewControl.m
//  XingHui
//
//  Created by wangpei on 15/5/18.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//
#import "XHMyGatherViewController.h"
#import "XHMeViewControl.h"
#import "XHFindItemTableViewCell.h"
#import "UIImageView+Category.h"
#import "XHSecretSetView.h"
#import "UILable+Category.h"
#import "XHWebViewController.h"
@interface XHMeViewControl ()<UITableViewDataSource,UITableViewDelegate,SecretDelegate>
{
    NSArray *dataArr;
    UIView *background;
    XHSecretSetView *setupview;
}
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIImageView *topPic;
@property (nonatomic, strong) UIImageView *headPic;
@property (nonatomic, strong) UILabel *lb_name;
@property (nonatomic, strong) UILabel *lb_job;
@property (nonatomic, strong) UITableView *tableview;
@end

@implementation XHMeViewControl
#pragma mark - lifecirle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"我的"];
    [self.leftButton setHidden:YES];
    dataArr =[JLCommonUtil getMeItemArr];
    [self.view setBackgroundColor:[AciMath getColor:@"EFEFEF"]];
    [self.view addSubview:self.tableview];
    
    [self.headView addSubview:self.topPic];
    [self.headView addSubview:self.headPic];
    [self.headView addSubview:self.lb_name];
     [self initdata];
    [self.headView addSubview:self.lb_job];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
   
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[self.navigationController setNavigationBarHidden:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark =
#pragma mark -initview/data
-(void)initdata
{
    if ([[XHDefaultUser sharedUser].userpic isEqualToString:@""]) {
        [self.headPic setImage:[UIImage imageNamed:@"head_deault"]];
    }
    else
    {
        [self.headPic sd_setImageWithURL:[NSURL URLWithString:[XHDefaultUser sharedUser].userpic]];
    }
    _lb_name.text=[XHDefaultUser sharedUser].userRealName;
    [_lb_name sizeToFit];
    self.lb_job.text=[NSString stringWithFormat:@" | %@",[XHDefaultUser sharedUser].job];
    [_topPic setImage:[AciMath getLocationJpgImage:@"me_top"]];
}
-(UITableView *)tableview
{
    if (!_tableview) {
         _tableview =[[UITableView alloc] init];
        _tableview.tableHeaderView=self.headView;
       
        _tableview.delegate=self;
        
        _tableview.dataSource=self;
        _tableview.tableFooterView=[UIView new];

    }
    return _tableview;
}
-(UIView *)headView;
{
    if (!_headView) {
        _headView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*0.42+53)];
        
    }
    return _headView;
}
-(UIImageView *)headPic
{
    if (!_headPic) {
        _headPic = [[UIImageView alloc] init];
        _headPic.frame=CGRectMake(SCREEN_WIDTH-82-10, self.topPic.maxY-41, 82, 82);
        _headPic .layer.masksToBounds =YES;
        _headPic .layer.cornerRadius=41;
        [_headPic setBackgroundColor:[UIColor whiteColor]];
    }
    return _headPic;
}
-(UILabel *)lb_name
{
    if (!_lb_name) {
        _lb_name = [[UILabel alloc] initWithFrame:CGRectMake(20, self.topPic.maxY + 16, 0, 21)];
        
        
    }
    return _lb_name;
}
-(UILabel *)lb_job
{
    if (!_lb_job) {
        _lb_job = [[UILabel alloc] initWithFrame:CGRectMake(self.lb_name.maxX+10, self.topPic.maxY + 16, 100, 21)];
        [_lb_job setFont:Font(13)];
        [_lb_job setTextColor:Color(@"9e9e9e")];
    }
    return _lb_job;
}
-(UIImageView *)topPic
{
    if (!_topPic) {
        _topPic=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*0.42)];
       
    }
    return _topPic;
}

#pragma mark -
#pragma mark - tableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHFindItemTableViewCell *cell=  [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"MeItemCell"]];
    if (!cell) {
        cell =[[XHFindItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MeItemCell" data:[dataArr objectAtIndex:indexPath.row+indexPath.section*3] xibfile:@"MeItemCell"];
        
    }
    return cell;
}

#pragma mark -s

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    if (indexPath.row+indexPath.section*3==1) {
        XHMyGatherViewController *mygather =[[XHMyGatherViewController alloc] initWithType:2];
        [self.navigationController pushViewController:mygather animated:YES];
    }
    else
    {
        if (indexPath.section==1&&indexPath.row==1) {
           
            if (background) {
                [background setHidden:NO];
                [setupview setHidden:NO];
            }
            else
            {
                background=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
                [background setBackgroundColor:[UIColor blackColor]];
                background.alpha=0.5;
                [self.view addSubview:background];
                [background addTarget:self action:@selector(hideSecView)];
                setupview=[[XHSecretSetView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 132+150) select:0];
                setupview.center=self.view.window.center;
                setupview.secdelegate=self;
                [self.view addSubview:setupview];
            }
         
            //            [self showCustom:setupview];
            return;
            
        }
        if (indexPath.section==0&&indexPath.row==2) {
            if ([XHDefaultUser sharedUser].applyStatus==1||[XHDefaultUser sharedUser].applyStatus==2) {
                XHWebViewController *webVC=[[XHWebViewController alloc] init];
                webVC.webtitle=@"申请成为会议经理";
                NSString *url =[NSString stringWithFormat:@"applystatus.aspx?uname=%@",[XHDefaultUser sharedUser].username];
                webVC.webUrl = WapUrl(url);
                [self.navigationController pushViewController:webVC animated:YES];
                return;
            }
          
            
        }
        BasicViewController *control=  [[NSClassFromString([[dataArr objectAtIndex:indexPath.row+indexPath.section*3] objectForKey:@"page"]) alloc] init];
        control.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:control animated:YES];
    }
   
    
}
-(void)Didselect:(int)selectIndex
{
    [self hideSecView];
    [[XHNetWork sharedNetWork] Get:[NSString APIURLString:@"setsecret.ashx"] param:@{@"value":@(selectIndex)} complete:^(NSDictionary *dic){
        [self showHUDin2s:@"更新成功"];
    }];
}
-(void)hideSecView
{
    [background setHidden:YES];
    [setupview setHidden:YES];
    // [self.HUD hide:YES];
}
-(double)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
 
    return 10;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
#pragma mark -
-(void)editUserinfo
{
    
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
