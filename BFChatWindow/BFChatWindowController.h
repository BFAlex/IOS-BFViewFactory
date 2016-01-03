//
//  BFChatWindowController.h
//  BFViewFactory
//
//  Created by readboy1 on 15/12/23.
//  Copyright © 2015年 Readboy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BFChatWindowModel;

@interface BFChatWindowController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *recordsTableView;
@property (weak, nonatomic) IBOutlet UIView *enterView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *chatViewBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *chatViewTopConstraint;

- (instancetype)initWithModel:(BFChatWindowModel *)dataModel;

@end
