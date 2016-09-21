//
//  XHDatePicker.m
//  XingHui
//
//  Created by wangpei on 15/6/16.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHDatePicker.h"
#define currentMonth [currentMonthString integerValue]

@implementation XHDatePicker
{
    NSMutableArray *yearArray;
    NSArray *monthArray;
    NSMutableArray *DaysArray;
    NSArray *amPmArray;
    NSMutableArray *hoursArray;
    NSMutableArray *minutesArray;
    
    NSString *currentMonthString;
    
    int selectedYearRow;
    int selectedMonthRow;
    int selectedDayRow;
    
    BOOL firstTimeLoad;

}
-(id)initWithFrames:(CGRect)frame
{
   
    self=[super initWithFrame:frame];
  //  self =  [[[NSBundle mainBundle] loadNibNamed:@"XHDatePicker"owner:nil options:nil] objectAtIndex:0];
    
    if (self) {
        [self setBackgroundColor:Color(@"cccccc")];
        NSDate *date = [NSDate date];
         [self setFrame:frame];
        [self addSubview:self.datepicker];
        [self addSubview:self.bt_cancel];
        [self addSubview:self.bt_done];
        // Get Current Year
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy"];
        
        NSString *currentyearString = [NSString stringWithFormat:@"%@",
                                       [formatter stringFromDate:date]];
        // Get Current  Month
        
        [formatter setDateFormat:@"MM"];
        
        currentMonthString = [NSString stringWithFormat:@"%d",[[formatter stringFromDate:date]integerValue]];
        
        
        // Get Current  Date
        
        [formatter setDateFormat:@"dd"];
        NSString *currentDateString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
        
        // Get Current  Hour
        [formatter setDateFormat:@"HH"];
        NSString *currentHourString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
        
 
     
        
        // PickerView -  Years data
        
        yearArray = [[NSMutableArray alloc]init];
        
        
        for (int i = 1970; i <= 2050 ; i++)
        {
            [yearArray addObject:[NSString stringWithFormat:@"%d",i]];
            
        }
        monthArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"];
        
        
        // PickerView -  Hours data
        hoursArray =[NSMutableArray new];
        
        // hoursArray = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12"];
        for (int i = 0; i < 24; i++)
        {
            
            [hoursArray addObject:[NSString stringWithFormat:@"%02d",i]];
            
        }
   
        minutesArray = [[NSMutableArray alloc]init];
        [minutesArray addObject:@"00"];
        [minutesArray addObject:@"30"];
        
        amPmArray = @[@"AM",@"PM"];
        
        
        
        // PickerView -  days data
        
        DaysArray = [[NSMutableArray alloc]init];
        
        for (int i = 1; i <= 31; i++)
        {
            if (i<10) {
                [DaysArray addObject:[NSString stringWithFormat:@"0%d",i]];
            }
            else
            {
                [DaysArray addObject:[NSString stringWithFormat:@"%d",i]];
            }
        }
        
        self.datepicker.delegate=self;
        self.datepicker.dataSource=self;
        // PickerView - Default Selection as per current Date
        
        [self.datepicker selectRow:[yearArray indexOfObject:currentyearString] inComponent:0 animated:YES];
        
        [self.datepicker selectRow:[monthArray indexOfObject:currentMonthString] inComponent:1 animated:YES];
        
        [self.datepicker selectRow:[DaysArray indexOfObject:currentDateString] inComponent:2 animated:YES];
        
        [self.datepicker selectRow:[hoursArray indexOfObject:currentHourString] inComponent:3 animated:YES];
        
        [self.datepicker selectRow:1 inComponent:4 animated:YES];
        [self setContaint];
    }
    return self;
}
-(void)setContaint
{
    WS(ws);
    [self.bt_cancel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(ws);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(80);
        make.top.equalTo(ws);
        
    }];
    [self.bt_done mas_makeConstraints:^(MASConstraintMaker *make){
    //    make.right.mas_equalTo(SCREEN_WIDTH-280);
        make.left.mas_equalTo(SCREEN_WIDTH-80);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(80);
        make.top.equalTo(ws);

    }];
    [_datepicker mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(ws);
        make.top.equalTo(_bt_cancel.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
      //  make.height.mas_equalTo(165);
        //    make.right.equalTo(_toolbar);
        make.bottom.equalTo(ws);
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
#pragma mark - UIPickerViewDelegate


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    
    if (component == 0)
    {
        selectedYearRow = row;
        [self.datepicker reloadAllComponents];
    }
    else if (component == 1)
    {
        selectedMonthRow = row;
        [self.datepicker reloadAllComponents];
    }
    else if (component == 2)
    {
        selectedDayRow = row;
        
        [self.datepicker reloadAllComponents];
        
    }
    
}


#pragma mark - UIPickerViewDatasource

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view {
    
    // Custom View created for each component
    
    UILabel *pickerLabel = (UILabel *)view;
    
    if (pickerLabel == nil) {
        CGRect frame = CGRectMake(0, 0.0, SCREEN_WIDTH/5, 60);
        pickerLabel = [[UILabel alloc] initWithFrame:frame];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:15.0f]];
    }
    if (component == 0)
    {
        pickerLabel.text = [NSString stringWithFormat:@"%@年", [yearArray objectAtIndex:row]]; // Year
        pickerLabel.textAlignment=NSTextAlignmentRight;
    }
    else if (component == 1)
    {
        pickerLabel.text = [NSString stringWithFormat:@"%@月",[monthArray objectAtIndex:row]];  // Month
    }
    else if (component == 2)
    {
        pickerLabel.text =  [NSString stringWithFormat:@"%@日",[DaysArray objectAtIndex:row]]; // Date
        pickerLabel.textAlignment=NSTextAlignmentLeft;
        
    }
    else if (component == 3)
    {
        pickerLabel.text =  [hoursArray objectAtIndex:row]; // Hours
    }
    else if (component == 4)
    {
        pickerLabel.text =  [minutesArray objectAtIndex:row]; // Mins
    }
    else
    {
        pickerLabel.text =  [amPmArray objectAtIndex:row]; // AM/PM
    }
    
    return pickerLabel;
    
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 5;
    
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if (component == 0)
    {
        return [yearArray count];
        
    }
    else if (component == 1)
    {
        return [monthArray count];
    }
    else if (component == 2)
    { // day
        
        if (firstTimeLoad)
        {
            if (currentMonth == 1 || currentMonth == 3 || currentMonth == 5 || currentMonth == 7 || currentMonth == 8 || currentMonth == 10 || currentMonth == 12)
            {
                return 31;
            }
            else if (currentMonth == 2)
            {
                int yearint = [[yearArray objectAtIndex:selectedYearRow]intValue ];
                
                if(((yearint %4==0)&&(yearint %100!=0))||(yearint %400==0)){
                    
                    return 29;
                }
                else
                {
                    return 28; // or return 29
                }
                
            }
            else
            {
                return 30;
            }
            
        }
        else
        {
            
            if (selectedMonthRow == 0 || selectedMonthRow == 2 || selectedMonthRow == 4 || selectedMonthRow == 6 || selectedMonthRow == 7 || selectedMonthRow == 9 || selectedMonthRow == 11)
            {
                return 31;
            }
            else if (selectedMonthRow == 1)
            {
                int yearint = [[yearArray objectAtIndex:selectedYearRow]intValue ];
                
                if(((yearint %4==0)&&(yearint %100!=0))||(yearint %400==0)){
                    return 29;
                }
                else
                {
                    return 28; // or return 29
                }
                
                
                
            }
            else
            {
                return 30;
            }
            
        }
        
        
    }
    else if (component == 3)
    { // hour
        
        return 24;
        
    }
    else if (component == 4)
    { // min
        return 2;
    }
    else
    { // am/pm
        return 2;
        
    }
    
    
    
}
- (IBAction) actionCancel:(id)sender
{
    
    [_pickerdelegate cancel];
    
    
}
- (IBAction) cancelSelect:(id)sender {
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         self.hidden=YES;
                         
                         
                     }
                     completion:^(BOOL finished){
                         
                         
                     }];
}

