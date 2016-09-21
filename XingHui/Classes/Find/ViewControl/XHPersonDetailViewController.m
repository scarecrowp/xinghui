//
//  XHPersonDetailViewController.m
//  XingHui
//
//  Created by wangpei on 15/8/23.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHPersonDetailViewController.h"
#import "UIImage+Category.h"
#import "UserManager.h"
#import "ChatViewController.h"
#import "UserProfileManager.h"
#import "XHTagView.h"
#import "UILable+Category.h"
#import "XHUserTagViewController.h"
#import "PassValueDelegate.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import "XHSameFriendCell.h"
#import "XHTagCell.h"
#import "XHJobCell.h"
#import "JKAlertDialog.h"
#import "JSONKit.h"
@interface XHPersonDetailViewController ()<UITableViewDataSource,UITableViewDelegate,PassValueDelegate,TagCellDelegate,TagViewDelegate>
{
    UILabel *lb_actionnum;
    NSArray *tagArr;
    UITableView *tableview;
  
   
}
@property(nonatomic,strong) UIView *view_bottom;
@property(nonatomic,strong) UITextView *tb_tag;
@property(nonatomic,strong)UIView *view_top;
@end

@implementation XHPersonDetailViewController
-(instancetype)initWithUserID:(NSString *)userName
{
    self =[super init];
    if (self) {
        [[XHUserHelper share] getUserFromTell:userName complete:^(XHUser *user){
            self.user = user;
            [tableview reloadData];
        }];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[AciMath getColor:@"f3f3f3"]];
    if ([self iSHaveLookprivacy])
    {
        [self.view addSubview:self.view_bottom];
    }

    tableview=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    
    [tableview registerClass:[XHSameFriendCell class] forCellReuseIdentifier:@"XHSameFriendCell"];
    [tableview registerClass:[XHTagCell class] forCellReuseIdentifier:@"XHTagCell"];
    [tableview registerClass:[XHJobCell class] forCellReuseIdentifier:@"XHJobCell"];
    tableview.fd_debugLogEnabled = YES;
    tableview.delegate=self;
    tableview.dataSource=self;
    [self.view addSubview:tableview];
    tableview.tableFooterView=[UIView new];
    tableview.tableHeaderView=self.view_top;
    [tableview setBackgroundColor:Color(@"f3f3f3")];
    if (_user) {
        [[UserManager share ]getUserDetail:_user.uid finish:^(NSDictionary *dic){
            _user=[[XHUser alloc] initWithDic:dic];
            [tableview reloadData];
        }];
    }
   
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}
#pragma mark - 发起聊天
-(void)ChatAction
{
    ChatViewController *chatVC = [[ChatViewController alloc] initWithChatter:_user.tell isGroup:NO];
    [chatVC setTitle:_user.username];
    [self.navigationController pushViewController:chatVC animated:YES];
}
-(void)didGetDetail:(NSDictionary *)userDic
{
    _user=[[XHUser alloc] initWithDic:userDic];
    [tableview reloadData];
    //  lb_actionnum.text=[NSString stringWithFormat:@"共有%lu个活动",(unsigned long)_user.gatherArr.count];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)lb_actionnum
{

}
#pragma datatableDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        XHSameFriendCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"XHSameFriendCell" forIndexPath:indexPath];
 
        [cell setData:_user.sameFriend];
        return cell;
    }
    else if (indexPath.section==1)
    {
        XHTagCell  *cell=[[XHTagCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XHTagCell" tagArr:_user.tagArr];
        cell.delegate=self;
        cell.tagview.delegate=self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if(indexPath.section==2)
    {
        XHJobCell *cell=[tableview dequeueReusableCellWithIdentifier:@"XHJobCell" forIndexPath:indexPath];
        [cell setData:_user.workHistory[indexPath.row]];
        cell.fd_enforceFrameLayout = YES;
        return cell;
    }
    return nil;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==2) {
        return _user.workHistory.count;
    }
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  3;
}
-(double)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 11;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ids=@"";
    switch (indexPath.section) {
        case 0 : ids=@"XHSameFriendCell"; break;
        case 1 : ids=@"XHTagCell";break;
        case 2 : ids=@"XHJobCell";break;
        default: ids=@"XHSameFriendCell";  break;
    }
       if (indexPath.section==1) {
        UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height;
    }
    else
    {
        float hei =[tableView fd_heightForCellWithIdentifier:ids cacheByIndexPath:indexPath configuration:nil];    NSLog(@"indexPath:%ld   hei:%f",(long)indexPath.section ,hei);
        return hei;
    }
}

