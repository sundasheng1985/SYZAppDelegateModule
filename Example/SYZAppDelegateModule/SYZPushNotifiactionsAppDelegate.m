//
//  SYZPushNotifiactionsAppDelegate.m
//  SYZAppDelegateModule_Example
//
//  Created by LeeRay on 2019/3/9.
//  Copyright © 2019年 sundasheng1985. All rights reserved.
//

#import "SYZPushNotifiactionsAppDelegate.h"
#import <SYZUIBasekit/SYZUIBasekit.h>


@implementation SYZPushNotifiactionsAppDelegate

/** 一定要先注册 */
SYZRegisterAppDelegateModule()

/** 将要初始化根视图 */
- (void)application:(UIApplication *)application willInitWindowWithLaunchOptions:(NSDictionary *)launchOptions {
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        UNAuthorizationOptions types10 = UNAuthorizationOptionBadge|  UNAuthorizationOptionAlert | UNAuthorizationOptionSound;
        [center requestAuthorizationWithOptions:types10 completionHandler:^(BOOL granted, NSError * _Nullable error) {
            SYZ_dispatch_async_main_execute(^{
                [application registerForRemoteNotifications];
            })
        }];
    } else {
        UIUserNotificationType myTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
}

//im推送
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    application.applicationIconBadgeNumber = 0;
    if (deviceToken) {
        NSString *deviceTokenString = [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<"withString:@""]
                                        stringByReplacingOccurrencesOfString:@">" withString:@""]
                                       stringByReplacingOccurrencesOfString:@" " withString:@""];
        [[NSUserDefaults standardUserDefaults] setObject:deviceTokenString forKey:@"kSYZRemoteDeviceToken"];
    }
    
    /** 注册im */
//   [[NIMSDK sharedSDK] updateApnsToken:deviceToken];
    
}

//ios 8 支持
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    [application registerForRemoteNotifications];
}

//注册推送失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //    NSAssert(YES, error.description);
}

//远程推送
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    //    NSDictionary *params = userInfo[@"aps"];
    [self _remoteNotificationWithUserInfo:userInfo];
}

//本地推送
/*
 1.关于ios10
 程序在后台或者程序被关闭时，didReceiveNotificationResponse 会被执行
 当程序在前台时候，willPresentNotification 会被执行
 2.关于ios10 以下
 程序在后台，前台时候，didReceiveLocalNotification 方法会被执行
 程序关闭时。 localNotificatuibWith
 */

//远程推送
/*
 1. 关于ios10
 当程序在前台时候，willPresentNotification 会被执行
 程序在后台或者程序被关闭时，didReceiveNotificationResponse 会被执行
 
 2.ios 10 以下
 当程序在前台、程序在后台时候 、程序关闭 didReceiveRemoteNotification
 
 */

#pragma mark - UNUserNotificationCenterDelegate
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        completionHandler();
        return;
    }
    NSString *isLocalNotification = userInfo[@"isLocalNotification"];
    if (SYZIsNotEmptyString(isLocalNotification)) {
        [self _localNotificationWithUserInfo:userInfo];
    } else {
        [self _remoteNotificationWithUserInfo:userInfo];
    }
    completionHandler();
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    [self _localNotificationWithUserInfo:notification.userInfo];
}

- (void)localNotificatuibWith:(UILocalNotification *)localNotification {
    [self _localNotificationWithUserInfo:localNotification.userInfo];
}

//程序在前台和后台都会走此方法
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    //    NSDictionary *params = userInfo[@"aps"];
    switch (application.applicationState) {
            case UIApplicationStateActive: {
                //程序在前台
                [self _showNoficationInForeground:userInfo];
                break;
            }
            case UIApplicationStateInactive: {
                [self _remoteNotificationWithUserInfo:userInfo];
                //程序在后台
                break;
            }
            case UIApplicationStateBackground: {
                [self _remoteNotificationWithUserInfo:userInfo];
                //杀死程序后
                break;
            }
        default:
            break;
    }
    completionHandler(UIBackgroundFetchResultNoData);
}

- (void)_localNotificationWithUserInfo:(NSDictionary *)userInfo {
    
}


//远程推送(根据推送的消息跳转到相应位置
- (void)_remoteNotificationWithUserInfo:(NSDictionary *)userInfo {
    NSDictionary * dicFromJson = userInfo[@"aps"];
    if (SYZIsNotEmptyDictionary(dicFromJson)) {
        NSString *type = dicFromJson[@"alert"];
        if (SYZIsNotEmptyString(type)) {
//
        }
    }
}


- (void)_showNoficationInForeground:(NSDictionary *)userInfo {
    NSDictionary * dicFromJson = userInfo[@"aps"];
    if (SYZIsNotEmptyDictionary(dicFromJson)) {
        NSString *type = dicFromJson[@"alert"];
        if (SYZIsNotEmptyString(type)) {
            //                NSString * title = userInfo[@"aps"][@"alert"][@"body"];
            //                [HDNotificationView showNotificationViewWithImage:[UIImage imageNamed:@"ShareDefault"]
            //                                                            title:@"新的直播"
            //                                                          message:type];
            //                [HDNotificationView showNotificationViewWithImage:[UIImage imageNamed:@"ShareDefault"] title:@"新的直播" message:type isAutoHide:YES onTouch:^{
            //                    NSLog(@"点击事件---");
            //
            //                }];
        }
    }
    
    //    })
}



@end
