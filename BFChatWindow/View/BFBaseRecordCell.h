//
//  BFBaseRecordCell.h
//  BFViewFactory
//
//  Created by readboy1 on 15/12/25.
//  Copyright © 2015年 Readboy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFCellModel.h"

@interface BFBaseRecordCell : UITableViewCell

@property (nonatomic, assign) NSInteger labelHeight;

- (void)setupCellModel:(BFCellModel *)model;

- (UIImage *)clipImage:(UIImage *)image fromImage:(UIImage *)shapeImg;

@end
