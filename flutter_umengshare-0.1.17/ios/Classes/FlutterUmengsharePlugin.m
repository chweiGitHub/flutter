#import "FlutterUmengsharePlugin.h"
#import <UMCommon/UMCommon.h>
#import <UMShare/UMShare.h>
#import <UShareUI/UShareUI.h>
#import <UMPush/UMessage.h>
#import <UMCommonLog/UMCommonLogManager.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <FBSDKCoreKit/FBSDKSettings.h>

@implementation FlutterUmengsharePlugin {
    FlutterMethodChannel *_channel;
    NSDictionary *_launchNotification;
    BOOL _resumingFromBackground;
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    FlutterMethodChannel *channel =
        [FlutterMethodChannel methodChannelWithName:@"flutter_umengshare"
                                    binaryMessenger:[registrar messenger]];

    FlutterUmengsharePlugin *instance =
        [[FlutterUmengsharePlugin alloc] initWithChannel:channel];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (instancetype)initWithChannel:(FlutterMethodChannel *)channel {
    self = [super init];
    if (self) {
        _channel                = channel;
        _resumingFromBackground = NO;
    }
    return self;
}

- (void)initUmengAppKey:(NSString *)appKey {
    [UMConfigure initWithAppkey:appKey channel:@"App Store"];
}

- (void)setupUSharePlatforms:(NSArray *)platforms {
    for (NSDictionary *dict in platforms) {
        NSString *platform    = dict[@"platform"];
        NSString *appKey      = dict[@"appKey"];
        NSString *appSecret   = dict[@"appSecret"];
        NSString *redirectURL = dict[@"redirectURL"];

        [[UMSocialManager defaultManager]
             setPlaform:[self getPlatform:platform.intValue]
                 appKey:appKey
              appSecret:appSecret
            redirectURL:redirectURL];
        
        if (platform.intValue == 3) {
            [FBSDKSettings setAppID:appKey];
        }
    }
}

- (void)handleMethodCall:(FlutterMethodCall *)call
                  result:(FlutterResult)result {

    if ([@"initUmengAppKey" isEqualToString:call.method]) {
        NSString *appkey = call.arguments[@"appKey"];
        [self initUmengAppKey:appkey];
    }
    else if ([@"setupUSharePlatforms" isEqualToString:call.method]) {
        NSArray *sharePlatforms = call.arguments[@"sharePlatforms"];
        [self setupUSharePlatforms:sharePlatforms];
    }
    else if ([@"shareText" isEqualToString:call.method]) {
        int platformType = ((NSNumber *)call.arguments[@"platform"]).intValue;
        NSString *text   = call.arguments[@"text"];
        // NSString *desc=call.arguments[@"desc"];
        [self shareText:[self sharePlatform:platformType]
               withText:text
                 result:result];
    }
    else if ([@"shareImage" isEqualToString:call.method]) {
        int platformType = ((NSNumber *)call.arguments[@"platform"]).intValue;
        NSString *thumb  = call.arguments[@"thumb"];
        NSString *image  = call.arguments[@"image"];
        [self shareImage:[self sharePlatform:platformType]
               withImage:image
               withThumb:thumb
                  result:result];
    }
    else if ([@"shareMedia" isEqualToString:call.method]) {
        int platformType = ((NSNumber *)call.arguments[@"platform"]).intValue;
        int type         = ((NSNumber *)call.arguments[@"type"]).intValue;
        NSString *thumb  = call.arguments[@"thumb"];
        NSString *title  = call.arguments[@"title"];
        NSString *desc   = call.arguments[@"desc"];
        NSString *link   = call.arguments[@"link"];
        [self shareMedia:[self sharePlatform:platformType]
            withMediaType:type
                withTitle:title
                 withDesc:desc
                withThumb:thumb
                 withLink:link
                   result:result];
    }
    else if ([@"login" isEqualToString:call.method]) {
        int platformType = ((NSNumber *)call.arguments[@"platform"]).intValue;
        [self login:[self getPlatform:platformType] result:result];
    }
    else if ([@"login" isEqualToString:call.method]) {
        NSString *username = call.arguments[@"username"];
        NSString *thumb    = call.arguments[@"thumb"];
        NSString *title    = call.arguments[@"title"];
        NSString *desc     = call.arguments[@"desc"];
        NSString *url      = call.arguments[@"url"];
        NSString *path     = call.arguments[@"path"];
        [self shareMiniApp:username
                 withTitle:title
                  withDesc:desc
                 withThumb:thumb
                   withURL:url
                  withPath:path
                    result:result];
    }
    else if ([@"checkInstall" isEqualToString:call.method]) {
        int platformType = ((NSNumber *)call.arguments[@"platform"]).intValue;
        [self checkInstall:[self getPlatform:platformType] result:result];
    }
    else if ([@"shareUI" isEqualToString:call.method]) {
        NSString *thumb         = call.arguments[@"thumb"];
        NSString *title         = call.arguments[@"title"];
        NSString *desc          = call.arguments[@"desc"];
        NSString *link          = call.arguments[@"link"];
        NSArray *sharePlatforms = call.arguments[@"sharePlatforms"];
        [self shareUIwithTitle:title
                      withDesc:desc
                     withThumb:thumb
                      withLink:link
            withSharePlatforms:sharePlatforms
                        result:result];
    }
    else if ([@"configure" isEqualToString:call.method]) {
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        if (_launchNotification != nil) {
            [_channel invokeMethod:@"onLaunch" arguments:_launchNotification];
        }
        result(nil);
    }
    else if ([@"test" isEqualToString:call.method]) {
        result(@"hello");
    }
    else if ([@"getPlatformVersion" isEqualToString:call.method]) {
        result(@"0.1.6");
    }
    else {
        result(FlutterMethodNotImplemented);
    }
}

- (UMSocialPlatformType)sharePlatform:(int)platformType {

    UMSocialPlatformType type = UMSocialPlatformType_Sina;
    switch (platformType) {
        case 0:
            type = UMSocialPlatformType_Sina; //新浪
            break;
        case 1:
            type = UMSocialPlatformType_WechatSession; //微信聊天
            break;
        case 2:
            type = UMSocialPlatformType_WechatTimeLine; //微信朋友圈
            break;
        case 3:
            type = UMSocialPlatformType_WechatFavorite; //微信收藏
            break;
        case 4:
            type = UMSocialPlatformType_QQ; // QQ
            break;
        case 5:
            type = UMSocialPlatformType_Qzone; // Qzone
            break;
        case 6:
            type = UMSocialPlatformType_Facebook; // Facebook
            break;
        case 7:
            type = UMSocialPlatformType_Twitter; // Twitter
            break;
        default:
            type = UMSocialPlatformType_Sina;
            break;
    }
    return type;
}
- (UMSocialPlatformType)getPlatform:(int)platformType {

    UMSocialPlatformType type = UMSocialPlatformType_Sina;
    switch (platformType) {
        case 0:
            type = UMSocialPlatformType_Sina; //新浪
            break;
        case 1:
            type = UMSocialPlatformType_WechatSession; //微信聊天
            break;
        case 2:
            type = UMSocialPlatformType_QQ; // QQ
            break;
        case 3:
            type = UMSocialPlatformType_Facebook; // Facebook
            break;
        case 4:
            type = UMSocialPlatformType_Twitter; // Twitter
            break;
        default:
            type = UMSocialPlatformType_Sina;
            break;
    }
    return type;
}

- (void)shareUIwithTitle:(NSString *)title
                withDesc:(NSString *)desc
               withThumb:(NSString *)thumb
                withLink:(NSString *)link
      withSharePlatforms:(NSArray *)sharePlatforms
                  result:(FlutterResult)result {

    NSMutableArray *sharePlatformArray = [NSMutableArray array];
    for (NSNumber *numberType in sharePlatforms) {
        UMSocialPlatformType shareType =
            [self sharePlatform:numberType.intValue];

        if ([[UMSocialManager defaultManager] isInstall:shareType]) {
            [sharePlatformArray addObject:@(shareType)];
        }
    }

    [UMSocialUIManager setPreDefinePlatforms:sharePlatformArray];
    [UMSocialShareUIConfig shareInstance].shareTitleViewConfig.shareTitleViewTitleString = @"分享到";
    //显示分享面板
    [UMSocialUIManager
        showShareMenuViewInWindowWithPlatformSelectionBlock:^(
            UMSocialPlatformType platformType, NSDictionary *userInfo) {

            UMSocialMessageObject *messageObject =
                [UMSocialMessageObject messageObject];
            UMShareWebpageObject *shareWebPageObjet =
                [UMShareWebpageObject shareObjectWithTitle:title
                                                     descr:desc
                                                 thumImage:thumb];
            shareWebPageObjet.webpageUrl = link;
            messageObject.shareObject    = shareWebPageObjet;

            dispatch_async(dispatch_get_main_queue(), ^{
                [[UMSocialManager defaultManager]
                          shareToPlatform:platformType
                            messageObject:messageObject
                    currentViewController:nil
                               completion:^(id data, NSError *error) {
                                   if (error) {
                                       if (error.code == 2009) {
                                           result(@{ @"um_status": @"CANCEL" });
                                       }
                                       else {
                                           result(@{
                                               @"um_status": @"ERROR",
                                               @"um_msg": error.userInfo
                                           });
                                       }
                                   }
                                   else {
                                       result(@{ @"um_status": @"SUCCESS" });
                                   }
                               }];
            });
        }];

    // [UMSocialUIManager
    // setPreDefinePlatforms:@[@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession)]];
    // [UMSocialUIManager
    // showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType
    // platformType, NSDictionary *userInfo) {
    //     // 根据获取的platformType确定所选平台进行下一步操作
    // }];
}

//分享文本
- (void)shareText:(UMSocialPlatformType)platformType
         withText:(NSString *)text
           result:(FlutterResult)result {
    //创建分享消息对象
    UMSocialMessageObject *messageObject =
        [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = text;

    dispatch_async(dispatch_get_main_queue(), ^{
        [[UMSocialManager defaultManager]
                  shareToPlatform:platformType
                    messageObject:messageObject
            currentViewController:nil
                       completion:^(id data, NSError *error) {
                           if (error) {
                               if (error.code == 2009) {
                                   result(@{ @"um_status": @"CANCEL" });
                               }
                               else {
                                   result(@{
                                       @"um_status": @"ERROR",
                                       @"um_msg": error.userInfo
                                   });
                               }
                           }
                           else {
                               result(@{ @"um_status": @"SUCCESS" });
                           }
                       }];
    });
}

//分享图片

- (void)shareImage:(UMSocialPlatformType)platformType
         withImage:(NSString *)image
         withThumb:(NSString *)thumb
            result:(FlutterResult)result {
    //创建分享消息对象
    UMSocialMessageObject *messageObject =
        [UMSocialMessageObject messageObject];
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    // shareObject.t

    //如果有缩略图，则设置缩略图本地
    // shareObject.thumbImage = thumb;
    [shareObject setThumbImage:thumb];
    // shareObject.descr
    [shareObject setShareImage:image];
    //[shareObject sets]
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UMSocialManager defaultManager]
                  shareToPlatform:platformType
                    messageObject:messageObject
            currentViewController:nil
                       completion:^(id data, NSError *error) {
                           if (error) {
                               if (error.code == 2009) {
                                   result(@{ @"um_status": @"CANCEL" });
                               }
                               else {
                                   result(@{
                                       @"um_status": @"ERROR",
                                       @"um_msg": error.userInfo
                                   });
                               }
                           }
                           else {
                               result(@{ @"um_status": @"SUCCESS" });
                           }
                       }];
    });
}
//分享多媒体

