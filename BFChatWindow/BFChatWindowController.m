//
//  BFChatWindowController.m
//  BFViewFactory
//
//  Created by readboy1 on 15/12/23.
//  Copyright © 2015年 Readboy. All rights reserved.
//

#import "BFChatWindowController.h"
#import "BFChatWindowModel.h"
#import "BFEnterView.h"

#define kLogString      [NSString stringWithFormat:@"%s %zd\n", __func__, __LINE__]
#define kCellID         @"CellID"

#define kHeadImgWH      40
#define kMargin         5
#define kFontSize       20


@interface BFChatWindowController () <UITableViewDataSource, UITableViewDelegate, BFEnterViewDelegate>{
    
    BFChatWindowModel *_model;
    NSMutableArray *_recordArr;
    NSMutableArray *_cellHeightArr;
    
    UIButton *_playingVoiceBtn;
}

@end

@implementation BFChatWindowController

- (instancetype)init {
    
    self = [self initWithModel:[BFChatWindowModel chatWindowModelForTest]];
    
    return self;
}

- (instancetype)initWithModel:(BFChatWindowModel *)dataModel {
    
    self = [super init];
    
    if (self) {
        
        _model = dataModel;
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [self initPropertyAndCustomView];
}

- (void)initData {
    
    _recordArr = [self testRecordArr];
}

- (NSMutableArray *)testRecordArr {
    
    NSDictionary *dict1 = [NSDictionary dictionaryWithObjectsAndKeys:@"weixin", @"name", @"微信团队欢迎你。很高兴你开启了微信生活，期待能为你和朋友们带来愉快的沟通体检", @"content", nil];
    NSDictionary *dict2 = [NSDictionary dictionaryWithObjectsAndKeys:@"rb", @"name", @"a", @"content", nil];
    NSDictionary *dict3 = [NSDictionary dictionaryWithObjectsAndKeys:@"rb", @"name", @"bb", @"content", nil];
    NSDictionary *dict4 = [NSDictionary dictionaryWithObjectsAndKeys:@"weixin", @"name", @"ccc", @"content", nil];
    NSDictionary *dict5 = [NSDictionary dictionaryWithObjectsAndKeys:@"rb", @"name", @"dddd", @"content", nil];
    NSDictionary *dict6 = [NSDictionary dictionaryWithObjectsAndKeys:@"weixin", @"name", @"eeeee", @"content", nil];
    NSDictionary *dict7 = [NSDictionary dictionaryWithObjectsAndKeys:@"rb", @"name", @"abcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcde", @"content", nil];
    NSDictionary *dict9 = [NSDictionary dictionaryWithObjectsAndKeys:@"rb", @"name", @"0", @"content", nil];
    NSDictionary *dict10 = [NSDictionary dictionaryWithObjectsAndKeys:@"weixin", @"name", @"0", @"content", nil];
//    NSDictionary *dict8 = [NSDictionary dictionaryWithObjectsAndKeys:@"weixin", @"name", @"", @"content", nil];
    
    NSMutableArray *rArr = [[NSMutableArray alloc] initWithObjects:dict1, dict9, dict10, dict2, dict3, dict4, dict5, dict6, dict7, nil];
    
    return rArr;
}

- (void)initPropertyAndCustomView {
    
    // navigation bar path
    self.navigationItem.title = _model.chatTarget;
    
    UIImage *barItemImg = [UIImage imageNamed:@"rightBarBtnBG.png"];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:barItemImg style:UIBarButtonItemStylePlain target:self action:@selector(clickRightBarButtonItem:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    self.chatViewTopConstraint.constant = self.navigationController.navigationBar.frame.size.height
                                        + self.navigationController.navigationBar.frame.origin.y;
    
    // enter View
    BFEnterView *eView = [BFEnterView enterViewWithFrame:self.enterView.bounds];
    eView.delegate = self;
    
    [self.enterView addSubview:eView];
    
    
}

- (void)clickRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem {
    NSLog(@"clickBarButtonItem");
}

- (void)closeKeyboard {
    
    [self.view endEditing:YES];
}

- (void)scrollToButtomWithAnimation:(BOOL)animation {
    
    CGFloat scrPoint = self.recordsTableView.contentSize.height - self.recordsTableView.bounds.size.height;
    
    [self.recordsTableView setContentOffset:CGPointMake(0, scrPoint) animated:animation];
}


#pragma mark - UITableView
#pragma mark - DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _recordArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dict = _recordArr[indexPath.row];
    
    UIFont *font = [UIFont systemFontOfSize:kFontSize];
    
    CGSize windowSize = self.view.frame.size;
    
    CGSize size = [[dict objectForKey:@"content"] sizeWithFont:font constrainedToSize:CGSizeMake(windowSize.width/2, windowSize.height*5) lineBreakMode:NSLineBreakByWordWrapping];
    
    CGFloat cellH = size.height + kMargin * 4 >= kHeadImgWH ? size.height + kMargin * 4 : kHeadImgWH;
    
    return cellH + kMargin * 2;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSLog(@"%@", kLogString);
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 25)];
    headView.clipsToBounds = YES;
    
    UIActivityIndicatorView *actIndicator = [[ UIActivityIndicatorView alloc] init];
    actIndicator.center = headView.center;
    actIndicator.center = headView.center;
    actIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    actIndicator.hidden = NO;
    [actIndicator startAnimating];
    
    [headView addSubview:actIndicator];
    
    return headView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    } else {
        
        for (UIView *cellView in cell.subviews) {
            
            [cellView removeFromSuperview];
        }
    }
    
    NSDictionary *dict = _recordArr[indexPath.row];
    
    CGRect windowFrame = self.view.frame;
    // 头像
    UIImageView *headImg;
    if ([[dict objectForKey:@"name"] isEqualToString:@"rb"]) {
        
        headImg = [[UIImageView alloc] initWithFrame:CGRectMake(windowFrame.size.width - kMargin - kHeadImgWH, kMargin, kHeadImgWH, kHeadImgWH)];
        
        [cell addSubview:headImg];
        
        headImg.image = [UIImage imageNamed:@"item.png"];
        
        if ([[dict objectForKey:@"content"] isEqualToString:@"0"]) {
            
            [cell addSubview:[self voiceView:10 from:YES withIndexRow:indexPath.row withPosition:kHeadImgWH + kMargin*2]];
            
        } else {
            
            [cell addSubview:[self bubbleView:[dict objectForKey:@"content"] from:YES withPosition:kHeadImgWH + kMargin*2]];
        }
        
    } else {
        
        headImg = [[UIImageView alloc] initWithFrame:CGRectMake(kMargin, kMargin, kHeadImgWH, kHeadImgWH)];
        
        [cell addSubview:headImg];
        
        headImg.image = [UIImage imageNamed:@"item.png"];
        
        if ([[dict objectForKey:@"content"] isEqualToString:@"0"]) {
            
            UIView *voiceView = [self voiceView:90 from:NO withIndexRow:indexPath.row withPosition:kHeadImgWH + kMargin*2];
            [cell addSubview:voiceView];
            
            // 未读语音标识 (注释为判断条件，待用)
//            BOOL read = [_recordArr[indexPath.row] objectForKey:@"ReadTag"];
//            if (!read) {
            
                UIView *readTag = [[UIView alloc] initWithFrame:CGRectMake(voiceView.frame.origin.x + voiceView.bounds.size.width + kMargin, voiceView.frame.origin.y, 10.0f, 10.0f)];
            
                readTag.layer.masksToBounds = YES;
                readTag.layer.cornerRadius = readTag.bounds.size.width/2;
                readTag.layer.backgroundColor = [[UIColor redColor] CGColor];
                
                [cell addSubview:readTag];
//            }
            
        } else {
            
            [cell addSubview:[self bubbleView:[dict objectForKey:@"content"] from:NO withPosition:kHeadImgWH + kMargin*2]];
        }
    }
    
    headImg.layer.masksToBounds = YES;
    headImg.layer.cornerRadius = headImg.bounds.size.width/2;
    headImg.layer.borderWidth = 1.0f;
    
    return cell;
}

