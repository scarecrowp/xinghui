//
//  XHGatherDetailViewController.m
//  XingHui
//
//  Created by wangpei on 15/7/25.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHGatherDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "UILable+Category.h"
#import "UIImage+Category.h"
#import "CommentCell.h"
#import "GatherDetailManage.h"
#import "GatherDetailBottom.h"
#import "JKAlertDialog.h"
#import "XHUserJoinCell.h"
#import "GatherManage.h"
#import "XHEmptyView.h"
#import "XHPersonDetailViewController.h"
#import "ChatViewController.h"
#import "XHAddFriendVC.h"
#import "UIPlaceHolderTextView.h"
#import "UIViewController+DismissKeyboard.h"
#import "XHMapViewController.h"
#import "XHGatherLocationCell.h"
#import "UIViewController+Share.h"
#import "XHGatherCreaterCell.h"
typedef enum {
    commentX=0,
    FOCUSX=81,
    JOINED =100
}SelectX;
//#import "GatherManage.h"
@interface XHGatherDetailViewController ()<UITableViewDataSource,UITableViewDelegate,ManageDelegate,BottomDelegate,GatherManageDelegate,CommentDelegate,UserCellDelegagte,LocationCellDelegate,XHGatherCreaterCellDelegate>
{
    
    NSMutableDictionary *cellHeiArr;
    UIView *view_comment;
    UITableView *tableview_focus;
    NSMutableArray *focusArr;
    NSMutableArray *joinArr;
    NSInteger currSelect;
    UIView *view_b;
    UIPlaceHolderTextView *txt ;
    GatherManage *gatherManage;
}
@property(nonatomic, strong) UITextField *text_comment;
@property(nonatomic, strong) UIView *comment_top;
@property(nonatomic, strong) UITableView *tableview;
@property(nonatomic, strong) GatherDetailBottom *bottom;
@property(nonatomic, strong) UIToolbar *commitToolBar;
@end

@implementation XHGatherDetailViewController//小型会议详细页面
-(instancetype)initWithTitle:(NSString *)title
{
    self=[super init];
    [self setTitle:title];
    gatherManage=[[GatherManage alloc] init];
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:_gather.title];
    [self.rightButton setImage:[UIImage imageNamed:@"gather_right_bt"] forState:UIControlStateNormal];
    [self.view setBackgroundColor:[AciMath getColor:@"f3f3f3"]];
    
    [self initVar];
    
    [self.view addSubview:self.tableview];
    
    [self.view addSubview:self.bottom];
 
    [gatherManage getGatherComment:_gather.gid page:0];
    [self setupForDismissKeyboard];
}
-(void)rightButtonAction
{
    [self shareContent:_gather.title
             imgUrlStr:_gather.img
              shareUrl:[NSURL URLWithString:[NSString stringWithFormat:@"%@?gid=%@",WapUrl(@"gatherXdetail.aspx"),_gather.gid]]
                 title:_gather.title];
    
}

