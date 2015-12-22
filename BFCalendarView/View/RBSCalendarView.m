//
//  RBSCalendarView.m
//  BFViewFactory
//
//  Created by readboy1 on 15/12/16.
//  Copyright © 2015年 Readboy. All rights reserved.
//

#import "RBSCalendarView.h"
#import "RBSMonthDayView.h"

#define kRowNum     7
#define kLogString  [NSString stringWithFormat:@"%s %zd\n", __func__, __LINE__]

typedef enum {
    
    topDirection = 0,   // 下划
    
    leftDirection,      // 右划
    
    rightDirection,     // 左划
    
    bottomDirection     // 上划
    
}FrameDirectionType;


@interface RBSCalendarView () {
    
    UIView *_curMonthView;
    
    NSCalendar *_calendar;
    NSDate *_date;
    NSDateComponents *_dateComponents;
    
    UIView *_curShowMonth;
    RBSMonthDayView *_selMonthDay;
}

@end

@implementation RBSCalendarView

+ (instancetype)calendarViewWidthFrame:(CGRect)frame {
    NSLog(@"%@", kLogString);
    
    RBSCalendarView *calendarView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    
    if (calendarView) {
        
        [UIView animateWithDuration:0.0001f animations:^{
            
            calendarView.frame = frame;
            
            [calendarView initProperty];
            
        } completion:^(BOOL finished) {
            
            [calendarView showDate:[NSDate date]];
        }];
    }
    
    return calendarView;
}

- (void)swipeGesture:(UISwipeGestureRecognizer *)recognizer {
    NSLog(@"%@", kLogString);
    
    switch (recognizer.direction) {
            
        case UISwipeGestureRecognizerDirectionRight:
            
            [self showPreMonth];
            break;
            
        case UISwipeGestureRecognizerDirectionLeft:
            
            [self showNextMonth];
            break;
            
        default:
            break;
    }
    
}

- (void)initProperty {
    NSLog(@"%@", kLogString);
    
    _calendar = [NSCalendar currentCalendar];
    
    _date = [NSDate date];
    
    _dateComponents = [_calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:_date];
    
    // 添加 左滑 和 右滑 的手势
    UISwipeGestureRecognizer *leftSwipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    leftSwipeRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    
    UISwipeGestureRecognizer *rightSwipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    rightSwipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.calendarView addGestureRecognizer:leftSwipeRecognizer];
    [self.calendarView addGestureRecognizer:rightSwipeRecognizer];
}

- (void)showSelMonth:(NSDate *)date withDirection:(FrameDirectionType)direction{
    NSLog(@"%@", kLogString);

    UIView *monthView = [self getSelMonthDetailView:date];
    
    CGRect targetFrame = monthView.frame;
    CGRect startFrame = [self startFrameDirection:direction toTargetFrame:targetFrame];
    
    monthView.frame = startFrame;
    monthView.alpha = 0;
    
    [self.calendarView addSubview:monthView];
    
    [UIView animateWithDuration:0.5f animations:^{
        
        monthView.frame = targetFrame;
        monthView.alpha = 1;
        
        _curShowMonth.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [_curShowMonth removeFromSuperview];
        _curShowMonth = monthView;
        _date = date;
    }];
}

- (CGRect)startFrameDirection:(FrameDirectionType)direction toTargetFrame:(CGRect)targetFrame {
    NSLog(@"%@", kLogString);
    
    CGRect startFrame;
    
    switch (direction) {
            
        case topDirection:
            
            startFrame = CGRectMake(0, 0 - targetFrame.size.height, targetFrame.size.width, targetFrame.size.height);
            break;
            
        case leftDirection:
            
            startFrame = CGRectMake(0 - targetFrame.size.width, 0, targetFrame.size.width, targetFrame.size.height);
            break;
            
        case rightDirection:
            
            startFrame = CGRectMake(0 + targetFrame.size.width, 0, targetFrame.size.width, targetFrame.size.height);
            break;
            
        case bottomDirection:
            
            startFrame = CGRectMake(0, 0 + targetFrame.size.height, targetFrame.size.width, targetFrame.size.height);
            break;
    }
    
    return startFrame;
}

