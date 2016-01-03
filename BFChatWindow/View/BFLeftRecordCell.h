//
//  BFLeftRecordCell.h
//  BFViewFactory
//
//  Created by readboy1 on 15/12/25.
//  Copyright © 2015年 Readboy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFBaseRecordCell.h"

@class BFCellModel;

@interface BFLeftRecordCell : BFBaseRecordCell

@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UIImageView *contentImg;
@property (weak, nonatomic) IBOutlet UILabel *contentLable;
@property (weak, nonatomic) IBOutlet UIImageView *stytleImg;
@property (weak, nonatomic) IBOutlet UIView *recordMarkView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelWidthScaleConstraint;


+ (instancetype)leftRecordCell;

@end
