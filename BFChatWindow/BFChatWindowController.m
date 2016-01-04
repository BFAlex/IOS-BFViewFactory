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
#define kImageWH        160


@interface BFChatWindowController () <UITableViewDataSource, UITableViewDelegate, BFEnterViewDelegate>{
    
    BFChatWindowModel *_model;
    NSMutableArray *_recordArr;
    NSMutableArray *_cellHeightArr;
    
    UIButton *_playingVoiceBtn;
    
    NSString *_preBubbleStr;
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
    
    _preBubbleStr = @"bubble1_";
    
    _recordArr = [self testRecordArr];
}

- (NSMutableArray *)testRecordArr {
    
    NSDictionary *dict1 = [NSDictionary dictionaryWithObjectsAndKeys:@"weixin", @"Name", @"0", @"InfoType", @"微信团队欢迎你。很高兴你开启了微信生活，期待能为你和朋友们带来愉快的沟通体检", @"Content", nil];
    NSDictionary *dict2 = [NSDictionary dictionaryWithObjectsAndKeys:@"rb", @"Name", @"0", @"InfoType", @"a", @"Content", nil];
    NSDictionary *dict3 = [NSDictionary dictionaryWithObjectsAndKeys:@"rb", @"Name", @"0", @"InfoType", @"bb", @"Content", nil];
    NSDictionary *dict4 = [NSDictionary dictionaryWithObjectsAndKeys:@"weixin", @"Name", @"0", @"InfoType", @"ccc", @"Content", nil];
    NSDictionary *dict5 = [NSDictionary dictionaryWithObjectsAndKeys:@"rb", @"Name", @"0", @"InfoType", @"dddd", @"Content", nil];
    NSDictionary *dict6 = [NSDictionary dictionaryWithObjectsAndKeys:@"weixin", @"Name", @"0", @"InfoType", @"eeeee", @"Content", nil];
    NSDictionary *dict7 = [NSDictionary dictionaryWithObjectsAndKeys:@"rb", @"Name", @"0", @"InfoType", @"abcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcde", @"Content", nil];
    NSDictionary *dict9 = [NSDictionary dictionaryWithObjectsAndKeys:@"rb", @"Name", @"1", @"InfoType", @"0", @"Content", nil];
    NSDictionary *dict10 = [NSDictionary dictionaryWithObjectsAndKeys:@"weixin", @"Name", @"1", @"InfoType", @"0", @"Content", nil];
    NSDictionary *dict11 = [NSDictionary dictionaryWithObjectsAndKeys:@"weixin", @"Name", @"2", @"InfoType", @"0", @"Content", nil];
    NSDictionary *dict12 = [NSDictionary dictionaryWithObjectsAndKeys:@"rb", @"Name", @"2", @"InfoType", @"0", @"Content", nil];
//    NSDictionary *dict8 = [NSDictionary dictionaryWithObjectsAndKeys:@"weixin", @"Name", @"", @"Content", nil];
    
    NSMutableArray *rArr = [[NSMutableArray alloc] initWithObjects:dict1, dict9, dict10, dict11, dict12, dict2, dict3, dict4, dict5, dict6, dict7, nil];
    
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
    
    if (!tableView.backgroundView) {
        
        UIImageView *tabelBG = [[UIImageView alloc] initWithFrame:tableView.bounds];
        
        tabelBG.image = [UIImage imageNamed:@"qo.jpg"];
        
        tableView.backgroundView = tabelBG;
    }
    
    return _recordArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat cellH;
    
    if ([[_recordArr[indexPath.row] objectForKey:@"InfoType"] intValue] == 2) {
        
        cellH = kImageWH;
        
    } else {
        
        NSDictionary *dict = _recordArr[indexPath.row];
        
        UIFont *font = [UIFont systemFontOfSize:kFontSize];
        
        CGSize windowSize = self.view.frame.size;
        
        CGSize size = [[dict objectForKey:@"Content"] sizeWithFont:font constrainedToSize:CGSizeMake(windowSize.width/2, windowSize.height*5) lineBreakMode:NSLineBreakByWordWrapping];
        
        cellH = size.height + kMargin * 4 >= kHeadImgWH ? size.height + kMargin * 4 : kHeadImgWH;
    }
    
    
    return cellH + kMargin * 2;
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
    
    
    CGRect windowFrame = self.view.frame;
    
    // cell headImg
    UIImageView *headImage;
    BOOL selfInfo;
    if ([[_recordArr[indexPath.row] objectForKey:@"Name"] isEqualToString:@"rb"]) {
        
        headImage = [[UIImageView alloc] initWithFrame:CGRectMake(windowFrame.size.width - kMargin - kHeadImgWH, kMargin, kHeadImgWH, kHeadImgWH)];
        
        headImage.image = [UIImage imageNamed:@"item.png"];
        
        selfInfo = YES;
        
    } else {
        
        headImage = [[UIImageView alloc] initWithFrame:CGRectMake(kMargin, kMargin, kHeadImgWH, kHeadImgWH)];
        
        headImage.image = [UIImage imageNamed:@"item.png"];
        
        selfInfo = NO;
    }
    
    headImage.layer.masksToBounds = YES;
    headImage.layer.cornerRadius = headImage.bounds.size.width/2;
    headImage.layer.borderWidth = 1.0f;
    
    [cell addSubview:headImage];
    
    
    // cell content
    switch ([[_recordArr[indexPath.row] objectForKey:@"InfoType"] intValue]) {
            
        case 0: // text
            
            [cell addSubview:[self bubbleViewAtIndexPath:indexPath from:selfInfo withXPositiom:kHeadImgWH + kMargin*2]];
            
            break;
            
        case 1: // voice
            
            [cell addSubview:[self voiceViewAtIndexPath:indexPath from:selfInfo withXPositiom:kHeadImgWH + kMargin*2]];
            
            if (!selfInfo) {
                
                // 未读语音标识 (注释为判断条件，待用)
                BOOL unread = [_recordArr[indexPath.row] objectForKey:@"ReadTag"];
                
                if (!unread) {
                    
                    UIView *voiceView = [cell.subviews lastObject];
                    
                    UIView *readTag = [[UIView alloc] initWithFrame:CGRectMake(voiceView.frame.origin.x + voiceView.bounds.size.width + kMargin, voiceView.frame.origin.y, 10.0f, 10.0f)];
                    
                    readTag.layer.masksToBounds = YES;
                    readTag.layer.cornerRadius = readTag.bounds.size.width/2;
                    readTag.layer.backgroundColor = [[UIColor redColor] CGColor];
                    
                    [cell addSubview:readTag];
                }
            }
            
            break;
           
        case 2: // image
            [cell addSubview:[self imageViewAtIndexPath:indexPath from:selfInfo withXPositiom:kHeadImgWH + kMargin*2]];
            
            break;
            
        case 3: // date time
            
            break;
            
        default:
            break;
    }
    
    cell.backgroundColor = [UIColor clearColor];
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
// 泡泡文本(重构版)
- (UIView *)bubbleViewAtIndexPath:(NSIndexPath *)indexPath from:(BOOL)selfInfo withXPositiom:(int)position {
    
    NSString *text = [_recordArr[indexPath.row] objectForKey:@"Content"];
    
    CGSize windowSize = self.view.frame.size;
    // 计算大小
    UIFont *font = [UIFont systemFontOfSize:kFontSize];
    CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake(windowSize.width/2, windowSize.height*5) lineBreakMode:NSLineBreakByWordWrapping];
    
    UIView *cellView = [[UIView alloc] initWithFrame:CGRectZero];
    cellView.backgroundColor = [UIColor clearColor];
    
    // cell background image
    UIImage *bubbleImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:selfInfo ? [NSString stringWithFormat:@"%@SendVIT", _preBubbleStr] : [NSString stringWithFormat:@"%@ReceiveT", _preBubbleStr] ofType:@"png"]];
    UIImageView *bubbleImgView = [[UIImageView alloc] initWithImage:[bubbleImg stretchableImageWithLeftCapWidth:bubbleImg.size.width/2 topCapHeight:floorf(bubbleImg.size.height*0.9)]];
    
    // cell text
    UILabel *bubbleText = [[UILabel alloc] initWithFrame:CGRectMake(selfInfo ? kMargin * 2 : kMargin * 2 + 10.0f, kMargin*2, size.width, size.height)];
    bubbleText.backgroundColor = [UIColor clearColor];
    bubbleText.font = font;
    bubbleText.numberOfLines = 0;
    bubbleText.lineBreakMode = NSLineBreakByWordWrapping;
    bubbleText.text = text;
    
    CGFloat bivH = bubbleText.frame.size.height + kMargin * 4 >= kHeadImgWH ? bubbleText.frame.size.height  + kMargin * 4 : kHeadImgWH;
    bubbleImgView.frame = CGRectMake(0.0f, 0.0f, bubbleText.frame.size.width + kMargin * 4 + 10.0f, bivH);
    
    if (selfInfo) {
        
        cellView.frame = CGRectMake(windowSize.width - position - bubbleImgView.frame.size.width, kMargin, bubbleImgView.frame.size.width, bubbleImgView.frame.size.height);
        
    } else {
        
        cellView.frame = CGRectMake(position, kMargin, bubbleImgView.frame.size.width, bubbleImgView.frame.size.height);
    }
    
    
    [cellView addSubview:bubbleImgView];
    
    [cellView addSubview:bubbleText];
    
    return cellView;
}

