//
//  BFEnterView.m
//  BFViewFactory
//
//  Created by readboy1 on 15/12/23.
//  Copyright © 2015年 Readboy. All rights reserved.
//

#import "BFEnterView.h"

#define kLogString  [NSString stringWithFormat:@"%s %zd\n\n", __func__, __LINE__]

typedef enum {
    
    InfoKindText = 0,
    InfoKindVoice
    
}InfoKind;

@interface BFEnterView () <UITextFieldDelegate> {
    
    InfoKind _nextInfoKind;
}

@end

@implementation BFEnterView

+ (instancetype)enterViewWithFrame:(CGRect)frame {
    
    BFEnterView *enterView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    
    if (enterView) {
        
        [UIView animateWithDuration:0.0f animations:^{
        
            enterView.frame = frame;
        
        } completion:^(BOOL finished) {
            
        [enterView initCustomView];
        }];
    }
    
    return enterView;
}

- (void)initCustomView {
    
    _nextInfoKind = InfoKindText;
    
    [self switchInfoView];
    
    [self registerKeyboardNotification];
}

- (void)registerKeyboardNotification {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardDidShowNotification:(NSNotification *)notification {
    NSLog(@"%@", kLogString);
    
    if ([self.delegate respondsToSelector:@selector(showKeyboard:)]) {
    
        CGRect kbBounds = [[notification.userInfo objectForKey:@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
        CGFloat kbHeight = kbBounds.size.height;
        
        [self.delegate showKeyboard:kbHeight];
    }
}

- (void)keyboardWillHideNotification:(NSNotification *)notification {
    NSLog(@"%@", kLogString);
    
    if ([self.delegate respondsToSelector:@selector(hideKeyboard)]) {
        
        [self.delegate hideKeyboard];
    }
}

- (void)switchInfoView {
    
    for (UIView *subVeiw in self.enterSelView.subviews) {
        
        [subVeiw removeFromSuperview];
    }
    
    [self.enterSelView addSubview:[self infoViewWithFrame:self.enterSelView.bounds]];
}

- (UIView *)infoViewWithFrame:(CGRect)frame {
    
    UIView *view = nil;
    switch (_nextInfoKind) {
            
        case InfoKindText:
            
            view = [self creTextViewWithFrame:frame];
            
            break;
            
        case InfoKindVoice:
            
            view = [self creVoiceViewWithFrame:frame];
            
            break;
    }
    
    return view;
}

- (UIView *)creTextViewWithFrame:(CGRect)frame {
    
    // btn 样式
    [self.switchBtn setBackgroundImage:[UIImage imageNamed:@"btn_VoiceNor.png"] forState:UIControlStateNormal];
    [self.switchBtn setBackgroundImage:[UIImage imageNamed:@"btn_VoiceSel.png"] forState:UIControlStateHighlighted];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.background = [UIImage imageNamed:@"view_Keyboard_BG.png"];
    textField.returnKeyType = UIReturnKeySend;
    
    textField.delegate = self;
    
    _nextInfoKind = InfoKindVoice;
    
    return textField;
}

- (UIView *)creVoiceViewWithFrame:(CGRect)frame {
    
    // btn 样式
    [self.switchBtn setBackgroundImage:[UIImage imageNamed:@"btn_KeyboardNor.png"] forState:UIControlStateNormal];
    [self.switchBtn setBackgroundImage:[UIImage imageNamed:@"btn_KeyboardSel.png"] forState:UIControlStateHighlighted];
    
    UIButton *voiceBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    voiceBtn.frame = frame;
    [voiceBtn setTitle:@"按住 说话" forState:UIControlStateNormal];
    [voiceBtn setBackgroundImage:[UIImage imageNamed:@"view_VoiceNor_BG.png"] forState:UIControlStateNormal];
    [voiceBtn setBackgroundImage:[UIImage imageNamed:@"view_VoiceSel_BG.png"] forState:UIControlStateHighlighted];
    
    [voiceBtn addTarget:self action:@selector(clickVoiceBtnForEventTouchDown:) forControlEvents:UIControlEventTouchDown];
    [voiceBtn addTarget:self action:@selector(clickVoiceBtnForEventTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [voiceBtn addTarget:self action:@selector(clickVoiceBtnForEventTouchUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
    [voiceBtn addTarget:self action:@selector(drageOutsideFromBtn:) forControlEvents:UIControlEventTouchDragOutside];
    [voiceBtn addTarget:self action:@selector(drageInsideFromBtn:) forControlEvents:UIControlEventTouchDragInside];
    
    _nextInfoKind = InfoKindText;
//    UIControlEventTouchDragOutside
    return voiceBtn;
}

- (void)clickVoiceBtnForEventTouchDown:(UIButton *)btn {
    NSLog(@"%@", kLogString);
    
    if ([self.delegate respondsToSelector:@selector(startRecording)]) {
        
        [self.delegate startRecording];
    }
}

- (void)clickVoiceBtnForEventTouchUpInside:(UIButton *)btn {
    NSLog(@"%@", kLogString);
    
    if ([self.delegate respondsToSelector:@selector(endRecording)]) {
        
        [self.delegate endRecording];
    }
}

- (void)clickVoiceBtnForEventTouchUpOutside:(UIButton *)btn {
    NSLog(@"%@", kLogString);
    
    if ([self.delegate respondsToSelector:@selector(giveUpRecording)]) {
        
        [self.delegate giveUpRecording];
    }
}

- (void)drageOutsideFromBtn:(UIButton *)btn {
    NSLog(@"%@", kLogString);
    
    if ([self.delegate respondsToSelector:@selector(showCancelRecordingImg)]) {
        
        [self.delegate showCancelRecordingImg];
    }
}

- (void)drageInsideFromBtn:(UIButton *)btn {
    NSLog(@"%@", kLogString);
    
    if ([self.delegate respondsToSelector:@selector(showRecordingAnination)]) {
        
        [self.delegate showRecordingAnination];
    }
}

#pragma mark - UITextFieldDelegate Methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"%@ %@", kLogString, textField.text);
    
    if ([self.delegate respondsToSelector:@selector(sendInfo:)]) {
        
        [self.delegate sendInfo:textField.text];
    }
    
    return YES;
}

- (IBAction)clickSwitchBtn:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(sendInfo:)]) {
        
        [self.delegate sendInfo:nil];
    }
    
    [self switchInfoView];
    
    
}

@end