- (UIView *)getSelMonthDetailView:(NSDate *)date {
    NSLog(@"%@", kLogString);
    
    UIView *monthView = [[UIView alloc] initWithFrame:self.calendarView.bounds];
    
    // 确定month的周数
    NSInteger weekNum = [self weekNumInMonth:date];
    
    // 确定每个monthday组件的w和h
    CGFloat monthdayW = monthView.bounds.size.width / kRowNum;
    CGFloat monthdayH = monthView.bounds.size.height / weekNum;
    
    int firstDay = [self firstDayInWeekOfMonth:date];
    NSInteger monthDays = [self dayNumInMonth:date];
    int curDayNum = 1;
    
    // 判断当前年月日
    NSInteger isCurDate = [self isCurDate:date];
    
    // 添加日期
    for (int week = 0; week < weekNum; week++) {
        
        for (int row = week > 0 ? 0 : firstDay; row < kRowNum; row++) {
            
            if (curDayNum <= monthDays) {
                
                CGRect dayViewFrame = CGRectMake(monthdayW * row, monthdayH * week, monthdayW, monthdayH);
                RBSMonthDayView *dayView = [RBSMonthDayView monthDayViewWithFrame:dayViewFrame];
                dayView.monthDayNumLabel.text = [NSString stringWithFormat:@"%d", curDayNum];
                
                // 添加tap事件
                UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDayView:)];
                [dayView addGestureRecognizer:tapGestureRecognizer];
                
//                dayView.backgroundColor = [UIColor colorWithRed:0.5 green:0.1 * week blue:0.2 * row alpha:1];
                
                if (isCurDate > 0) {
                    if (isCurDate == curDayNum) {
                        
                        [dayView viewStytleOfSel];
                    }
                }
                
                [monthView addSubview:dayView];
                
                curDayNum++;
                
            } else {
                break;
            }
        }
    }
    
    return monthView;
}

- (void)tapDayView:(UITapGestureRecognizer *)tap {
    NSLog(@"%@", kLogString);
    
    if ([self.delegate respondsToSelector:@selector(clickDate:)]) {
        
        RBSMonthDayView *tapDay = (RBSMonthDayView *)tap.view;
        
        NSDateComponents *comp = [_calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:_date];
        
        comp.day = [[tapDay.monthDayNumLabel text] integerValue];
        NSLog(@"tap date: %zd 年 %zd 月 %zd 日", comp.year, comp.month, comp.day);
        
        NSDate *date = [_calendar dateFromComponents:comp];
        
        [self.delegate clickDate:date];
    }
    
    [self selMonthDay:(RBSMonthDayView *)tap.view];
}

- (NSInteger)isCurDate:(NSDate *)date {
    NSLog(@"%@", kLogString);
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *selComp = [calendar components:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:date];
    
    NSDateComponents *curComp = [calendar components:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:[NSDate date]];
    
    if (selComp.year == curComp.year
        && selComp.month == curComp.month
        && selComp.day == curComp.day) {
        
        return curComp.day;
        
    } else {
        
        return 0;
    }
}

// 月的天数
- (NSInteger)dayNumInMonth:(NSDate *)date {
    NSLog(@"%@", kLogString);
    
    NSRange dayRange =[_calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    
    return dayRange.length;
}

// 月的周数
- (NSInteger)weekNumInMonth:(NSDate *)date{
    NSLog(@"%@", kLogString);
    
    NSRange weekRange = [_calendar rangeOfUnit:NSCalendarUnitWeekOfMonth inUnit:NSCalendarUnitMonth forDate:date];
    
    return weekRange.length;
}

// 每月1号的星期名字
- (int)firstDayInWeekOfMonth:(NSDate *)date {
    NSLog(@"%@", kLogString);
    
    NSDateComponents *newComp = [_calendar components:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:date];
    newComp.day = 0;
    NSDate *newDate = [_calendar dateFromComponents:newComp];
    
    NSInteger firstDay = [_calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:newDate];
    
    return firstDay % 7;
}

// 指定日期
- (void)showDate:(NSDate *)date {
    NSLog(@"%@", kLogString);
    
    [self showSelMonth:date withDirection:topDirection];
}

// 上一个月
- (void)showPreMonth{
    NSLog(@"%@", kLogString);

    if (!_date) {
        return;
    }
    
    NSDateComponents *preComp = [_calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:_date];
    
    if (preComp.month == 1) {
        
        preComp.year -= 1;
        
        preComp.month = 12;
        
    } else {
        
        preComp.month--;
    }
    
    NSDate *preDate = [_calendar dateFromComponents:preComp];
    
    [self showSelMonth:preDate withDirection:leftDirection];
}

// 下一个月
- (void)showNextMonth {
    NSLog(@"%@", kLogString);

    if (!_date) {
        return;
    }
    
    NSDateComponents *nextComp = [_calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:_date];
    
    if (nextComp.month == 12) {
        
        nextComp.year += 1;
        
        nextComp.month = 1;
        
    } else {
        
        nextComp.month++;
    }
    
    NSDate *nextDate = [_calendar dateFromComponents:nextComp];
    
    [self showSelMonth:nextDate withDirection:rightDirection];
}

- (void)selMonthDay:(RBSMonthDayView *)monthDay {
    NSLog(@"%@", kLogString);
    
    if (_selMonthDay) {
        
        [self calcelSelMonthDay:_selMonthDay];
    }
    monthDay.monthDaySelImg.image = [UIImage imageNamed:@"monthdaySel.png"];
    
    _selMonthDay = monthDay;
}

- (void)calcelSelMonthDay:(RBSMonthDayView *)monthday {
    NSLog(@"%@", kLogString);
    
    monthday.monthDaySelImg.image = nil;
}

@end
