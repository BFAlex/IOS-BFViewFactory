//
//  BFCellModel.m
//  BFViewFactory
//
//  Created by readboy1 on 15/12/25.
//  Copyright © 2015年 Readboy. All rights reserved.
//

#import "BFCellModel.h"

@implementation BFCellModel

+ (instancetype)cellModelForTestOFLeft {
    
    BFCellModel *lModel = [[BFCellModel alloc] init];
    
    if (lModel) {
        
        lModel.cellIdentifier = @"BFLeftRecordCell";
        
        lModel.cellStytle = 1;
        
        NSMutableString *txt = [[NSMutableString alloc] init];
        
        int length = arc4random()%50 + 1;
        for (int i = 0; i < length; i++) {
            
            [txt appendString:[NSString stringWithFormat:@"你好%d", i]];
        }
        lModel.recordTxt = txt;
    }
    
    return lModel;
}

@end