#pragma mark - Delegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
   
    [self.view endEditing:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@%zd", kLogString, indexPath.row);
}

#pragma mark - BFEnterViewDelegate Methods
#pragma mark - voice delegate methods
- (void)startRecording {
    NSLog(@"%@", kLogString);
    
    NSMutableArray *recordArr = [[NSMutableArray alloc] init];
    for (int i = 3; i < 15; i++) {
        
        [recordArr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"r%d.png", i]]];
    }
    
    CGFloat viewWH = 100.0f;
    UIImageView *recordingView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.center.x - viewWH/2, self.view.center.y - viewWH/2, viewWH, viewWH)];
    
    recordingView.animationImages = recordArr;
    recordingView.animationDuration = 2.0;
    recordingView.animationRepeatCount = 0;
    
    recordingView.image = [UIImage imageNamed:@"str.png"];
    
    [recordingView startAnimating];
    
    [self.view addSubview:recordingView];
}

- (void)endRecording {
    NSLog(@"%@", kLogString);
    
    [[self.view.subviews lastObject] removeFromSuperview];
}

- (void)giveUpRecording {
    NSLog(@"%@", kLogString);
    
    [[self.view.subviews lastObject] removeFromSuperview];
    
}

- (void)showRecordingAnination {
    
    UIView *lastView = [self.view.subviews lastObject];
    if ([lastView isKindOfClass:[UIImageView class]]) {

        UIImageView *animationView = (UIImageView *)lastView;

        if (![animationView isAnimating]) {
            
            [animationView startAnimating];
        }
    }
}