- (IBAction) selectDate:(id)sender {
    [_pickerdelegate selectdone:[NSString stringWithFormat:@"%@-%@-%@ %@:%@ ",[yearArray objectAtIndex:[self.datepicker selectedRowInComponent:0]],[monthArray objectAtIndex:[self.datepicker selectedRowInComponent:1]],[DaysArray objectAtIndex:[self.datepicker selectedRowInComponent:2]],[hoursArray objectAtIndex:[self.datepicker selectedRowInComponent:3]],[minutesArray objectAtIndex:[self.datepicker selectedRowInComponent:4]]]];
    //
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         self.hidden=YES;
                         
                     }
                     completion:^(BOOL finished){
                         
                         
                     }];
    //
}
- (UIPickerView *) datepicker
{
    if (!_datepicker) {
        _datepicker =[[UIPickerView alloc] init];
        [_datepicker setBackgroundColor:Color(@"ffffff")];
    }
    return _datepicker;
}
-(UIButton *) bt_cancel
{
    if (!_bt_cancel) {
        _bt_cancel =[[UIButton alloc] init];
        [_bt_cancel setTitle:@"取消" forState:UIControlStateNormal];
        [_bt_cancel addTarget:self action:@selector(actionCancel:)];
    }
    return _bt_cancel;
}
-(UIButton *) bt_done
{
    if (!_bt_done) {
        _bt_done = [[UIButton alloc] init];
        [_bt_done setTitle:@"确认" forState:UIControlStateNormal];
        [_bt_done addTarget:self action:@selector(selectDate:)];
    }
    return _bt_done;
}
@end