- (void)shareMedia:(UMSocialPlatformType)platformType
     withMediaType:(NSInteger)type
         withTitle:(NSString *)title
          withDesc:(NSString *)desc
         withThumb:(NSString *)thumb
          withLink:(NSString *)link
            result:(FlutterResult)result {
    //创建分享消息对象
    UMSocialMessageObject *messageObject =
        [UMSocialMessageObject messageObject];
    if (type == 0) {
        UMShareMusicObject *shareMusicObjet =
            [UMShareMusicObject shareObjectWithTitle:title
                                               descr:desc
                                           thumImage:thumb];
        shareMusicObjet.musicUrl  = link;
        messageObject.shareObject = shareMusicObjet;
    }
    else if (type == 1) {
        UMShareVideoObject *shareVideoObjet =
            [UMShareVideoObject shareObjectWithTitle:title
                                               descr:desc
                                           thumImage:thumb];
        shareVideoObjet.videoUrl  = link;
        messageObject.shareObject = shareVideoObjet;
    }
    else if (type == 2) {
        UMShareWebpageObject *shareWebPageObjet =
            [UMShareWebpageObject shareObjectWithTitle:title
                                                 descr:desc
                                             thumImage:thumb];
        shareWebPageObjet.webpageUrl = link;
        messageObject.shareObject    = shareWebPageObjet;
    }
    else {
        result(@{ @"um_status": @"INVALID" });
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UMSocialManager defaultManager]
                  shareToPlatform:platformType
                    messageObject:messageObject
            currentViewController:nil
                       completion:^(id data, NSError *error) {
                           if (error) {
                               if (error.code == 2009) {
                                   result(@{ @"um_status": @"CANCEL" });
                               }
                               else {
                                   result(@{
                                       @"um_status": @"ERROR",
                                       @"um_msg": error.userInfo
                                   });
                               }
                           }
                           else {
                               result(@{ @"um_status": @"SUCCESS" });
                           }
                       }];
    });
}

