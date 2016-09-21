//
//  MyGatherView.h
//  XingHui
//
//  Created by wangpei on 15/8/14.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    MYCREATE=1,
    MYJOIN,
    MYFOCUSBIG,
    MYFOCUSSMALL
}DataType;
@protocol MyGatherViewDelegate;
@interface MyGatherView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UILabel *lb_bottom;
  

}
@property(nonatomic,weak)id<MyGatherViewDelegate>delegate;
@property(nonatomic,strong)NSMutableArray *mydataArr;
@property(nonatomic,strong)NSMutableArray *myJoinArr;
-(void)setMyData:(NSMutableArray *)arr;
-(id)initWithFrame:(CGRect)frame dataType:(NSInteger)dataType;
@end
@protocol MyGatherViewDelegate <NSObject>
-(void)didSelectGather:(NSDictionary *)dic;
-(void)getMyGather:(NSInteger)type;
@end