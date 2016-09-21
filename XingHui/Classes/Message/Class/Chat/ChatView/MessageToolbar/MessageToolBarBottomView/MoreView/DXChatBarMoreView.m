/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import "DXChatBarMoreView.h"

#define CHAT_BUTTON_SIZE 50
#define INSETS 8

@implementation DXChatBarMoreView

- (instancetype)initWithFrame:(CGRect)frame type:(ChatMoreType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setupSubviewsForType:type];
    }
    return self;
}

- (void)setupSubviewsForType:(ChatMoreType)type
{
    self.backgroundColor = [UIColor clearColor];
    CGFloat insets = (self.frame.size.width - 4 * CHAT_BUTTON_SIZE) / 5;
    
    _photoButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [_photoButton setFrame:CGRectMake(insets, 10, CHAT_BUTTON_SIZE , CHAT_BUTTON_SIZE)];
    [_photoButton setImage:[UIImage imageNamed:@"chatBar_colorMore_photo"] forState:UIControlStateNormal];
    [_photoButton setImage:[UIImage imageNamed:@"chatBar_colorMore_photoSelected"] forState:UIControlStateHighlighted];
    [_photoButton addTarget:self action:@selector(photoAction) forControlEvents:UIControlEventTouchUpInside];
    UILabel *lb_photo =[[UILabel alloc] initWithFrame:CGRectMake(insets, _photoButton.maxY, CHAT_BUTTON_SIZE, 21)];
    lb_photo.textAlignment = NSTextAlignmentCenter;
    lb_photo.text =@"照片";
    [lb_photo setFont:Font(14)];
    [lb_photo setTextColor:Color(@"333333")];
    [self addSubview:_photoButton];
    [self addSubview:lb_photo];
    
    _locationButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [_locationButton setFrame:CGRectMake(insets * 2 + CHAT_BUTTON_SIZE, 10, CHAT_BUTTON_SIZE , CHAT_BUTTON_SIZE)];
    [_locationButton setImage:[UIImage imageNamed:@"chatBar_colorMore_location"] forState:UIControlStateNormal];
    [_locationButton setImage:[UIImage imageNamed:@"chatBar_colorMore_locationSelected"] forState:UIControlStateHighlighted];
    [_locationButton addTarget:self action:@selector(locationAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_locationButton];
    UILabel *lb_location=[[UILabel alloc] initWithFrame:CGRectMake(insets * 2 + CHAT_BUTTON_SIZE, _locationButton.maxY, CHAT_BUTTON_SIZE, 21)];
    lb_location.textAlignment = NSTextAlignmentCenter;
    lb_location.text =@"位置";
    [lb_location setFont:Font(14)];
    [lb_location setTextColor:Color(@"333333")];
    [self addSubview:lb_location];
    
    
    _takePicButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [_takePicButton setFrame:CGRectMake(insets * 3 + CHAT_BUTTON_SIZE * 2, 10, CHAT_BUTTON_SIZE , CHAT_BUTTON_SIZE)];
    [_takePicButton setImage:[UIImage imageNamed:@"chatBar_colorMore_camera"] forState:UIControlStateNormal];
    [_takePicButton setImage:[UIImage imageNamed:@"chatBar_colorMore_cameraSelected"] forState:UIControlStateHighlighted];
    [_takePicButton addTarget:self action:@selector(takePicAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_takePicButton];
    UILabel *lb_pic=[[UILabel alloc] initWithFrame:CGRectMake(insets * 3 + CHAT_BUTTON_SIZE * 2, _takePicButton.maxY, CHAT_BUTTON_SIZE, 21)];
    lb_pic.textAlignment = NSTextAlignmentCenter;
    lb_pic.text =@"拍照";
    [lb_pic setFont:Font(14)];
    [lb_pic setTextColor:Color(@"333333")];
    [self addSubview:lb_pic];
    

    CGRect frame = self.frame;
    if (type == ChatMoreTypeChat) {
        frame.size.height = 150;
        _audioCallButton =[UIButton buttonWithType:UIButtonTypeCustom];
        [_audioCallButton setFrame:CGRectMake(insets * 4 + CHAT_BUTTON_SIZE * 3, 10, CHAT_BUTTON_SIZE , CHAT_BUTTON_SIZE)];
        [_audioCallButton setImage:[UIImage imageNamed:@"chatBar_colorMore_audioCall"] forState:UIControlStateNormal];
        [_audioCallButton setImage:[UIImage imageNamed:@"chatBar_colorMore_audioCallSelected"] forState:UIControlStateHighlighted];
        [_audioCallButton addTarget:self action:@selector(takeAudioCallAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_audioCallButton];
        UILabel *lb_audio=[[UILabel alloc] initWithFrame:CGRectMake(insets * 4 + CHAT_BUTTON_SIZE * 3-10, _audioCallButton.maxY, CHAT_BUTTON_SIZE+20, 21)];
        lb_audio.textAlignment = NSTextAlignmentCenter;
        lb_audio.text =@"语音通话";
        [lb_audio setFont:Font(14)];
        [lb_audio setTextColor:Color(@"333333")];
        [self addSubview:lb_audio];

        
        
        _videoCallButton =[UIButton buttonWithType:UIButtonTypeCustom];
        [_videoCallButton setFrame:CGRectMake(insets, 10 * 2 + CHAT_BUTTON_SIZE + 10, CHAT_BUTTON_SIZE , CHAT_BUTTON_SIZE)];
        [_videoCallButton setImage:[UIImage imageNamed:@"chatBar_colorMore_videoCall"] forState:UIControlStateNormal];
        [_videoCallButton setImage:[UIImage imageNamed:@"chatBar_colorMore_videoCallSelected"] forState:UIControlStateHighlighted];
        [_videoCallButton addTarget:self action:@selector(takeVideoCallAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_videoCallButton];
    
        UILabel *lb_video=[[UILabel alloc] initWithFrame:CGRectMake(insets-10, _videoCallButton.maxY, CHAT_BUTTON_SIZE+20,21)];
        lb_video.textAlignment = NSTextAlignmentCenter;
        lb_video.text =@"视频聊天";
        [lb_video setFont:Font(14)];
        [lb_video setTextColor:Color(@"333333")];
        [self addSubview:lb_video];

    }
    else if (type == ChatMoreTypeGroupChat)
    {
        frame.size.height = 80;
    }
    self.frame = frame;
}

#pragma mark - action

- (void)takePicAction{
    if(_delegate && [_delegate respondsToSelector:@selector(moreViewTakePicAction:)]){
        [_delegate moreViewTakePicAction:self];
    }
}

- (void)photoAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(moreViewPhotoAction:)]) {
        [_delegate moreViewPhotoAction:self];
    }
}

- (void)locationAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(moreViewLocationAction:)]) {
        [_delegate moreViewLocationAction:self];
    }
}

- (void)takeAudioCallAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(moreViewAudioCallAction:)]) {
        [_delegate moreViewAudioCallAction:self];
    }
}

- (void)takeVideoCallAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(moreViewVideoCallAction:)]) {
        [_delegate moreViewVideoCallAction:self];
    }
}

@end