-(void)addNewtag
{
     JKAlertDialog *alert = [[JKAlertDialog alloc]initWithTitle:@"添加标签" message:@""];
     alert.contentView =  self.tb_tag;
    [alert addButtonWithTitle:@"取消"];
 
    [alert addButton:Button_OTHER withTitle:@"提交" handler:^(JKAlertDialogItem *item) {
       
        for (NSDictionary *dic in _user.tagArr) {
            if ([dic[@"tag_title"] isEqualToString:_tb_tag.text]) {
                [self showHUDin2s:@"该标签已经存在"];
              
                return ;
            }
            
        }
      
        NSDictionary *duc=@{@"tag_title":_tb_tag.text,@"tag_num":@(1),@"isMe":@"1"};
        [self addtagNetWork:_tb_tag.text];
        NSMutableArray *temp =[NSMutableArray new];
        [temp addObjectsFromArray:_user.tagArr];
        [temp addObject:duc];
        _user.tagArr = temp;
         _tb_tag.text=@"";
        [tableview reloadData];
    }];;
    
    [alert show];
    
//    XHUserTagViewController *tagVC=[[XHUserTagViewController alloc] init];
//    tagVC.passdelegate=self;
//    tagVC.touid=_user.uid;
//    [self.navigationController pushViewController:tagVC animated:YES];
}
#pragma  mark - TagViewDelegate 
-(void)Addtag:(NSString *)tagStr
{
    NSDictionary *param=@{@"tag":tagStr,@"touid":@(_user.uid)};
 
    [[XHNetWork sharedNetWork] Post:[NSString APIURLString:@"addtag.ashx"] parameters:param complete:^(NSDictionary *dic){
        NSMutableArray *temp_arr =[[NSMutableArray alloc] init];
        [temp_arr addObjectsFromArray:_user.tagArr];
        for (NSDictionary *dic in temp_arr) {
            if ([dic[@"tag_title"] isEqualToString:tagStr]) {
                NSDictionary *dicC =@{@"tag_title":tagStr,@"tag_num":@([dic[@"tag_num"] integerValue]+1),@"isMe":@"1"};
                
                NSInteger indx=[temp_arr indexOfObject:dic];
                [temp_arr replaceObjectAtIndex:indx withObject:dicC];
                break;

            }
        }
        _user.tagArr =temp_arr;
        [tableview reloadData];
    }];
}
-(void)removeTag:(NSString *)tagStr
{
    NSDictionary *param=@{@"tag":tagStr,@"touid":@(_user.uid)};
    [[XHNetWork sharedNetWork] Post:[NSString APIURLString:@"removetag.ashx"] parameters:param complete:^(NSDictionary *dic){
      
        NSMutableArray *temp_arr =[[NSMutableArray alloc] init];
        [temp_arr addObjectsFromArray:_user.tagArr];
        for (NSDictionary *dic in temp_arr) {
            if ([dic[@"tag_title"] isEqualToString:tagStr]) {
                if ([dic[@"tag_num"] integerValue]==1) {
                    [temp_arr removeObject:dic];
                    break;
                }
                else
                {
                    NSDictionary *dicC =@{@"tag_title":tagStr,@"tag_num":@([dic[@"tag_num"] integerValue]-1),@"isMe":@"0"};
                    
                    NSInteger indx=[temp_arr indexOfObject:dic];
                    [temp_arr replaceObjectAtIndex:indx withObject:dicC];
                    break;
                }
            }
        }
        _user.tagArr =temp_arr;
         [tableview reloadData];
    }];

}
#pragma mark -
-(void)addtagNetWork:(NSString *)tagstr
{
  
    NSDictionary *param=@{@"tag":tagstr,@"touid":@(_user.uid)};
    [self showHUD:@"正在提交"];
    [[XHNetWork sharedNetWork] Post:[NSString APIURLString:@"addtag.ashx"] parameters:param complete:^(NSDictionary *dic){
        [self hideHud];
       
       
    }];
}
-(void)passbackObject:(id)object sender:(NSString *)sender
{
    
    for (NSDictionary *tag in object) {
        NSDictionary *duc=@{@"tag_title":tag[@"tag_title"],@"tag_num":@(1)};
        [_user.tagArr addObject:duc];
    }
    [tableview reloadData];
}
-(BOOL)iSHaveLookprivacy
{
    if (_user.privacy==0) {
        if (_user.myfriend==1) {
            return YES;
        }
    }
    else if (_user.privacy==1)
    {
        if (_user.myfriend<3) {
            return YES;
        }
    }
    return NO;
}
-(UIView *)view_top
{
    if (!_view_top) {
        _view_top=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*580/640)];
        UIImageView *img_bg=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*580/640)];
        [img_bg setImage:[AciMath getLocationJpgImage:@"persondetail_topbg"]];
        [_view_top addSubview:img_bg];
        
        UIButton *bt_return=[[UIButton alloc] initWithFrame:CGRectMake(0, 20, 44, 44)];
        [bt_return setImage:[UIImage imageNamed:@"bt_return_white@3x"] forState:UIControlStateNormal];
        [bt_return addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_view_top addSubview:bt_return];
        
     
        
        UIImageView *img_head=[[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-80)/2, 20 , 80, 80)];
        [img_head sd_setImageWithURL:[NSURL URLWithString:_user.userpic] placeholderImage:[UIImage imageNamed:@"default_head_img"]];
        img_head.layer.cornerRadius=40;
        img_head.layer.masksToBounds=YES;
        [_view_top addSubview:img_head];
        
        //如果没有权限，把聊天和联系方式隐藏
        if ([self iSHaveLookprivacy]) {
            
            UIButton *bt_call=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
            bt_call.center=CGPointMake([img_head minX]/2, img_head.center.y);
            [bt_call setImage:[UIImage imageNamed:@"bt_call@3x"] forState:UIControlStateNormal];
            [_view_top addSubview:bt_call];
            
            UIButton *bt_message=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
            bt_message.center=CGPointMake([img_head maxX]/2+SCREEN_WIDTH/2, img_head.center.y);
            [bt_message setImage:[UIImage imageNamed:@"bt_message@3x"] forState:UIControlStateNormal];
            [_view_top addSubview:bt_message];
            
            
        }
        UILabel *lb_name2=[[UILabel alloc] initWithFrame:CGRectMake(0, [img_head maxY]+5, SCREEN_WIDTH/2-5, 25)];
        lb_name2.text=_user.userRealName;
        lb_name2.textAlignment=NSTextAlignmentRight;
        [lb_name2 setTextColor:[UIColor whiteColor]];
        [lb_name2 setFont:[UIFont systemFontOfSize:18]];
        
        UILabel *lb_relation=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+5, [img_head maxY]+6, SCREEN_WIDTH/2, 25)];
        switch (_user.myfriend) {
            case 1:
                lb_relation.text=@"一度好友";
                break;
            case 2:
                lb_relation.text=@"二度好友";
                break;
                
            default:
                lb_relation.text=@"三度好友";
                break;
        }
        lb_relation.textAlignment=NSTextAlignmentLeft;
        [lb_relation setTextColor:[UIColor whiteColor]];
        [lb_relation setFont:[UIFont systemFontOfSize:16]];
        [_view_top addSubview:lb_name2];
        [_view_top addSubview:lb_relation];
        
        UILabel *lb_com=[[UILabel alloc] initWithFrame:CGRectMake(0, [lb_name2 maxY]+5, SCREEN_WIDTH, 25)];
        lb_com.text=_user.company;
        [lb_com setTextColor:[UIColor whiteColor]];
        [lb_com setTextAlignment:NSTextAlignmentCenter];
        [_view_top addSubview:lb_com];
        
        UILabel *lb_tell=[[UILabel alloc] initWithFrame:CGRectMake(0, [lb_com maxY], SCREEN_WIDTH, 25)];
        lb_tell.text=[NSString stringWithFormat:@"TEL:%@",_user.tell];
        [_view_top addSubview:lb_tell];
        [lb_tell setTextAlignment:NSTextAlignmentCenter];
        [lb_tell setTextColor:[UIColor whiteColor]];
        
        
        UIView *view_top_bottom=[[UIView alloc] initWithFrame:CGRectMake(0, [lb_tell maxY]+3, SCREEN_WIDTH,58)];
        
        UIView *view_action=[[UIView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH/2, view_top_bottom.height)];
        view_action.alpha=0.3;
        view_action.backgroundColor=[AciMath getColor:@"00784f"];
        [view_top_bottom addSubview:view_action];
        UILabel *lb_action=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, view_action.height/2)];
        lb_action.text=@"他的活动";
        lb_action.textAlignment =NSTextAlignmentCenter;
        [lb_action setTextColor:[UIColor whiteColor]];
        [view_top_bottom addSubview:lb_action];
        lb_actionnum=[[UILabel alloc] initWithFrame:CGRectMake(0, lb_action.maxY, SCREEN_WIDTH/2, view_action.height/2)];
        lb_actionnum.textAlignment = NSTextAlignmentCenter;
        [lb_actionnum setTextColor:[AciMath getColor:@"ffffff"]];
        lb_actionnum.text=@"共有0个活动";
        [view_top_bottom addSubview:lb_actionnum];
        
        UIView *view_right=[[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, view_top_bottom.height)];
        [view_right setBackgroundColor:[AciMath getColor:@"015d19"]];
        view_right.alpha=0.3;
        [view_top_bottom addSubview:view_right];
        UILabel *lb_share=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, view_top_bottom.height/2)];
        lb_share.text=@"他的分享";
        [lb_share setTextAlignment:NSTextAlignmentCenter];
        [lb_share setTextColor:[UIColor whiteColor]];
        [view_top_bottom addSubview:lb_share];
        UILabel *lb_shareNum=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2, lb_share.maxY, SCREEN_WIDTH/2, view_top_bottom.height/2)];
        lb_shareNum.text=[NSString stringWithFormat:@"共0个分享"];
        [lb_shareNum setTextAlignment:NSTextAlignmentCenter];
        [lb_shareNum setTextColor:[UIColor whiteColor]];
        [view_top_bottom addSubview:lb_shareNum];
        
        [_view_top addSubview:view_top_bottom];
        [_view_top setFrame:CGRectMake(0, 0, SCREEN_WIDTH, view_top_bottom.maxY)];
        _view_top.layer.masksToBounds=YES;
        
    }
    return _view_top;
}
-(UIView *)view_bottom
{
    if (!_view_bottom) {
        _view_bottom =[[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
        UIButton *bt_chat=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, 50)];
        [bt_chat setBackgroundColor:[AciMath getColor:@"2ebe00"]];
        [bt_chat setTitle:@"发送消息" forState:UIControlStateNormal];
        [bt_chat addTarget:self action:@selector(ChatAction) forControlEvents:UIControlEventTouchUpInside];
        [_view_bottom addSubview:bt_chat];
        
        UIButton *bt_recommend=[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+1, 0, SCREEN_WIDTH/2-1, 50)];
        [bt_recommend setBackgroundColor:[AciMath getColor:@"2ebe00"]];
        [bt_recommend setTitle:@"推荐给好友" forState:UIControlStateNormal];
        
        [_view_bottom addSubview:bt_chat];
        [_view_bottom addSubview:bt_recommend];
    }
    return _view_bottom;
}
-(UITextView *)tb_tag
{
    if (!_tb_tag) {
        _tb_tag = [[UITextView alloc] initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH-100, 50)];
        _tb_tag.backgroundColor = Color(@"f2f2f2");
    }
    return _tb_tag;
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
