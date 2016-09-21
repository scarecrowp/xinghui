//
//  XHJobDatePickView.h
//  XingHui
//
//  Created by wangpei on 15/8/27.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PickViewDelegate;
@interface XHJobDatePickView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSMutableArray *beginArray;
    NSMutableArray *endArray;
}
@property(nonatomic,weak)id<PickViewDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIPickerView *datePick;
- (IBAction)cancelAction:(id)sender;
- (IBAction)DoneAction:(id)sender;
- (void)showPickView;
@end
@protocol PickViewDelegate <NSObject>
-(void)didSelectTime:(NSString *)begintime endtime:(NSString *)endTime;
@end