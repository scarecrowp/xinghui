//
//  XHDatePicker.h
//  XingHui
//
//  Created by wangpei on 15/6/16.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DatePickerDeleGate;
@interface XHDatePicker : UIView<UIPickerViewDataSource,UIPickerViewDelegate>
@property (strong, nonatomic) UIPickerView *datepicker;
@property (nonatomic,strong)UIButton *bt_cancel;
@property(nonatomic,strong)UIButton *bt_done;
- (IBAction) cancelSelect:(id)sender;
- (IBAction) selectDate:(id)sender;
- (id) initWithFrames:(CGRect)frame;
@property(nonatomic,weak)id<DatePickerDeleGate> pickerdelegate;
@end
@protocol DatePickerDeleGate <NSObject>

-(void)selectdone:(NSString *)datestr;
@optional
-(void)cancel;
@end