-(void)initVar
{
    cellHeiArr=[[NSMutableDictionary alloc] init];
    focusArr=[NSMutableArray new];
    joinArr=[NSMutableArray new];
    currSelect=1;
    gatherManage =[GatherManage new];
    gatherManage.delegate=self;
}
#pragma mark - action
-(void)TapAction:(id)sender
{
    UIButton *bt=(UIButton *)sender;
    if (currSelect==bt.tag) {//再次点击当前选项卡，刷新
        if (currSelect==1) {
            [gatherManage getGatherComment:_gather.gid page:0];
        }
        
    }
    else
    {
        currSelect=bt.tag;
        
        [UIView beginAnimations:nil context:nil];//动画开始
        [UIView setAnimationDuration:0.1];
        CGRect rect=view_b.frame;
        rect.origin.x= bt.frame.origin.x;
        view_b.frame = rect;
        [UIView commitAnimations];
        
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
        [_tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
}
-(void)scrollToCurrSelect:(NSInteger)selected
{
    if (currSelect==selected) {
        return;
    }
    currSelect=selected;
    [UIView beginAnimations:nil context:nil];//动画开始
    [UIView setAnimationDuration:0.1];
    CGRect rect=view_b.frame;
    if (selected==2) {
        rect.origin.x= 81;
    }
    else if(selected==3)
    {
        rect.origin.x= SCREEN_WIDTH-80;
    }
    else
    {
        rect.origin.x= 0;
    }
    view_b.frame = rect;
    [UIView commitAnimations];
    
    
}
-(void)didGetComment:(NSDictionary *)dic
{
    if(dic)
    {
        _gather.commentArr=dic[@"comment"];
        _gather.joiner=dic[@"joins"];
        focusArr=dic[@"focus"];
        _tableview.dataSource=self;
        _tableview.delegate=self;
        [_tableview reloadData];
        [self scrollToCurrSelect:1];
        [_bottom setJoinStatus:[dic[@"is_join"] integerValue]==1 isFocus:[dic[@"is_focus"] integerValue]==1];
    }
    
}



#pragma mark -
#pragma mark - view
-(UIView *)comment_top
{
    if (!_comment_top) {
        _comment_top=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 47)];
        [_comment_top setBackgroundColor:[AciMath getColor:@"f3f3f3"]];
        UIView *top = [[UIView alloc] initWithFrame:CGRectMake(0, 7, SCREEN_WIDTH, 40)];
        
        UIFont *font=[UIFont systemFontOfSize:14];
        UIButton *bt_comment=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
        [bt_comment setTitle:@"评论" forState:UIControlStateNormal];
        bt_comment.tag=1;
        [bt_comment.titleLabel setFont:font];
        [bt_comment setTitleColor:[AciMath getColor:@"487eff"] forState:UIControlStateNormal];
        [bt_comment addTarget:self action:@selector(TapAction:) forControlEvents:UIControlEventTouchUpInside];
        [top addSubview:bt_comment];//评论
        
        UIButton *bt_focus=[[UIButton alloc] initWithFrame:CGRectMake(81, 0, 80, 40)];
        [bt_focus setTitle:@"已关注" forState:UIControlStateNormal];
        [bt_focus setTitleColor:[AciMath getColor:@"6f6f6f"] forState:UIControlStateNormal];
        [bt_focus.titleLabel setFont:font];
        bt_focus.tag=2;
        [bt_focus addTarget:self action:@selector(TapAction:) forControlEvents:UIControlEventTouchUpInside];
        [top addSubview:bt_focus];//关注的人
        
        UIButton *bt_join=[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-80, 0, 80, 40)];
        [bt_join setTitle:@"已报名" forState:UIControlStateNormal];
        bt_join.tag=3;
        [bt_join setTitleColor:[AciMath getColor:@"6f6f6f"] forState:UIControlStateNormal];
        [bt_join.titleLabel setFont:font];
        [bt_join addTarget:self action:@selector(TapAction:) forControlEvents:UIControlEventTouchUpInside];
        [top addSubview:bt_join];//关注的人
        
        [top setBackgroundColor:[UIColor whiteColor]];
 
        
        //竖线
        UIView *view_v=[[UIView alloc] initWithFrame:CGRectMake([bt_comment maxX], 13, 1, 17)];
        [view_v setBackgroundColor:[AciMath getColor:@"3f3f3f"]];
        [top addSubview:view_v];
        
        //下划线
        view_b=[[UIView alloc] initWithFrame:CGRectMake(0, 38, 80, 2)];
        [view_b setBackgroundColor:[AciMath getColor:@"487eff"]];
        [top addSubview:view_b];
        [_comment_top addSubview:top];
    }
    return _comment_top;
}
-(UITableView *)tableview
{
    if (!_tableview) {
        _tableview=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-40-64)];
        
        
        UIView *view=[UIView new];
        _tableview.tableFooterView=view;
        [_tableview registerNib:[UINib nibWithNibName:@"top" bundle:nil] forCellReuseIdentifier:@"top"];
  

    }
    return _tableview;
}
-(UIView *)bottom
{
    if (!_bottom) {
        _bottom=[[GatherDetailBottom alloc] init];
        _bottom.delegate=self;

    }
    return _bottom;
}
-(UITextField *)text_comment
{
    if (!_text_comment) {
        _text_comment=[[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-40, 44)];
        _text_comment.backgroundColor=[AciMath getColor:@"f2f2f2"];
    }
    return _text_comment;
}

