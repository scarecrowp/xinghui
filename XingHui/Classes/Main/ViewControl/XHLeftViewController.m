//
//  XHLeftViewController.m
//  XingHui
//
//  Created by wangpei on 15/6/4.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHLeftViewController.h"
#import "XHFindItemTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "XHSetUpViewController.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
#import "UIImage+Category.h"
#import "UIImageView+Category.h"
#import "XHMyGatherViewController.h"
@interface XHLeftViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableview;
    UIView *head;
    NSArray *dataArr;
   
}
@property(nonatomic,strong) UIImageView *img_head;
@property(nonatomic,strong)UILabel *lb_name;
@property(nonatomic,strong)UILabel *lb_job;
@end

@implementation XHLeftViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:Color(@"ffffff")];
    tableview =[UITableView new];
    [tableview setFrame:CGRectMake(0, 0, 260, SCREEN_HEIGHT)];
    tableview.dataSource=self;
    tableview.delegate=self;
    [self.view addSubview:tableview];
    tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    //获得菜单列表
    dataArr =[JLCommonUtil getLeftItemArr];
    
    head= [[UIView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, 80)];
    [head addSubview:self.img_head];
    [head addSubview:self.lb_name];
    [head addSubview:self.lb_job];
    UILabel *lb_bottom_line =[[UILabel alloc] initWithFrame:CGRectMake(self.img_head.frame.origin.x, CGRectGetMaxY(self.img_head.frame)+10, 280, 1)];
    lb_bottom_line.backgroundColor=[UIColor ColorWithHexString:@"dddddd"];
    [head addSubview:lb_bottom_line];
    
    UIButton *bt_edit=[AciMath getButtonWithImage:@"bt_finishdata@3x" frame:CGRectMake(230-40, 15+20, 43, 28) event:@selector(editUserinfo:) target:self];
    [head addSubview:bt_edit];
 
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([[XHDefaultUser sharedUser].userpic isEqualToString:@""]) {
        [_img_head setImage:[UIImage imageNamed:@"head_deault"]];
    }
    else
    {
        [_img_head sd_setImageWithURL:[NSURL URLWithString:[XHDefaultUser sharedUser].userpic]];
    }
    _lb_job.text =[XHDefaultUser sharedUser].job;
}
#pragma mark 头像
-(UIImageView *)img_head
{
    if (!_img_head) {
        _img_head =[[UIImageView alloc] initWithFrame:CGRectMake(8, 8+20, 54, 54)];
             //  [_img_head sd_setImageWithURL:[NSURL URLWithString:[XHDefaultUser sharedUser].userpic] placeholderImage:[UIImage imageFromString:[[XHDefaultUser sharedUser].username substringToIndex:1] size:_img_head.frame.size]];
       
        _img_head.layer.masksToBounds =YES;
        _img_head.layer.cornerRadius =27;
        _img_head.userInteractionEnabled=YES;
        UITapGestureRecognizer *gest=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editUserinfo:)];
        [_img_head addGestureRecognizer:gest];
    }
    return _img_head;
}
-(UILabel *)lb_name
{
    if (!_lb_name) {
         _lb_name =[[UILabel alloc] initWithFrame:CGRectMake(76, 15+20, 81, 21)];
        _lb_name.text =[XHDefaultUser sharedUser].userRealName;
        [_lb_name setFont:[UIFont systemFontOfSize:15]];

    }
    return _lb_name;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)reloadData
{
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHFindItemTableViewCell *cell=  [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"XHLeftCell"]];
    if (!cell) {
    
        cell =[[XHFindItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XHLeftCell" data:[dataArr objectAtIndex:indexPath.row] xibfile:@"XHLeftCell"];
//        if (indexPath.row==3||indexPath.row==4) {
//            cell.line.hidden=NO;
//        }
    }
    
    return cell;
}

#pragma mark -s

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        if (finished) {
            if (indexPath.row==4) {
                XHMyGatherViewController *mygather=[[XHMyGatherViewController alloc] initWithType:2];
                  [_delegate didViewControlTransfor:mygather];
            }
            else if (indexPath.row==5)
            {
                XHMyGatherViewController *mygather=[[XHMyGatherViewController alloc] initWithType:3];
                [_delegate didViewControlTransfor:mygather];
            }
            else  if (indexPath.row==0) {
                XHMyGatherViewController *mygather=[[XHMyGatherViewController alloc] initWithType:1];
                [_delegate didViewControlTransfor:mygather];
            }else
            {
                UIViewController *control=  [[NSClassFromString([[dataArr objectAtIndex:indexPath.row] objectForKey:@"page"]) alloc] init];
                [_delegate didViewControlTransfor:control];
            }
          //  UIViewController *control = (UIViewController *)NSClassFromString([[dataArr objectAtIndex:indexPath.row] objectForKey:@"page"]);
           
        }
        
    }];

}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
        return head;
}
-(double)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        return 1;
    }
    return 88;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(void)editUserinfo:(id)sender
{
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        if (finished) {
              XHSetUpViewController *setup =[[XHSetUpViewController alloc] init];
            [_delegate didViewControlTransfor:setup];
        }
        
    }];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(UILabel *)lb_job
{
    if (!_lb_job) {
         _lb_job =[[UILabel alloc] initWithFrame:CGRectMake(76, 37+20, 148, 21)];
        
        [_lb_job setFont:[UIFont systemFontOfSize:13]];
        _lb_job.textColor=[UIColor ColorWithHexString:@"656566"];
    }
    return _lb_job;
}
@end
