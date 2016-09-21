//
//  XHJobHistoryListVC.m
//  XingHui
//
//  Created by gaoyuerui on 15/10/19.
//  Copyright © 2015年 wangpei. All rights reserved.
//

#import "XHJobHistoryListVC.h"
#import "XHMyJobCell.h"
#import "XHCreateJobHistory.h"
@interface XHJobHistoryListVC ()<UITableViewDataSource,UITableViewDelegate,PassValueDelegate>
{
    UITableView *tableview;
}
@end

@implementation XHJobHistoryListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"我的工作经历"];
    [self.view setBackgroundColor:Color(@"f3f3f3")];
    [self initVar];
    tableview = [[UITableView alloc] init];
    [tableview setBackgroundColor:Color(@"f3f3f3")];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    WS(ws);
    [tableview mas_makeConstraints:^(MASConstraintMaker *make){
        make.edges.equalTo(ws.view);
    }];
    UIView *footView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    UIButton *bt_add = [[UIButton alloc] init];
    [footView addSubview:bt_add];
    tableview.tableFooterView=footView;
    [bt_add setBackgroundColor:Color(@"2ebe00")];
    [bt_add setTitle:@"添加工作经历" forState:UIControlStateNormal];
    [bt_add addTarget:self action:@selector(addJob) forControlEvents:UIControlEventTouchUpInside];
    
    [bt_add mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(footView).with.offset(20);
        make.width.equalTo(footView).with.offset(-20);
        make.height.mas_equalTo(44);
        make.left.equalTo(footView).with.offset(10);
        make.right.equalTo(footView).with.offset(-10);
    }];
    // Do any additional setup after loading the view.
}
-(void)leftButtonAction
{
    [super leftButtonAction];
    if ([XHDefaultUser sharedUser].workHistory.count>0) {
        [self.passdelegate passbackObject:[XHDefaultUser sharedUser].workHistory[0] sender:@"job"];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initVar
{
    _JobArr =[NSMutableArray new];
    _JobArr = [XHDefaultUser sharedUser].workHistory;
}

-(void)addJob
{
    XHCreateJobHistory *jobhistory=[[XHCreateJobHistory alloc] init];
    jobhistory.passdelegate=self;
    
    [self.navigationController pushViewController:jobhistory animated:YES];
}
-(void)passbackObject:(id)object sender:(NSString *)sender
{
    NSMutableArray *arr_temp = [[NSMutableArray alloc] init];
    [arr_temp addObjectsFromArray:[XHDefaultUser sharedUser].workHistory];
    [arr_temp addObject:object];
    [XHDefaultUser sharedUser].workHistory =arr_temp;
    _JobArr =arr_temp;
    [[XHDefaultUser sharedUser] saveDefaultUser];
    [tableview reloadData];
}
#pragma mark -s

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _JobArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHMyJobCell  *cell=[tableView dequeueReusableCellWithIdentifier:@"jobcell"];
    if (!cell) {
        cell=[[XHMyJobCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"jobcell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell SETJobData:_JobArr[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    XHCreateJobHistory *create = [[XHCreateJobHistory alloc] init];
    create.jobDic=_JobArr[indexPath.row];
    [self.navigationController pushViewController:create animated:YES];
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
