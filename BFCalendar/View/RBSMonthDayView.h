//
//  RBSMonthDayView.h
//  BFViewFactory
//
//  Created by readboy1 on 15/12/17.
//  Copyright © 2015年 Readboy. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RBSMonthDayView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *monthDayBGImg;
@property (weak, nonatomic) IBOutlet UIImageView *monthDaySelImg;
@property (weak, nonatomic) IBOutlet UILabel *monthDayNumLabel;

+ (instancetype)monthDayView;
+ (instancetype)monthDayViewWithFrame:(CGRect)frame;

- (void)viewStytleOfSel;
- (void)viewStytleOfNonSel;

@end