#pragma mark -
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 3;
       
    }
    else
    {
        switch (currSelect) {
            case 1: return _gather.commentArr.count;  break;
            case 2: return  focusArr.count;     break;
            case 3: return _gather.joiner.count;      break;
            default:                                  break;
        }
        
    }
    return 0;
}
#pragma mark -
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        return self.comment_top;
    }
    else
    {
        return nil;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==1) {
        switch (currSelect) {
            case 1:
            {
                if (_gather.commentArr.count==0) {
                    UIView *empty=[[XHEmptyView alloc] init];
                    return empty;
                }
                
                break;
            }
            case 2:
                if (focusArr.count==0) {
                    return [[XHEmptyView new] init];
                }
                break;
            case 3:
                if (_gather.joiner.count==0) {
                    return [[XHEmptyView new] init];
                }
                break;
            default:
                return nil;
                break;
        }

    }
      return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        return 47;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==1) {
        switch (currSelect) {
            case 1:
            {
                if (_gather.commentArr.count==0) {
                    UIView *view =[[XHEmptyView alloc] init];
                    float he=view.frame.size.height;
                    return he;
                }
                
                break;
            }
            case 2:
                if (focusArr.count==0) {
                    return [[XHEmptyView alloc] init].frame.size.height;
                }
                break;
            case 3:
                if (_gather.joiner.count==0) {
                    return [[XHEmptyView alloc] init].frame.size.height;
                }
                break;
            default:
                return 0;
                break;
        }
    }
   
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (tableView==_tableview) {
        if (indexPath.section==0) {
            if (indexPath.row==0) {
               XHGatherCreaterCell *cell = [_tableview dequeueReusableCellWithIdentifier:@"XHGatherCreaterCell"];
                if (!cell) {
                    cell =[[XHGatherCreaterCell alloc] init];
                }
                [cell setCreaterData:_gather.creater];
                cell.delegate = self;
                return cell;
            }
            else if (indexPath.row==1)
            {
                 cell = [_tableview dequeueReusableCellWithIdentifier:@"title"];
             
                cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"title"];
                UIImageView *img =[[UIImageView alloc] initWithFrame:CGRectMake(18, 8, 16, 16)];
                [img setImage:[UIImage imageNamed:@"gdetail_titleicon"]];
                UILabel *lb_title=[[UILabel alloc] initWithFrame:CGRectMake(40, 6, SCREEN_WIDTH-40-90, 0)];
                [lb_title setFont:[UIFont boldSystemFontOfSize:14]];
                
                lb_title.text =_gather.title;
                lb_title.lineBreakMode = NSLineBreakByCharWrapping;
                [lb_title sizeToFit];
                cell.selectionStyle=UITableViewCellSeparatorStyleNone;
                UILabel *lb_type =[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-90, 6, 80, 22)];
                [lb_type setFont:[UIFont boldSystemFontOfSize:14]];
                [lb_type setTextColor:[AciMath getColor:@"4EAF65"]];
                lb_type.textAlignment=NSTextAlignmentRight;
                lb_type.text=_gather.paytype;
                
                UILabel *lb=[[UILabel alloc] initWithFrame:CGRectMake(23, 32, 6, 6)];
                [lb setBackgroundColor:[AciMath getColor:@"487EFF"]];
                lb.layer.cornerRadius=3;
                lb.layer.masksToBounds=YES;
                
                UILabel *lb_note=[[UILabel alloc] initWithFrame:CGRectMake(40, 28, SCREEN_WIDTH-40-10, 0)];
                lb_note.text=_gather.note;
                [lb_note setTextColor:[AciMath getColor:@"6d6d6d"]];
                [lb_note setFont:[UIFont systemFontOfSize:12]];
                [lb_note setAutoHeight];
                [cell setFrame:CGRectMake(0, 0, SCREEN_WIDTH, [lb_note maxY])];
                [cell addSubview:img];
                [cell addSubview:lb_title];
                [cell addSubview:lb];
                [cell addSubview:lb_note];
                [cell addSubview:lb_type];
                
            }
            else if (indexPath.row==2)
            {
                XHGatherLocationCell *locationCell = [_tableview dequeueReusableCellWithIdentifier:@"location"];
                if (!locationCell) {
                    locationCell = [[XHGatherLocationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"location"];
                }
                [locationCell setData:_gather];
                
                locationCell.delegate = self;
           
                locationCell.selectionStyle=UITableViewCellSeparatorStyleNone;
 
                
                
                return locationCell;
                
                
            }

        }
        else
        {
            if (currSelect==1) {
                CommentCell *ccell= [_tableview dequeueReusableCellWithIdentifier:@"CommentCell"];
                if (!ccell) {
                    ccell=[[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CommentCell"];
                    ccell.delegate=self;
                }
                [ccell setdada:[_gather.commentArr objectAtIndex:indexPath.row]];
                return ccell;
            }
            else if (currSelect==2)//已关注
            {
                XHUserJoinCell *cell= [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"XHUserJoinCell"]];
                if (!cell) {
                    cell=[[XHUserJoinCell alloc] initWithGather:[focusArr objectAtIndex:indexPath.row]];
                    cell.delegate=self;
                }
                return cell;
            }
            else if (currSelect==3)//已参加
            {
                XHUserJoinCell *cell= [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"XHUserJoinCell"]];
                if (!cell) {
                    cell=[[XHUserJoinCell alloc] initWithGather:[_gather.joiner objectAtIndex:indexPath.row]];
                    cell.delegate =self;
                }
                return cell;

            }
        }
    }
      return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    int cellhei;
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    cellhei=cell.frame.size.height;
 
    [cellHeiArr setValue:@(cellhei) forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    return cellhei+10;
   
}
#pragma mark -
-(void)didcomment
{
    [self didcomment:@""];
}

