//
//  BFChatWindowModel.h
//  BFViewFactory
//
//  Created by readboy1 on 15/12/23.
//  Copyright © 2015年 Readboy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFChatWindowModel : NSObject

@property (nonatomic, copy) NSString *chatTarget;
@property (nonatomic, strong) NSMutableArray *recordArr;


+ (instancetype)chatWindowModelForTest;

@end