//分享小程序
- (void)shareMiniApp:(NSString *)username
           withTitle:(NSString *)title
            withDesc:(NSString *)desc
           withThumb:(NSString *)thumb
             withURL:(NSString *)url
            withPath:(NSString *)path
              result:(FlutterResult)result {
    //创建分享消息对象
    UMSocialMessageObject *messageObject =
        [UMSocialMessageObject messageObject];
    UMShareMiniProgramObject *shareObject =
        [UMShareMiniProgramObject shareObjectWithTitle:title
                                                 descr:desc
                                             thumImage:thumb];
    shareObject.webpageUrl = url;
    shareObject.userName   = username;
    shareObject.path       = path;
    // shareObject.hdImageData =UIImagePNGRepresentation(thumb);
    // shareObject.hdImageData = [NSData dataWithContentsOfFile:[[NSBundle
    // mainBundle] pathForResource:@"logo" ofType:@"png"]];
    shareObject.miniProgramType = UShareWXMiniProgramTypeRelease;
    messageObject.shareObject   = shareObject;

    //调用分享接口
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UMSocialManager defaultManager]
                  shareToPlatform:UMSocialPlatformType_WechatSession
                    messageObject:messageObject
            currentViewController:self
                       completion:^(id data, NSError *error) {

                           if (error) {
                               if (error.code == 2009) {
                                   result(@{ @"um_status": @"CANCEL" });
                               }
                               else {
                                   result(@{
                                       @"um_status": @"ERROR",
                                       @"um_msg": error.userInfo
                                   });
                               }
                           }
                           else {
                               result(@{ @"um_status": @"SUCCESS" });
                           }
                       }];
    });
}

