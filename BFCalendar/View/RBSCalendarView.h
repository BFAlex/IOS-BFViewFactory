//
//  RBSCalendarView.h
//  BFViewFactory
//
//  Created by readboy1 on 15/12/16.
//  Copyright © 2015年 Readboy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RBSCalendarViewDelegate <NSObject>

- (void)clickDate:(NSDate *)date;

@end

@interface RBSCalendarView : UIView

@property (nonatomic, assign) id<RBSCalendarViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UIView *calendarView;

+ (instancetype)calendarViewWidthFrame:(CGRect)frame;

- (void)showDate:(NSDate *)date;
- (void)showPreMonth;
- (void)showNextMonth;

@end
