//
//  XHSetIndustryViewController.m
//  XingHui
//
//  Created by wangpei on 15/8/25.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHSetIndustryViewController.h"
#import "FSDropDownMenu.h"
#import "TouchXML.h"
@interface XHSetIndustryViewController ()<FSDropDownMenuDataSource,FSDropDownMenuDelegate,PassValueDelegate>
{
    FSDropDownMenu *menu;
    NSMutableArray *menuArr;
    NSInteger chosesection;
    NSInteger row;
}
@property(nonatomic,strong) NSArray *currentAreaArr;
@end

@implementation XHSetIndustryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"选择你的从事行业"];
    menu = [[FSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 0) andHeight:SCREEN_HEIGHT-64];
    NSString *XMLPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"industry.xml"];
    NSData *XMLData   = [NSData dataWithContentsOfFile:XMLPath];
    CXMLDocument *doc = [[CXMLDocument alloc] initWithData:XMLData options:0 error:nil];
    menuArr=[NSMutableArray new];
    NSArray *nodes = NULL;
    //  searching for piglet nodes
    nodes = [doc nodesForXPath:@"//firstlevel" error:nil];
    for (CXMLElement *node in nodes) {
        NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
        
        //  and here it is - attributeForName! Simple as that.
        [item setObject:[[node attributeForName:@"id"] stringValue] forKey:@"id"];
        [item setObject:[[node attributeForName:@"name"] stringValue] forKey:@"name"];
        
      //  NSArray *subArr=[node children];
        NSMutableArray *subArr=[NSMutableArray new];
        for (CXMLElement *element in [node children])
         {
             if ([element isKindOfClass:[CXMLElement class]]) {
                 NSMutableDictionary *items = [[NSMutableDictionary alloc] init];
                 [items setObject:[[element attributeForName:@"id"] stringValue] forKey:@"id"];
                 [items setObject:[[element attributeForName:@"name"] stringValue] forKey:@"name"];
                 [subArr addObject:items];
             }
             
         }
        [item setObject:subArr forKey:@"arr"];
        
        [menuArr addObject:item];
    }

    _currentAreaArr = [[menuArr objectAtIndex:0] objectForKey:@"arr"];
    menu.delegate=self;
    menu.transformView =nil;
    menu.tag = 1001;
    menu.dataSource = self;
 
    [self.view addSubview:menu];
    [menu menuTapped];
    // Do any additional setup after loading the view.
}
- (NSInteger)menu:(FSDropDownMenu *)amenu tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == amenu.rightTableView) {
        return menuArr.count;
    }else{
        return _currentAreaArr.count;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSString *)menu:(FSDropDownMenu *)amenu tableView:(UITableView*)tableView titleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == amenu.rightTableView) {
        return [menuArr[indexPath.row] objectForKey:@"name"];
        
    }else{
        
        return _currentAreaArr[indexPath.row][@"name"];
    }
}


- (void)menu:(FSDropDownMenu *)amenu tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(tableView == amenu.rightTableView){
        //[[[[menuArr objectAtIndex:indexPath.row] objectForKey:@"goods_type_tids"] objectAtIndex:index] objectForKey:@"name"]
        chosesection = indexPath.row;
        _currentAreaArr = [[menuArr objectAtIndex:indexPath.row] objectForKey:@"arr"];
        [menu.leftTableView reloadData];
    }else{
        [self resetItemSizeBy:_currentAreaArr[indexPath.row][@"name"]];
        row=indexPath.row;
        NSDictionary *dic = @{@"name1":[[menuArr objectAtIndex:chosesection] objectForKey:@"name"],
                            @"name2":[_currentAreaArr[indexPath.row] objectForKey:@"name"],
                            @"id":[_currentAreaArr[indexPath.row] objectForKey:@"id"]};
        [self.passdelegate passbackObject:dic sender:@"industry"];
        [self.navigationController popViewControllerAnimated:YES];
      //   tid =_currentAreaArr[indexPath.row][@"tid"];
      //  [self doSerch];
    }
    
}
-(void)resetItemSizeBy:(NSString*)str{
  //  [_topview.bt_goodtype setTitle:str forState:UIControlStateNormal];
    
    //	UIButton *btn = (UIButton*)self.navigationItem.rightBarButtonItem.customView;
    //	[btn setTitle:str forState:UIControlStateNormal];
    //	NSDictionary *dict = @{NSFontAttributeName:btn.titleLabel.font};
    //	CGSize size = [str boundingRectWithSize:CGSizeMake(150, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    //	btn.frame = CGRectMake(btn.frame.origin.x, btn.frame.origin.y,size.width+33, 30);
    //	btn.imageEdgeInsets = UIEdgeInsetsMake(11, size.width+23, 11, 0);
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
