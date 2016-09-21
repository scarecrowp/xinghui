//
//  XHJobDatePickView.m
//  XingHui
//
//  Created by wangpei on 15/8/27.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHJobDatePickView.h"

@implementation XHJobDatePickView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame
{
    
    self =  [[[NSBundle mainBundle] loadNibNamed:@"XHJobDatePickView"owner:nil options:nil] objectAtIndex:0];
    if (self) {
        [self setFrame:frame];
        beginArray=[NSMutableArray new];
        for (int i = 2015; i >=1970; i--)
        {
            [beginArray addObject:[NSString stringWithFormat:@"%d",i]];
            
        }
        endArray=[NSMutableArray new];
        [endArray addObject:@"至今"];
        for (int i = 2015; i>= 1970; i--)
        {
            [endArray addObject:[NSString stringWithFormat:@"%d",i]];
        }
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy"];
        _datePick.delegate=self;
        _datePick.dataSource=self;
         NSDate *date = [NSDate date];
       NSString *currentyearString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
        
     //   [self.datePick selectRow:0 inComponent:0 animated:YES];
        [self.datePick selectRow:[beginArray indexOfObject:currentyearString] inComponent:0 animated:YES];
        
        [self.datePick selectRow:0 inComponent:1 animated:YES];
       // self.hidden=YES;
    }
    return self;
}
-(void)showPickView
{
 
//    [UIView animateWithDuration:0.5
//                          delay:0.1
//                        options: UIViewAnimationOptionCurveEaseIn
//                     animations:^{
//                         
//                         self.hidden=NO;
//                         
//                     }
//                     completion:^(BOOL finished){
//                         
//                         
//                     }];
  self.hidden=NO;
}


#pragma mark - UIPickerViewDatasource

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view {
    
    // Custom View created for each component
    
    UILabel *pickerLabel = (UILabel *)view;
    
    if (pickerLabel == nil) {
        CGRect frame = CGRectMake(0, 0.0, SCREEN_WIDTH/4, 40);
        pickerLabel = [[UILabel alloc] initWithFrame:frame];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
      //  [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:15.0f]];
    }
    pickerLabel.backgroundColor=[UIColor whiteColor];
    if (component==1) {
         pickerLabel.text = [NSString stringWithFormat:@"%@年", [endArray objectAtIndex:row]]; // Year
    }
   else
   {
        pickerLabel.text = [NSString stringWithFormat:@"%@年", [beginArray objectAtIndex:row]]; // Year
   }
    pickerLabel.textAlignment=NSTextAlignmentCenter;
    
    return pickerLabel;
    
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
    {
        return [beginArray count];
        
    }
    else if (component == 1)
    {
        return [endArray count];
    }
    return 0;
}
- (IBAction)actionCancel:(id)sender
{
    
    
    
}
- (IBAction)cancelSelect:(id)sender {
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.hidden=YES;
                     }
                     completion:^(BOOL finished){
                         
                         
                     }];
}

- (IBAction)selectDate:(id)sender {
       //
}

- (IBAction)cancelAction:(id)sender {
    //
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.hidden=YES;
                     }
                     completion:^(BOOL finished){
                         
                         
                     }];

}

- (IBAction)DoneAction:(id)sender {
  
    [_delegate didSelectTime:[beginArray objectAtIndex:[self.datePick selectedRowInComponent:0]]
                     endtime:[endArray objectAtIndex:[self.datePick selectedRowInComponent:1]]];
    //
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.hidden=YES;
                         
                     }
                     completion:^(BOOL finished){
                         
                         
                     }];

}
@end
