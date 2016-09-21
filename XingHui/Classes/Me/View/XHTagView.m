//
//  XHTagView.m
//  XingHui
//
//  Created by wangpei on 15/8/31.
//  Copyright (c) 2015年 wangpei. All rights reserved.
//

#import "XHTagView.h"
#import "UILable+Category.h"

@implementation XHTagView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithArr:(NSMutableArray *)arr
{
    
    self=[super initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 0)];
  //  [self setTagArr:arr];
   
    return self;
}
-(float)setTagArr:(NSArray *)arr
{
    int x=0;
    int y=5;
    int space=10;
    int lineHeight=40;
    for (int i=0; i<arr.count; i++) {
        NSDictionary *dic=[arr objectAtIndex:i];
        TagView *view_tag=[[TagView alloc] initWithdata:dic];
        
        [view_tag setFrame:CGRectMake(x+space,y, view_tag.frame.size.width,27)];
        [view_tag addTarget:self action:@selector(addtag:)];
        if (view_tag.maxX>SCREEN_WIDTH) {
            y=y+lineHeight;
            x=5;
           [view_tag setFrame:CGRectMake(x+space,y, view_tag.frame.size.width,27)];
            
            NSLog(@"i:%d 换行：%@ x:%d",i,arr[i][@"tag_title"]  ,x+space);
        }
        else
        {
            NSLog(@"i: %d %@ x:%d 下一个：%f",i,arr[i][@"tag_title"],x+space,view_tag.maxX);
            
        }
        
        [self addSubview:view_tag];
        x=view_tag.maxX;
    }
    [self setHeight:y+40-5];
    return y+40-5;
}
-(void)addtag:(id)sender
{
    UITapGestureRecognizer *tap =sender;
    
     TagView *view_tag =(TagView *)tap.view;
    
    if (view_tag.tag==1) {
//        view_tag.lb_num.text =[NSString stringWithFormat:@"%ld",[view_tag.lb_num.text integerValue]-1];
//        [view_tag.bg setImage:[AciMath getScImage:@"tag_bg@3x" top:0 bottom:0 left:14 right:14]];
//        view_tag.lb_num.backgroundColor=[AciMath getColor:@"14ad00"];
        [_delegate removeTag:view_tag.lb_tag.text];
    }
    else
    {
         [_delegate Addtag:view_tag.lb_tag.text];
//         view_tag.lb_num.text =[NSString stringWithFormat:@"%ld",[view_tag.lb_num.text integerValue]+1];
//       
//      
//        [view_tag.bg setImage:[AciMath getScImage:@"tag_bg_isme@3x" top:0 bottom:0 left:14 right:14]];
//        view_tag.lb_num.backgroundColor=[AciMath getColor:@"166ced"];

    }
     view_tag.tag=1-view_tag.tag;
}
@end

@implementation TagView

-(instancetype)initWithdata:(NSDictionary *)dic
{
   
    self=[super init];
    if (self) {
      
        _bg=[[UIImageView alloc] init];
        _lb_tag=[[UILabel alloc] initWithFrame:CGRectMake(14, 0, 0, 27)];
        _lb_tag.text=[dic[@"tag_title"] ToString];
        [_lb_tag setTextColor:[AciMath getColor:@"ffffff"]];
        int w=[_lb_tag widthWithTitle];
        CGRect rct=_lb_tag.frame;
        rct.size.width=w+5;
        [_lb_tag setFrame:rct];
        
        [_bg setFrame:CGRectMake(0, 0, 14+w+14+14, 27)];

        _lb_num=[[UILabel alloc] initWithFrame:CGRectMake(_bg.frame.size.width-27, 0, 27, 27)];
        _lb_num.layer.cornerRadius=14;
        _lb_num.layer.masksToBounds=YES;
        [_lb_num setTextAlignment:NSTextAlignmentCenter];
        [_lb_num setTextColor:[AciMath getColor:@"ffffff"]];
        if ([dic[@"isMe"] isEqualToString:@"1"]) {
            [_bg setImage:[AciMath getScImage:@"tag_bg_isme@3x" top:0 bottom:0 left:14 right:14]];
            _lb_num.backgroundColor=[AciMath getColor:@"166ced"];
            self.tag=1;
        }
        else
        {
            [_bg setImage:[AciMath getScImage:@"tag_bg@3x" top:0 bottom:0 left:14 right:14]];
            _lb_num.backgroundColor=[AciMath getColor:@"14ad00"];
            self.tag=0;
        }
        
        [_lb_num setText:[dic[@"tag_num"] ToString]];
        
        
       
        [self addSubview:_bg];
        [self addSubview:_lb_tag];
      
        [self addSubview:_lb_num];
        [self setFrame:CGRectMake(0, 0, _bg.frame.size.width, 27)];

    }
    return self;
}

@end