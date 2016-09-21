//
//  XHSelectAtVC.m
//  XingHui
//
//  Created by gaoyuerui on 15/11/10.
//  Copyright © 2015年 wangpei. All rights reserved.
//

#import "XHSelectAtVC.h"

@interface XHSelectAtVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableview;
    NSMutableArray *groupMembers;
    EMGroup *chatgroup;
}
@end

@implementation XHSelectAtVC

- (instancetype)initWithGroup:(EMGroup *)chatGroup
{
    self = [super init];
    if (self) {
        // Custom initialization
        chatgroup =chatGroup;
        tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        NSArray *arr =[NSMutableArray arrayWithArray:chatGroup.occupants];
        groupMembers= [NSMutableArray new];
        for (int i=0;i<arr.count;i++) {
            [[XHUserHelper share] getUserFromTell:[arr objectAtIndex:i] complete:^(XHUser *user){
                [groupMembers addObject:user];
                if (i==arr.count-1) {
                    tableview.delegate=self;
                    tableview.dataSource = self;

                    [tableview reloadData];
                }
            }];
        }
        
    }
    return self;
}

- (instancetype)initWithGroupId:(NSString *)chatGroupId
{
    EMGroup *chatGroup = nil;
    NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
    for (EMGroup *group in groupArray) {
        if ([group.groupId isEqualToString:chatGroupId]) {
            chatGroup = group;
            break;
        }
    }
    
    if (chatGroup == nil) {
        chatGroup = [EMGroup groupWithId:chatGroupId];
    }
    
    self = [self initWithGroup:chatGroup];
    if (self) {
        
        //
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:tableview];
      [self setTitle:@"选择提醒的人"];
    
    // Do any additional setup after loading the view.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return chatgroup.occupants.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:@"cell"];
    UIImageView *img;
    UILabel *lb;
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        img =[[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
        [cell addSubview:img];
        lb = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 100, 40)];
        [cell addSubview:lb];
    }
     XHUser *user= [groupMembers objectAtIndex:indexPath.row];
    [img sd_setImageWithURL:[NSURL URLWithString:user.userpic] placeholderImage:[UIImage imageNamed:@"chatListCellHead.png"]];
      [lb setText:user.userRealName];
    return cell;
}

#pragma mark -s

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_passdelegate passbackObject:[groupMembers objectAtIndex:indexPath.row] sender:@""];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