- (void)showCancelRecordingImg {
    
    UIView *lastView = [self.view.subviews lastObject];
    if ([lastView isKindOfClass:[UIImageView class]]) {
        
        UIImageView *animationView = (UIImageView *)lastView;

        if ([animationView isAnimating]) {
            
            [animationView stopAnimating];
        }
    }
}

#pragma mark - textField delegate methods
- (void)showKeyboard:(CGFloat)kbHeight {
    
    self.chatViewBottomConstraint.constant = kbHeight;
    
    [self.view layoutIfNeeded];
}

- (void)hideKeyboard {
    
    self.chatViewBottomConstraint.constant = 0;
    
    [self.view layoutIfNeeded];
}

- (void)sendInfo:(NSString *)txt {
    
    [self closeKeyboard];
}


#pragma mark - copy code
// 泡泡文本
- (UIView *)bubbleView:(NSString *)text from:(BOOL)fromSelf withPosition:(int)position {
    
    CGSize windowSize = self.view.frame.size;
    
    // 计算大小
    UIFont *font = [UIFont systemFontOfSize:kFontSize];
    CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake(windowSize.width/2, windowSize.height*5) lineBreakMode:NSLineBreakByWordWrapping];
    
    // build single chat bubble cell with given text
    UIView *returnView = [[UIView alloc] initWithFrame:CGRectZero];
    returnView.backgroundColor = [UIColor clearColor];
    
    // 背景图片
    UIImage *bubble = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fromSelf ? @"SendAppNodeBg_HL" : @"ReceiverTextNodeBg" ofType:@"png"]];
    UIImageView *bubbleImgView = [[UIImageView alloc] initWithImage:[bubble stretchableImageWithLeftCapWidth:bubble.size.width/2 topCapHeight:floorf(bubble.size.height*0.9)]];
    
    // 添加文本信息
    UILabel *bubbleText = [[UILabel alloc] initWithFrame:CGRectMake(fromSelf ? kMargin * 2 : kMargin * 2 + 10.0f, kMargin*2, size.width, size.height)];
    bubbleText.backgroundColor = [UIColor clearColor];
    bubbleText.font = font;
    bubbleText.numberOfLines = 0;
    bubbleText.lineBreakMode = NSLineBreakByWordWrapping;
    bubbleText.text = text;
    
    CGFloat bivH = bubbleText.frame.size.height + kMargin * 4 >= kHeadImgWH ? bubbleText.frame.size.height  + kMargin * 4 : kHeadImgWH;
    bubbleImgView.frame = CGRectMake(0.0f, 0.0f, bubbleText.frame.size.width + kMargin * 4 + 10.0f, bivH);
    
    if (fromSelf) {
        
        returnView.frame = CGRectMake(windowSize.width - position - bubbleImgView.frame.size.width, kMargin, bubbleImgView.frame.size.width, bubbleImgView.frame.size.height);
        
    } else {
        
        returnView.frame = CGRectMake(position, kMargin, bubbleImgView.frame.size.width, bubbleImgView.frame.size.height);
    }
    
    [returnView addSubview:bubbleImgView];
    
    [returnView addSubview:bubbleText];
    
    
    return returnView;
}

