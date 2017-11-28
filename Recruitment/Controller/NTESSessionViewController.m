//
//  ChatVC.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/14.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "NTESSessionViewController.h"

#import "NTESSessionConfig.h"
#import "NTESAttachment.h"
#import "NIMKitUtil.h"
#import "NTESVideoViewController.h"
#import "NTESGalleryViewController.h"


@interface NTESSessionViewController ()

@property (nonatomic,strong) NTESSessionConfig *sessionConfig;
//@property (nonatomic,strong) UILabel *titleLab;

@end

@implementation NTESSessionViewController

- (id<NIMSessionConfig>)sessionConfig
{
    if (_sessionConfig == nil) {
        _sessionConfig = [[NTESSessionConfig alloc] init];
//        _sessionConfig.session = self.session;
    }
    return _sessionConfig;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.titleLabel.textColor = [UIColor greenColor];
//    self.titleLabel.font = [UIFont fontWithName:@"Arial" size:14.f];
    

    UIImage *image = [UIImage imageNamed:@"11"];
    [self.navigationController.navigationBar setBackIndicatorImage:image];
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:image];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController.navigationBar setTintColor:UIColorFromRGB(0x000000)];
    self.navigationItem.backBarButtonItem = backItem;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
}

#pragma mark - 会话title
- (NSString *)sessionTitle{

    UILabel *label = [UILabel labelWithframe:CGRectMake((self.navigationItem.titleView.width-200)/2, (self.navigationItem.titleView.height-20)/2, 200, 20) text:[super sessionTitle] font:[UIFont boldSystemFontOfSize:17] textAlignment:NSTextAlignmentCenter textColor:@"#000000"];
//    label.backgroundColor = [UIColor greenColor];

    [self.navigationItem.titleView addSubview:label];

    return @"";

}

#pragma mark - Cell事件
- (BOOL)onTapCell:(NIMKitEvent *)event
{
    BOOL handled = [super onTapCell:event];
    NSString *eventName = event.eventName;
    if ([eventName isEqualToString:NIMKitEventNameTapContent])
    {
        NIMMessage *message = event.messageModel.message;
        NSDictionary *actions = [self cellActions];
        NSString *value = actions[@(message.messageType)];
        if (value) {
            SEL selector = NSSelectorFromString(value);
            if (selector && [self respondsToSelector:selector]) {
                SuppressPerformSelectorLeakWarning([self performSelector:selector withObject:message]);
                handled = YES;
            }
        }
    }

    if (!handled) {
        NSAssert(0, @"invalid event");
    }
    return handled;
}

- (NSDictionary *)cellActions
{
    static NSDictionary *actions = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        actions = @{@(NIMMessageTypeImage) :    @"showImage:",
                    @(NIMMessageTypeVideo) :    @"showVideo:",
//                    @(NIMMessageTypeLocation) : @"showLocation:",
//                    @(NIMMessageTypeFile)  :    @"showFile:",
//                    @(NIMMessageTypeCustom):    @"showCustom:"
                    
                    };
    });
    return actions;
}

#pragma mark - Cell Actions
- (void)showVideo:(NIMMessage *)message
{
    NIMVideoObject *object = message.messageObject;
    NIMSession *session = [self isMemberOfClass:[NTESSessionViewController class]]? self.session : nil;
    
    NTESVideoViewItem *item = [[NTESVideoViewItem alloc] init];
    item.path = object.path;
    item.url  = object.url;
    item.session = session;
    item.itemId  = object.message.messageId;
    
    NTESVideoViewController *playerViewController = [[NTESVideoViewController alloc] initWithVideoViewItem:item];
    [self.navigationController pushViewController:playerViewController animated:YES];
    if(![[NSFileManager defaultManager] fileExistsAtPath:object.coverPath]){
        //如果封面图下跪了，点进视频的时候再去下一把封面图
        __weak typeof(self) wself = self;
        [[NIMSDK sharedSDK].resourceManager download:object.coverUrl filepath:object.coverPath progress:nil completion:^(NSError *error) {
            if (!error) {
                [wself uiUpdateMessage:message];
            }
        }];
    }
}

- (void)showImage:(NIMMessage *)message
{
    NIMImageObject *object = message.messageObject;
    NTESGalleryItem *item = [[NTESGalleryItem alloc] init];
    item.thumbPath      = [object thumbPath];
    item.imageURL       = [object url];
    item.name           = [object displayName];
    item.itemId         = [message messageId];
    item.size           = [object size];

    NIMSession *session = [self isMemberOfClass:[NTESSessionViewController class]]? self.session : nil;

    NTESGalleryViewController *vc = [[NTESGalleryViewController alloc] initWithItem:item session:session];
    [self.navigationController pushViewController:vc animated:YES];
    if(![[NSFileManager defaultManager] fileExistsAtPath:object.thumbPath]){
        //如果缩略图下跪了，点进看大图的时候再去下一把缩略图
        __weak typeof(self) wself = self;
        [[NIMSDK sharedSDK].resourceManager download:object.thumbUrl filepath:object.thumbPath progress:nil completion:^(NSError *error) {
            if (!error) {
                [wself uiUpdateMessage:message];
            }
        }];
    }
}


@end
