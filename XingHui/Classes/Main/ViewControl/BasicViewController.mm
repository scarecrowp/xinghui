//
//  BasicViewController.m
//  QiaoGu
//
//  Created by JackLiu on 14-8-11.
//  Copyright (c) 2014年 ZXInsight. All rights reserved.
//
#import "BasicViewController.h"
#import "AppDelegate.h"
//navigationItem.titleView的最大宽度为188，若超过会自动裁剪为188
#define nav_mid_view_width 188
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "JSONKit.h"
@interface BasicViewController ()<MBProgressHUDDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UIGestureRecognizerDelegate>
{
   
}
@property(nonatomic,strong) AFHTTPRequestOperationManager *bClient;
@end

@implementation BasicViewController

@synthesize topNavView = _topNavView;
@synthesize leftButton = _leftButton;
@synthesize rightButton = _rightButton;
@synthesize titleLabel = titleLabel;

@synthesize isEnterForeground = _isEnterForeground;


-(instancetype)init
{
    self = [super init];
    if (self) {
        // [self.view setBackgroundColor:[UIColor whiteColor]];
        // Do any additional setup after loading the view.
        if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
        {
            [self setEdgesForExtendedLayout:UIRectEdgeNone];
        }
        //    self.navigationController.navigationBarHidden=YES;
        //    UIView *top=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
        //    [top setBackgroundColor:[UIColor whiteColor]];
        //    [self.view addSubview:top];
        
        
        //  self.navigationItem.hidesBackButton = YES;
        [self.navigationController.navigationBar setTintColor:[UIColor clearColor]];
        _topNavView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-132, 44)];
        _topNavView.backgroundColor = [UIColor clearColor];
        self.navigationItem.titleView = _topNavView;
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH-132, 44)];
        titleLabel.font = [UIFont fontWithName:@"Avenir-Black" size:20];
        //titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [titleLabel setTextColor:Color(@"3c3c3c")];
        [self.navigationItem.titleView addSubview:titleLabel];
        
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftButton setFrame:CGRectMake(0, 20, 44, 44)];
        //  _leftButton.imageEdgeInsets = UIEdgeInsetsMake(0,-20, 0, 14);
        
        [_leftButton addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setFrame:CGRectMake(SCREEN_WIDTH-44, 20, 44, 44)];
        _rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
        [_rightButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        [_rightButton setTitleColor:[AciMath getColor:@"787878"] forState:UIControlStateNormal];
        UITapGestureRecognizer *viewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(topNavTapAction)];
        [_topNavView addGestureRecognizer:viewTap];
        [viewTap setNumberOfTapsRequired:1];
        [_leftButton setImage:[UIImage imageNamed:@"bt_return"] forState:UIControlStateNormal];
        //处理按钮偏右的问题
        UIBarButtonItem *backNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:_leftButton];
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems = @[negativeSpacer, backNavigationItem];
        
        UIBarButtonItem *rightItem=[[UIBarButtonItem alloc] initWithCustomView:_rightButton];
        self.navigationItem.rightBarButtonItems =  @[negativeSpacer, rightItem];
        // [top addSubview:_leftButton];
        //[top addSubview:_rightButton];
        self.appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    }
    return  self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
   }

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(IOS7){
        
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
        
    }
    _isEnterForeground = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    _isEnterForeground = NO;
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.navigationController.delegate = nil;
}
- (void)leftButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];

}
- (void)rightButtonAction
{
    
}
- (void)topNavTapAction
{

}
- (void)hideKayBoard
{
     [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}



- (void)setTitle:(NSString *)title
{
    titleLabel.text = title;
}
- (AFHTTPRequestOperationManager *)bClient
{
    if (!_bClient) {
        _bClient=[AFHTTPRequestOperationManager manager];
        [_bClient.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        _bClient.requestSerializer.timeoutInterval = 10.f;
        [_bClient.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
    }
    return _bClient;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

 
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