// 泡泡语音
- (UIView *)voiceView:(NSInteger)longTime from:(BOOL)fromSelf withIndexRow:(NSInteger)indexRow withPosition:(int)position {
    
    CGSize windowSize = self.view.frame.size;
    
    // 根据语音长度
    CGFloat btnMaxW = self.view.bounds.size.width * 0.5;
    int voiceWidth = (int)(longTime + kHeadImgWH > btnMaxW ? btnMaxW : kHeadImgWH + longTime);
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.tag = indexRow;
    
    CGFloat btnWidth = voiceWidth + kMargin * 2;
    NSMutableString *preAnimation = [[NSMutableString alloc] init];
    if (fromSelf) {
        
        btn.frame = CGRectMake(windowSize.width - position - btnWidth, kMargin, btnWidth, kHeadImgWH);
        
        [preAnimation appendString:@"pl"];
        
    } else {
        
        btn.frame = CGRectMake(position, kMargin, btnWidth, kHeadImgWH);
        
        [preAnimation appendString:@"pr"];
    }
    
    // img偏移量
    UIEdgeInsets imgInsert;
    imgInsert.top = -kMargin/2;
    CGFloat leftInsert = btnWidth - kHeadImgWH - kMargin * 2;
    imgInsert.left = fromSelf ? leftInsert : -leftInsert;
    btn.imageEdgeInsets = imgInsert;
    
    [btn setImage:[UIImage imageNamed:fromSelf ? @"SenderVoiceNodePlaying" : @"ReceiverVoiceNodePlaying"] forState:UIControlStateNormal];
    UIImage *bgImg = [UIImage imageNamed:fromSelf ? @"SenderVoiceNodeDownloading" : @"ReceiverVoiceNodeDownloading"];
    bgImg = [bgImg stretchableImageWithLeftCapWidth:btn.bounds.size.width/4 topCapHeight:5];
    [btn setBackgroundImage:bgImg forState:UIControlStateNormal];
    // animation imgs
    NSMutableArray *imgs = [[NSMutableArray alloc] init];
    for (int i = 1; i <= 3; i++) {
        
        [imgs addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%@%zd.png", preAnimation, i]]];
    }
    btn.imageView.animationImages = imgs;
    btn.imageView.animationRepeatCount = longTime;
    btn.imageView.animationDuration = 1.0f;
    
    CGFloat labelW = kHeadImgWH*2;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(fromSelf ? -labelW - kMargin : btn.frame.size.width + kMargin, btn.bounds.size.height - kHeadImgWH/2, labelW, kHeadImgWH/2)];
    label.text = [self strForVoiceTime:longTime];
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:kFontSize - 5];
    label.textAlignment = fromSelf ? NSTextAlignmentRight : NSTextAlignmentLeft;
    label.backgroundColor = [UIColor clearColor];
    [btn addSubview:label];
    
    // 添加声音播放事件
    [btn addTarget:self action:@selector(playVoice:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

- (void)playVoice:(UIButton *)btn {
    NSLog(@"%@", kLogString);
    
//    if ([btn.imageView isAnimating]) {
//        
//        [btn.imageView stopAnimating];
//        
//    } else {
//        
//        [btn.imageView startAnimating];
//    }
    
    if (_playingVoiceBtn) {
        
        [_playingVoiceBtn.imageView stopAnimating];
        
//        _playingVoiceBtn = nil;
    }
    
    if (btn != _playingVoiceBtn) {
        
        [btn.imageView startAnimating];
        
        _playingVoiceBtn = btn;
        
    } else {
        
        _playingVoiceBtn = nil;
    }
}

- (NSString *)strForVoiceTime:(NSInteger)voiceTime {
    
    NSMutableString *timeStr = [[NSMutableString alloc] init];
    
    NSInteger time = voiceTime;
    if (time / 60) {
        
        [timeStr appendString:[NSString stringWithFormat:@"%zd'", time / 60]];
    }
    
    time = time % 60;
    
    [timeStr appendString:[NSString stringWithFormat:@"%zd''", time % 60]];
    
    return timeStr;
}



// unused
- (UIImage *)maskImage:(UIImage *)image withMask:(UIImage *)maskImg {
    
    CGImageRef maskRef = [maskImg CGImage];
    
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), NULL, true);
    
    CGImageRef masked = CGImageCreateWithMask([image CGImage], mask);
//    CGImageRef masked = CGImageCreateWithMask(maskRef, mask);
    
  
    return [UIImage imageWithCGImage:masked];
}

- (UIImage *)overlapImages:(UIImage *)topImg andBottomImg:(UIImage *)bottomImg {
    
    UIGraphicsBeginImageContext(bottomImg.size);
    
    [bottomImg drawInRect:CGRectMake(0, 0, bottomImg.size.width, bottomImg.size.height)];
    
    [topImg drawInRect:CGRectMake(0, 0, bottomImg.size.width, bottomImg.size.height)];
    
    UIImage *curImg = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return curImg;
}

@end
