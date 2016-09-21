//
//  XHStartViewController.m
//  XingHui
//
//  Created by gaoyuerui on 15/10/29.
//  Copyright © 2015年 wangpei. All rights reserved.
//

#import "XHStartViewController.h"
#import "XHLoginViewController.h"
@interface XHStartViewController ()<UIScrollViewDelegate>
{
   
}
@property(nonatomic,strong)UIScrollView *scroll;
@property(nonatomic,strong)UIPageControl *pagecontrol;
@end

@implementation XHStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    UIImageView *img1 =[[UIImageView alloc ]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT)];
    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"banner01" ofType:@"jpg"];
    [img1 setImage:[UIImage imageWithContentsOfFile:path1]];
    
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"banner02" ofType:@"jpg"];
    UIImageView *img2 =[[UIImageView alloc ]initWithImage:[UIImage imageWithContentsOfFile:path2]];
    
    [img2 setFrame:CGRectMake(SCREEN_WIDTH, 0,SCREEN_WIDTH, SCREEN_HEIGHT)];
    NSString *path3 = [[NSBundle mainBundle] pathForResource:@"banner03" ofType:@"jpg"];
    UIImageView *img3 =[[UIImageView alloc ]initWithImage:[UIImage imageWithContentsOfFile:path3]];
    
    [img3 setFrame:CGRectMake(SCREEN_WIDTH*2, 0,SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    UIImage *iamg =[AciMath getScImage:@"bt_skip_bg@2x" top:0 bottom:0 left:23 right:23];
    
     [self.view addSubview:self.scroll];
    [_scroll mas_makeConstraints:^(MASConstraintMaker *make){
        make.edges.equalTo(self.view);
    }];
    UIButton *bt_start=nil;
    bt_start =[[UIButton alloc] init];
       [bt_start setFrame:CGRectMake(SCREEN_WIDTH*2+50, SCREEN_HEIGHT- 100-38, SCREEN_WIDTH-100, 38)];
    [_scroll addSubview:img1];
    [_scroll addSubview:img2];
    [_scroll addSubview:img3];
    [_scroll addSubview:bt_start];
   
    [bt_start setBackgroundImage:iamg forState:UIControlStateNormal];
    [bt_start setTitle:@"立即开启" forState:UIControlStateNormal];
    [bt_start addTarget:self action:@selector(skips)];
 
 
    _pagecontrol = [[UIPageControl alloc] init];
    [_pagecontrol setFrame:CGRectMake(0, SCREEN_HEIGHT-_pagecontrol.frame.size.height, SCREEN_WIDTH, 37)];
    _scroll.contentSize = CGSizeMake(SCREEN_WIDTH * 3,0);
    _scroll.bounces = NO;
    [self.view addSubview:_pagecontrol];

    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
     [self.navigationController setNavigationBarHidden:YES];
}
-(void)skips
{
    XHLoginViewController *login = [[XHLoginViewController alloc] init];
    [self.navigationController pushViewController:login animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIScrollView *)scroll
{
    if (!_scroll) {
           _scroll =[[UIScrollView alloc] init];
        [_scroll setBackgroundColor:[UIColor whiteColor]];
      
        _scroll.pagingEnabled=YES;
        _scroll.clipsToBounds = NO;
        _scroll.delegate=self;

    }
    return _scroll;
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
