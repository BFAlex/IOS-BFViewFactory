//
//  BFCellModel.h
//  BFViewFactory
//
//  Created by readboy1 on 15/12/25.
//  Copyright © 2015年 Readboy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFCellModel : NSObject

@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, assign) int cellStytle;
@property (nonatomic, copy) NSString *recordTxt;
@property (nonatomic, assign) float labelWidthScale;

+ (instancetype)cellModelForTestOFLeft;

@end
