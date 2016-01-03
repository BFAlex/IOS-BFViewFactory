//
//  BFChatWindowModel.m
//  BFViewFactory
//
//  Created by readboy1 on 15/12/23.
//  Copyright © 2015年 Readboy. All rights reserved.
//

#import "BFChatWindowModel.h"

@implementation BFChatWindowModel


+ (instancetype)chatWindowModelForTest {
    
    BFChatWindowModel *model = [[BFChatWindowModel alloc] init];
    
    if (model) {
        
        model.chatTarget = @"家庭聊天";
    }
    
    return model;
}

@end
