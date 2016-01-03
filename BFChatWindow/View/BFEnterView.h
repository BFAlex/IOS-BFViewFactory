//
//  BFEnterView.h
//  BFViewFactory
//
//  Created by readboy1 on 15/12/23.
//  Copyright © 2015年 Readboy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BFEnterViewDelegate <NSObject>

- (void)startRecording;
- (void)endRecording;
- (void)giveUpRecording;
- (void)showRecordingAnination;
- (void)showCancelRecordingImg;

- (void)showKeyboard:(CGFloat)kbHeight;
- (void)hideKeyboard;
- (void)sendInfo:(NSString *)txt;

@end

@interface BFEnterView : UIView

@property (nonatomic, assign) id<BFEnterViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *switchBtn;
@property (weak, nonatomic) IBOutlet UIView *enterSelView;

+ (instancetype)enterViewWithFrame:(CGRect)frame;

- (IBAction)clickSwitchBtn:(UIButton *)sender;

@end