//登录
- (void)login:(UMSocialPlatformType)platformType result:(FlutterResult)result {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UMSocialManager defaultManager]
            getUserInfoWithPlatform:platformType
              currentViewController:nil
                         completion:^(id data, NSError *error) {
                             if (error) {
                                 if (error.code == 2009) {
                                     // error.code;
                                     result(@{ @"um_status": @"CANCEL" });
                                 }
                                 else {
                                     result(@{
                                         @"um_status": @"ERROR",
                                         @"um_msg": error.userInfo
                                     });
                                 }
                             }
                             else {
                                 UMSocialUserInfoResponse *resp = data;
                                 NSDictionary *ret              = @{
                                     @"um_status": @"SUCCESS",
                                     @"uid": resp.uid,
                                     @"openid": resp.openid,
                                     @"accessToken": resp.accessToken,
                                     @"expiration": resp.expiration,
                                     @"name": resp.name,
                                     @"iconurl": resp.iconurl,
                                     @"gender": resp.gender,
                                     @"originalResponse": resp.originalResponse
                                 };
                                 result(ret);
                             }
                         }];
    });
}

//检察应用是否安装
- (void)checkInstall:(UMSocialPlatformType)platformType
              result:(FlutterResult)result {
    dispatch_async(dispatch_get_main_queue(), ^{
        BOOL flag = [[UMSocialManager defaultManager] isInstall:platformType];
        result([NSNumber numberWithBool:flag]);
    });
}

