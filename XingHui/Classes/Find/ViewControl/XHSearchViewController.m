//
//  XHSearchViewController.m
//  XingHui
//
//  Created by gaoyuerui on 15/9/18.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHSearchViewController.h"
#import "UserManager.h"
@interface XHSearchViewController ()<UISearchDisplayDelegate,UISearchBarDelegate>
@property(nonatomic,strong)UISearchBar *searchBar;
@end

@implementation XHSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.rightButton setHidden:YES];
     [self.topNavView addSubview:self.searchBar];
    [self.view setBackgroundColor:Color(@"3f3f3f")];
    // Do any additional setup after loading the view.
} 
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_searchBar becomeFirstResponder];
}
-(void)leftButtonAction
{
    [super leftButtonAction];
    [_searchBar resignFirstResponder];
}
-(UISearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar=[[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-100, 44)];
 
        _searchBar.delegate=self;
        [_searchBar setBackgroundImage:[UIImage imageNamed:@"empty.png"]];
      
       //_searchBar.hidden=YES;

    }
    return _searchBar;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}      
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
   
}
#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    //  [searchBar setShowsCancelButton:YES animated:YES];
    
    return YES;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    _searchBar.text = @"";
  
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [[UserManager share] searchFriend:@{@"key":_searchBar.text} complete:^(NSMutableArray *arr){
        self.friendArr=arr;
        // friendArr=  [self sortDataArray:friendArr];
        [self tableReload];
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

@end
