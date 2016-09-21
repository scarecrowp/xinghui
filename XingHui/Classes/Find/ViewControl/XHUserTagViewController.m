//
//  XHUserTagViewController.m
//  XingHui
//
//  Created by gaoyuerui on 15/10/12.
//  Copyright © 2015年 wangpei. All rights reserved.
//

#import "XHUserTagViewController.h"
#import "UILable+Category.h"
#import "JSONKit.h"
@interface XHUserTagViewController ()
{
    NSArray *tagArr;
    NSMutableArray *selectTagArr;
}
@end

@implementation XHUserTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tagArr =[[NSArray alloc] initWithObjects:@"UI设计",@"网页设计",@"iOS",@"Android",@"PHP",@"移动应用开发",@"微信应用开发",@"C#",@"JAVA",@".NET", nil];
    [self setTitle:@"选择你的职业标签"];
    selectTagArr =[NSMutableArray new];
    [self.view setBackgroundColor:Color(@"f3f3f3")];
    [self.rightButton setTitle:@"保存" forState:UIControlStateNormal];
    int wSpace=10;
    int x=0;int y=10;
    for(int i=0;i<tagArr.count;i++)
    {
       
        UIButton *bt_tag=[[UIButton alloc] initWithFrame:CGRectMake(x+wSpace,y, 0, 40)];
        [bt_tag setBackgroundColor:Color(@"ffffff")];
        [bt_tag setTitleColor:Color(@"3d3d3d") forState:UIControlStateNormal];
        [bt_tag setTitle:[NSString stringWithFormat:@"%@",tagArr[i]] forState:UIControlStateNormal];
        [bt_tag sizeToFit];
        CGRect rect =bt_tag.frame;
        rect.size.width=rect.size.width+20;
        bt_tag.frame=rect;
        bt_tag.tag=i;
        [bt_tag addTarget:self action:@selector(selectTag:) forControlEvents:UIControlEventTouchUpInside];
        if (bt_tag.maxX>SCREEN_WIDTH) {
            y=y+40;
            x=wSpace;
            CGRect rect=bt_tag.frame;
            rect.origin.x=x;
            rect.origin.y=y;
            [bt_tag setFrame:rect];

        }
      
        x=bt_tag.maxX;
       [self.view addSubview:bt_tag];
        
    }
    
    UIButton *bt_addTag=[[UIButton alloc] initWithFrame:CGRectMake(10, y+40, 80, 40)];
    [bt_addTag.layer setBorderWidth:1.0]; //边框宽度
    [bt_addTag setTitleColor:Color(@"3d3d3d") forState:UIControlStateNormal];
    [bt_addTag setTitle:@"添加" forState:UIControlStateNormal];
 
    
    [bt_addTag.layer setBorderColor:Color(@"c8c8c8").CGColor];//边框颜色
   [self.view addSubview:bt_addTag];

    // Do any additional setup after loading the view.
}
-(void)selectTag:(id)sender
{
    UIButton *bt=(UIButton *)sender;
    BOOL isHas=NO;
    for (NSDictionary *dic in selectTagArr) {
        if ([dic[@"tag_title"] isEqualToString:bt.titleLabel.text]) {
             [selectTagArr removeObject:dic];
            [bt setBackgroundColor:[UIColor whiteColor]];
            [bt setTitleColor:Color(@"3d3d3d") forState:UIControlStateNormal];
            isHas=YES;
            break;
        }
    }
    if (!isHas) {
        NSDictionary *dic = @{ @"tag_title" : bt.titleLabel.text };
        [selectTagArr addObject:dic];
        [bt setBackgroundColor:[UIColor ColorWithHexString:@"2fbe00"]];
        [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
   
   
}
-(void)rightButtonAction
{
    NSString *jsstring=[selectTagArr JSONString];
    NSDictionary *param=@{@"data":jsstring,@"touid":_touid?_touid:@""};
    [self showHUD:@"正在提交"];
    [[XHNetWork sharedNetWork] Post:[NSString APIURLString:@"addtag.ashx"] parameters:param complete:^(NSDictionary *dic){
        [self hideHud];
        [self.navigationController popViewControllerAnimated:YES];
        [_passdelegate passbackObject:selectTagArr sender:@"tag"];
    }];
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