- (NSString *)convertToJsonData:(NSDictionary *)dict {
    NSError *error;
    NSData *jsonData =
        [NSJSONSerialization dataWithJSONObject:dict options:nil error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@", error);
    }
    else {
        jsonString = [[NSString alloc] initWithData:jsonData
                                           encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

- (void)didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"umeng_push_plugin didReceiveRemoteNotification userInfo: %@",
          userInfo);
    NSLog(@"umeng_push_plugin call onMessage: %@", _channel);
    [_channel invokeMethod:@"onMessage"
                 arguments:[self convertToJsonData:userInfo]];
}

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"umeng_push_plugin application didFinishLaunchingWithOptions %@",
          _launchNotification);
    // Override point for customization after application launch.
    [UMCommonLogManager setUpUMCommonLogManager];
    [UMConfigure setLogEnabled:YES];

    NSLog(@"umeng_push_plugin application init umeng ok");
    UMessageRegisterEntity *entity = [[UMessageRegisterEntity alloc] init];
    // type是对推送的几个参数的选择，可以选择一个或者多个。默认是三个全部打开，即：声音，弹窗，角标
    entity.types =
        UMessageAuthorizationOptionBadge | UMessageAuthorizationOptionAlert;
#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
    [UNUserNotificationCenter currentNotificationCenter].delegate = self;
#endif
    [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions
                                                       Entity:entity
                                            completionHandler:^(
                                                BOOL granted,
                                                NSError *_Nullable error) {
                                                if (granted) {
                                                }
                                                else {
                                                }
                                            }];
    _launchNotification = [launchOptions
        objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    _resumingFromBackground = YES;
    NSLog(@"umeng_push_plugin applicationDidEnterBackground");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    _resumingFromBackground = NO;
    NSLog(@"umeng_push_plugin applicationDidBecomeActive");
    application.applicationIconBadgeNumber = 1;
    application.applicationIconBadgeNumber = 0;
}

#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0

// iOS10新增：处理前台收到通知的代理方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:
             (void (^)(UNNotificationPresentationOptions))completionHandler {
    NSLog(@"umeng_push_plugin userNotificationCenter willPresentNotification");
    NSDictionary *userInfo = notification.request.content.userInfo;
    if ([notification.request.trigger
            isKindOfClass:[UNPushNotificationTrigger class]]) {
        [UMessage setAutoAlert:NO];
        //应用处于前台时的远程推送接受
        //必须加这句代码
        //[UMessage didReceiveRemoteNotification:userInfo];
        [self didReceiveRemoteNotification:userInfo];
    }
    else {
        //应用处于前台时的本地推送接受
    }
    completionHandler(UNNotificationPresentationOptionSound |
                      UNNotificationPresentationOptionBadge |
                      UNNotificationPresentationOptionAlert);
}

// iOS10新增：处理后台点击通知的代理方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
    didReceiveNotificationResponse:(UNNotificationResponse *)response
             withCompletionHandler:(void (^)())completionHandler {
    NSLog(@"umeng_push_plugin userNotificationCenter "
          @"didReceiveNotificationResponse");
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    if ([response.notification.request.trigger
            isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
        //[UMessage didReceiveRemoteNotification:userInfo];
        [self didReceiveRemoteNotification:userInfo];
    }
    else {
        //应用处于后台时的本地推送接受
    }
}

#endif

- (NSString *)stringDevicetoken:(NSData *)deviceToken {
    NSString *token = [deviceToken description];
    NSString *pushToken =
        [[[token stringByReplacingOccurrencesOfString:@"<" withString:@""]
            stringByReplacingOccurrencesOfString:@">"
                                      withString:@""]
            stringByReplacingOccurrencesOfString:@" "
                                      withString:@""];
    NSLog(@"umeng_push_plugin token: %@", pushToken);
    return pushToken;
}

- (void)application:(UIApplication *)application
    didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"umeng_push_plugin application didReceiveRemoteNotification "
          @"userInfo: %@",
          userInfo);
    [self didReceiveRemoteNotification:userInfo];
    //    [UMessage setAutoAlert:NO];
    //    [UMessage didReceiveRemoteNotification:userInfo];
    //    [[NSNotificationCenter defaultCenter]
    //    postNotificationName:@"userInfoNotification" object:self
    //    userInfo:@{@"userinfo": [NSString stringWithFormat:@"%@", userInfo]}];
}

- (void)application:(UIApplication *)application
    didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"umeng_push_plugin application "
          @"didRegisterForRemoteNotificationsWithDeviceToken%@",
          deviceToken);
    [_channel invokeMethod:@"onToken"
                 arguments:[self stringDevicetoken:deviceToken]];
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

@end