// 泡泡语音(重构版)
- (UIView *)voiceViewAtIndexPath:(NSIndexPath *)indexPath from:(BOOL)selfInfo withXPositiom:(int)position {
    
    NSInteger voiceTime = [self voiceTimeAtIndexPath:indexPath];
    
    CGSize windowSize = self.view.frame.size;
    
    // 根据语音长度
    CGFloat btnMaxW = self.view.bounds.size.width * 0.5;
    int voiceWidth = (int)(voiceTime + kHeadImgWH > btnMaxW ? btnMaxW : kHeadImgWH + voiceTime);
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = indexPath.row;
    CGFloat btnWidth = voiceWidth + kMargin * 2;
    NSMutableString *preAnimation = [[NSMutableString alloc] init];
    if (selfInfo) {
        
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
    imgInsert.left = selfInfo ? leftInsert : -leftInsert;
    btn.imageEdgeInsets = imgInsert;
    
    [btn setImage:[UIImage imageNamed:selfInfo ? @"SenderVoiceNodePlaying" : @"ReceiverVoiceNodePlaying"] forState:UIControlStateNormal];
    UIImage *bgImg = [UIImage imageNamed:selfInfo ? [NSString stringWithFormat:@"%@SendVIT", _preBubbleStr] : [NSString stringWithFormat:@"%@ReceiveVI", _preBubbleStr]];
    bgImg = [bgImg stretchableImageWithLeftCapWidth:btn.bounds.size.width/4 topCapHeight:5];
    [btn setBackgroundImage:bgImg forState:UIControlStateNormal];
    
    // animation imgs
    NSMutableArray *imgs = [[NSMutableArray alloc] init];
    for (int i = 1; i <= 3; i++) {
        
        [imgs addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%@%zd.png", preAnimation, i]]];
    }
    btn.imageView.animationImages = imgs;
    btn.imageView.animationRepeatCount = voiceTime;
    btn.imageView.animationDuration = 1.0f;
    
    CGFloat labelW = kHeadImgWH*2;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(selfInfo ? -labelW - kMargin : btn.frame.size.width + kMargin, btn.bounds.size.height - kHeadImgWH/2, labelW, kHeadImgWH/2)];
    label.text = [self strForVoiceTime:voiceTime];
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:kFontSize - 5];
    label.textAlignment = selfInfo ? NSTextAlignmentRight : NSTextAlignmentLeft;
    label.backgroundColor = [UIColor clearColor];
    [btn addSubview:label];
    
    // 添加声音播放事件
    [btn addTarget:self action:@selector(playVoice:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

- (NSInteger)voiceTimeAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row % 2) {
        
        return 10;
        
    } else {
        
        return 90;
    }
    
    //    return 10;
}

- (void)playVoice:(UIButton *)btn {
    NSLog(@"%@", kLogString);
    
    if (_playingVoiceBtn) {
        
        [_playingVoiceBtn.imageView stopAnimating];
        
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

// 泡泡图片
- (UIView *)imageViewAtIndexPath:(NSIndexPath *)indexPath from:(BOOL)selfInfo withXPositiom:(int)position {
    
    CGSize windowSize = self.view.frame.size;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    
    CALayer *mask = [CALayer layer];
    
    if (selfInfo) {
        
        imageView.frame = CGRectMake(windowSize.width - position - kImageWH, kMargin, kImageWH, kImageWH);
        
        mask.contents = (id)[[UIImage imageNamed:[NSString stringWithFormat:@"%@SendVIT", _preBubbleStr]] CGImage];
        
    } else {
        
        imageView.frame = CGRectMake(position, kMargin, kImageWH, kImageWH);
        
        mask.contents = (id)[[UIImage imageNamed:[NSString stringWithFormat:@"%@ReceiveT", _preBubbleStr]] CGImage];
    }
    
    mask.frame = imageView.bounds;
    if (selfInfo) {
        
        mask.contentsCenter = CGRectMake(0.1, 0.9, 0, 0);
        
    } else {
        
        mask.contentsCenter = CGRectMake(0.9, 0.9, 0, 0);
    }
    
    imageView.layer.mask = mask;
    imageView.layer.masksToBounds = YES;
    
    // 从字典中获取图片img
    imageView.image = [UIImage imageNamed:@"palette_bg"];
    
    return imageView;
}

@end
