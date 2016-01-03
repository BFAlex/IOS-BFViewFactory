//
//  BFLeftRecordCell.m
//  BFViewFactory
//
//  Created by readboy1 on 15/12/25.
//  Copyright © 2015年 Readboy. All rights reserved.
//

#import "BFLeftRecordCell.h"
#import "BFCellModel.h"

@interface BFLeftRecordCell ()

@end

@implementation BFLeftRecordCell

+ (instancetype)leftRecordCell {

    BFLeftRecordCell *lCell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    
    if (lCell) {
        
        lCell.recordMarkView.layer.masksToBounds = YES;
        lCell.recordMarkView.layer.cornerRadius = lCell.recordMarkView.bounds.size.width/2;
    }
    
    return lCell;
}

- (void)setupCellModel:(BFCellModel *)model {
    
//    self.headImg.image = [UIImage imageNamed:@"DefaultHead@2x.png"];
    self.headImg.image = [UIImage imageNamed:@"item.png"];
    self.headImg.layer.masksToBounds = YES;
    self.headImg.layer.cornerRadius = self.headImg.bounds.size.width/3.1;
    self.headImg.backgroundColor = [UIColor blueColor];
    self.headImg.layer.borderWidth = 1.0;
    self.contentLable.text = model.recordTxt;
    
    model.labelWidthScale = self.labelWidthScaleConstraint.multiplier - 0.05;
//    self.contentLable.text = @"Hello, ios";
    
//    self.headImg.image = [self clipImage:[UIImage imageNamed:@"item.png"] fromImage:[UIImage imageNamed:@"shape.png"]];
}

@end
