//
//  AppDelegate.m
//  AppDelegateDemo
//
//  Created by sundasheng1985 on 03/09/2019.
//  Copyright (c) 2019 sundasheng1985. All rights reserved.
//

#import "SYZOriginAppDelegate.h"
#import "SYZAppDelegateEventDispatcher.h"
#import <UserNotifications/UserNotifications.h>

@implementation SYZOriginAppDelegate

SYZSingletonImplementation(SYZOriginAppDelegate)

- (UIWindow *)window {
    if (_window == nil) {
        CGRect applicationFrame = [[UIScreen mainScreen] bounds];
        _window = [[UIWindow alloc] initWithFrame:applicationFrame];
        [_window makeKeyAndVisible];
    }
    return _window;
}

- (void)reloadRootViewController {
    SYZ_dispatch_async_main_execute(^{
        self.window.rootViewController = [SYZSharedAppDelegateInstance application:[UIApplication sharedApplication] rootViewControllerForWindowWithLaunchOptions:nil];
    })
}

#pragma mark - 生命周期
- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [SYZSharedAppDelegateInstance application:application willFinishLaunchingWithOptions:launchOptions];
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
        //只允许竖屏
    [UIDevice allowOrientationOnlyPortrait];
        //初始化window前
    [SYZSharedAppDelegateInstance application:application willInitWindowWithLaunchOptions:launchOptions];
        //初始化window
    self.window.rootViewController = [SYZSharedAppDelegateInstance application:application rootViewControllerForWindowWithLaunchOptions:launchOptions];
        //初始化window后
    [SYZSharedAppDelegateInstance application:application didInitWindowWithLaunchOptions:launchOptions];
    [SYZSharedAppDelegateInstance application:application didFinishLaunchingWithOptions:launchOptions];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [SYZSharedAppDelegateInstance applicationWillResignActive:application];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [SYZSharedAppDelegateInstance applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [SYZSharedAppDelegateInstance applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [SYZSharedAppDelegateInstance applicationDidBecomeActive:application];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [SYZSharedAppDelegateInstance applicationWillTerminate:application];
}

#pragma mark - 处理URL
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    [SYZSharedAppDelegateInstance application:app openURL:url options:options];
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    [SYZSharedAppDelegateInstance application:application handleOpenURL:url];
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [SYZSharedAppDelegateInstance application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}

#pragma mark - 3D Touch
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    [SYZSharedAppDelegateInstance application:application performActionForShortcutItem:shortcutItem completionHandler:completionHandler];
}

#pragma mark - 处理方向
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    return [[UIDevice currentDevice] syz_orientation];
}

#pragma mark - Spotlight
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler {
    [SYZSharedAppDelegateInstance application:application continueUserActivity:userActivity restorationHandler:restorationHandler];
    return YES;
}

#pragma mark - 远程推送
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [SYZSharedAppDelegateInstance application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

    //ios 8 支持
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    [application registerForRemoteNotifications];
}

    //注册推送失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [SYZSharedAppDelegateInstance application:application didFailToRegisterForRemoteNotificationsWithError:error];
}

    //远程推送
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [SYZSharedAppDelegateInstance application:application didReceiveRemoteNotification:userInfo];
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
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    [SYZSharedAppDelegateInstance userNotificationCenter:center didReceiveNotificationResponse:response withCompletionHandler:completionHandler];
}

    //ios 10 以上程序在前台调用
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
        //程序在前台
    [SYZSharedAppDelegateInstance userNotificationCenter:center willPresentNotification:notification withCompletionHandler:completionHandler];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    [SYZSharedAppDelegateInstance application:application didReceiveLocalNotification:notification];
}

//程序在前台和后台都会走此方法
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [SYZSharedAppDelegateInstance application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
}

#pragma mark - Remote Control
- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)remoteControlReceivedWithEvent:(UIEvent *)event {
    [SYZSharedAppDelegateInstance remoteControlReceivedWithEvent:event];
}

@end
