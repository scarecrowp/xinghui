//
//  XHMyGatherViewController.m
//  XingHui
//
//  Created by wangpei on 15/6/9.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHMyGatherViewController.h"
#import "MyGatherView.h"
#import "GatherManage.h"
#import "XHGatherDetailViewController.h"
#import "XHMyGather.h"
@interface XHMyGatherViewController ()<GatherManageDelegate,MyGatherViewDelegate>
{
    MyGatherView *mygather;
    NSInteger dataType;
    GatherManage *gatherManage;
}
@end

@implementation XHMyGatherViewController
-(instancetype)initWithType:(NSInteger)type
{
    self=[super init];
    dataType=type;//1，我发布的和我参加的，3，我关注的
    gatherManage =[[GatherManage alloc] init];
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (dataType==3) {
        [self setTitle:@"我的关注"];
    }
    else if(dataType==1)
    {
        [self setTitle:@"我的活动"];
    }
    else
    {
        [self setTitle:@"我参加的活动"];
    }
    [self.view setBackgroundColor:[UIColor ColorWithHexString:@"d7d7d7"]];
    mygather=[[MyGatherView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-64) dataType:dataType];
    mygather.delegate=self;
    [self.view addSubview:mygather];
    gatherManage.delegate=self;
    [gatherManage getMyGather:dataType currtype:1 uid:[XHDefaultUser sharedUser].uid];
    if(self.navigationController.navigationBarHidden)
    {
        [self.navigationController setNavigationBarHidden:NO];
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
-(void)getMyGather:(NSInteger)type
{
 
    if (type==1) {
        if (mygather.mydataArr) {
             [mygather setMyData:mygather.mydataArr];
        }
        else
        {
            [gatherManage getMyGather:dataType currtype:type uid:[XHDefaultUser sharedUser].uid];
        }
    }
   else
   {
      if (mygather.myJoinArr) {
           [mygather setMyData:mygather.myJoinArr];
      }
      else
      {
           [gatherManage getMyGather:dataType currtype:type uid:[XHDefaultUser sharedUser].uid];
      }
  }
}
-(void)didGetDather:(NSMutableArray *)gatherarr
{
    
    [mygather setMyData:gatherarr];
}
-(void)didSelectGather:(XHGather *)dic
{
    XHGatherDetailViewController *detail=[[XHGatherDetailViewController alloc] init];
    detail.gather=dic;
    [self.navigationController pushViewController:detail animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
