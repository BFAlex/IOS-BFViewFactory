//
//  RBSMonthDayView.m
//  BFViewFactory
//
//  Created by readboy1 on 15/12/17.
//  Copyright © 2015年 Readboy. All rights reserved.
//

#import "RBSMonthDayView.h"

@implementation RBSMonthDayView

+ (instancetype)monthDayView {
    
    RBSMonthDayView *monthDay = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    
    return monthDay;
}

+ (instancetype)monthDayViewWithFrame:(CGRect)frame {
    
    RBSMonthDayView *monthDay = [self monthDayView];
    
    if (monthDay) {
        
        monthDay.frame = frame;
        
        // setup font size
        CGSize viewSize = monthDay.bounds.size;
        CGFloat fontSize = viewSize.width > viewSize.height ? viewSize.height : viewSize.width;
        monthDay.monthDayNumLabel.font = [UIFont systemFontOfSize:fontSize * 0.5];
        
        [monthDay viewStytleOfNonSel];
    }
    
    return monthDay;
}

- (void)viewStytleOfSel {
    
    self.monthDayBGImg.image = [UIImage imageNamed:@"monthdayBG.png"];
    self.monthDayNumLabel.textColor = [UIColor whiteColor];
}

- (void)viewStytleOfNonSel {
    
    self.monthDayBGImg.image = nil;
    self.monthDayNumLabel.textColor = [UIColor blackColor];
}

@end
