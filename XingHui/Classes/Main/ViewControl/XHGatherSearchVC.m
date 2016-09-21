//
//  XHGatherSearchVC.m
//  XingHui
//
//  Created by gaoyuerui on 15/10/23.
//  Copyright © 2015年 wangpei. All rights reserved.
//

#import "XHGatherSearchVC.h"
#import "EMSearchBar.h"
#import "MyGatherView.h"
#import "XHHomeTableView.h"
#import "GatherManage.h"
@interface XHGatherSearchVC ()<UISearchBarDelegate,XHHomeTableViewDelegate>
{
    XHHomeTableView *homeTable;
    GatherManage *gatherManage;
}
@property (nonatomic)  UISearchBar *searchBar;
@end

@implementation XHGatherSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
     [self.view setBackgroundColor:Color(@"ebdfdf")];
    gatherManage=[GatherManage new];
    homeTable =[[XHHomeTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    homeTable.homedelegate=self;
    [self.view addSubview:homeTable];
    [self setSearchTextFieldBackgroundColor:Color(@"ebdfdf")];
    self.navigationController.navigationBar.backgroundColor =Color(@"3c3c3c");
   // [gatherManage getNearGather:1];
    UIBarButtonItem *searchBarItem = [[UIBarButtonItem alloc] initWithCustomView:self.searchBar];
    self.navigationItem.leftBarButtonItem = searchBarItem;
    
    
    
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.searchBar becomeFirstResponder];
}

- (void)setSearchTextFieldBackgroundColor:(UIColor *)backgroundColor
{
      UIView *searchTextField = nil;
       if (IOS7) {
            // 经测试, 需要设置barTintColor后, 才能拿到UISearchBarTextField对象
        
              searchTextField = [[[self.searchBar.subviews firstObject] subviews] lastObject];
          } else { // iOS6以下版本searchBar内部子视图的结构不一样
                  for (UIView *subView in self.searchBar.subviews) {
                           if ([subView isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
                                  searchTextField = subView;
                             }
                      }
                }
    
        searchTextField.backgroundColor = backgroundColor;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UISearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar=[[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-40, 44)];
        _searchBar.delegate=self;
        _searchBar.showsCancelButton = YES;
        _searchBar.placeholder=@"搜索";
        _searchBar.tintColor =Color(@"3c3c3c");
        // 修改UISearchBar右侧的取消按钮文字颜色及背景图片
        for (UIView *searchbuttons in [_searchBar subviews]){
            if ([searchbuttons isKindOfClass:[UIButton class]]) {
                UIButton *cancelButton = (UIButton*)searchbuttons;
                // 修改文字颜色
                [cancelButton setTitleColor:Color(@"3c3c3c") forState:UIControlStateNormal];
                [cancelButton setTitleColor:Color(@"3c3c3c") forState:UIControlStateHighlighted];
                [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
 
            }
        }
    }
    return _searchBar;
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    _searchBar.text = @"";
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [[XHNetWork sharedNetWork] Get:[NSString APIURLString:@"gatherlist.ashx"]
                             param:@{@"key":self.searchBar.text}
                          complete:^(NSDictionary *dic){
                              [homeTable storeArr:dic[@"content"] ];
                              [homeTable reloadData];
                          }
                          errorMsg:^(NSString *msg){
        
                          }
     ];
   
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)hsearchBar {
    self.searchBar.showsCancelButton = YES;
    for(id cc in [self.searchBar subviews])
    {
        if([cc isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)cc;
            [btn setTitle:@"取消"  forState:UIControlStateNormal];
        }
    }
}
@end