-(void)didcomment:(NSString *)string
{
    
    [self.view addSubview:self.text_comment];
    self.text_comment.hidden = YES;
    self.text_comment.text=[NSString stringWithFormat:@"%@",string];
    self.text_comment.inputAccessoryView = self.commitToolBar;
    [self.text_comment becomeFirstResponder];
    
    [txt becomeFirstResponder];
    
}
-(UIToolbar *)commitToolBar
{
    if (!_commitToolBar) {
        _commitToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        UIBarButtonItem *bt_cancel = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelCommit)];
        txt =[[UIPlaceHolderTextView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-120, 44)];
        [txt setFont:Font(18)];
        txt.placeholder = @"说点什么";
        UIBarButtonItem *textfeil = [[UIBarButtonItem alloc] initWithCustomView:txt];
        
        UIBarButtonItem *bt_done = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(comment)];
        
        [_commitToolBar setItems:@[bt_cancel,textfeil,bt_done] animated:YES];
        
    }
    return _commitToolBar;
}
-(void)comment
{
    [[XHNetWork sharedNetWork] Post:[NSString APIURLString:@"submitcomment.ashx"]
                                  parameters:@{@"uid":@([XHDefaultUser sharedUser].uid),
                                           @"content":txt.text,
                                               @"gid":self.gather.gid}
                                    complete:^(NSDictionary *dic){
                                       txt.text = @"";
                                        [txt resignFirstResponder];
                                        [self.text_comment resignFirstResponder];
                                        [self didGetComment:dic[@"content"]];
                                    }];

}
-(void)cancelCommit
{
    [txt resignFirstResponder];
    [self.text_comment resignFirstResponder];
}
-(void)ToUserDetail:(XHUser *)user
{
    XHPersonDetailViewController *detail =[[XHPersonDetailViewController alloc] init];
    detail.user=user;
    [self.navigationController pushViewController:detail animated:YES];
}
-(void)repayComment:(XHUser *)userss
{
    [self didcomment:[NSString stringWithFormat:@"回复@%@:",userss.userRealName]];
    
}
#pragma mark - 加关注
-(void)didfocus
{
    [self showHUD];
    [[XHNetWork sharedNetWork] Post:[NSString stringWithFormat:@"%@addfocus.ashx",ServerURL]
                         parameters:@{@"gid":_gather.gid}
                           complete:^(NSDictionary *dic){
                               [self showHUDin2s:dic[@"message"]];
                       
                               [self scrollToCurrSelect:2];
                               focusArr=dic[@"focus"];
                               _gather.joiner=dic[@"join"];
                               [_tableview reloadData];
                           } errorMsg:^(NSString *msg){
                                [self showHUDin2s:@"关注失败"];
                           }];
}
#pragma mark - 参加会议
-(void)didJoin
{
    [[XHNetWork sharedNetWork] Post:[NSString stringWithFormat:@"%@join.ashx",ServerURL]
                         parameters:@{@"gid":_gather.gid}
                           complete:^(NSDictionary *dic){
                               [self showHUDin2s:dic[@"message"]];
                               
                               [self scrollToCurrSelect:3];
                               focusArr=dic[@"focus"];
                               _gather.joiner=dic[@"join"];
                               [_tableview reloadData];

                           }errorMsg:^(NSString *msg){
                               [self showHUDin2s:@"关注失败"];
                           }];
}
-(void)addFriend:(NSString *)username realName:(NSString *)realName
{
    XHAddFriendVC *Addfriend = [[XHAddFriendVC alloc] init];
    Addfriend.username =username;
    Addfriend.userRealname = realName;
    [self.navigationController pushViewController:Addfriend animated:YES];
}
#pragma mark - 聊天
-(void)ChatWithUser:(XHUser *)user
{
    ChatViewController *chatVC = [[ChatViewController alloc] initWithChatter:user.tell isGroup:NO];
    [chatVC setRealName:user.userRealName];
    [self.navigationController pushViewController:chatVC animated:YES];
}
#pragma mark -关注和参加的回调
-(void)didRequestSuccess:(NSDictionary *)obj
{
   focusArr=obj[@"focus"];
    _gather.joiner=obj[@"join"];
    [_tableview reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -LocationCellDelegate
-(void)ToLocationMap
{
//    CLLocationCoordinate2D loc =CLLocationCoordinate2DMake([_gather.lat floatValue], [_gather.lon floatValue]);
    XHMapViewController *xhmap = [[XHMapViewController alloc] initWithLocation:_gather.gpsCoordinate];
    [self.navigationController pushViewController:xhmap animated:YES];
    
}
#pragma mark -
#pragma mark - XHGatherCreaterCellDelegate

-(void)ToCreaterDetail
{
    [self ToUserDetail:_gather.creater];
}
@end

@implementation CommentHeadview
-(id)initWithTitle:(NSString *)title
{
    self=[super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 55)];
    self.lb_title.text=title;
    self.backgroundColor=[AciMath getColor:@"f3f3f3"];
    [self.lb_title setFrame:CGRectMake(10, 0, SCREEN_WIDTH-10, 55)];
    [self addSubview:self.lb_title];
    return self;
}
-(void)settitile:(NSString *)title
{
    self.lb_title.text=title;
}
@end