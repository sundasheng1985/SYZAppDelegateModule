//
//  SYZAppDelegateModuleProtocol.h
//  Pods
//
//  Created by sundasheng1985 on 03/09/2019.
//  Copyright (c) 2019 sundasheng1985. All rights reserved.
//
//

#import <UIKit/UIKit.h>

#import <UserNotifications/UserNotifications.h>

@protocol SYZAppDelegateModuleProtocol <UIApplicationDelegate,UNUserNotificationCenterDelegate>

#ifndef SYZRegisterAppDelegateModule
    #define SYZRegisterAppDelegateModule() \
    extern void SYZAppDelegateRegisterModule(Class cls); \
    + (void)load { \
        SYZAppDelegateRegisterModule(self);\
    }
#endif

#ifndef SYZUnRegisterAppDelegateModule
    #define SYZUnRegisterAppDelegateModule(module) \
    extern void SYZAppDelegateUnRegisterModule(id<SYZAppDelegateModuleProtocol> module); \
    SYZAppDelegateUnRegisterModule(self);
#endif

@optional
/**
 将要初始化根视图
 */
- (void)application:(UIApplication *)application willInitWindowWithLaunchOptions:(NSDictionary *)launchOptions;

/**
 获取根视图
 */
- (UIViewController *)application:(UIApplication *)application rootViewControllerForWindowWithLaunchOptions:(NSDictionary *)launchOptions;

/**
 已经初始化根视图
 */
- (void)application:(UIApplication *)application didInitWindowWithLaunchOptions:(NSDictionary *)launchOptions;

/**
 接收到远程控制指令
 */
- (void)remoteControlReceivedWithEvent:(UIEvent *)event;

/**
 用户登录成功
 */
- (void)userDidLoginWithUserInfo:(id)userInfo;

/**
 恢复上一次登录的用户成功
 */
- (void)userDidResumeLoginWithUserInfo:(id)userInfo;

/**
 用户退出登录成功
 */
- (void)userDidLogoutWithUserInfo:(id)userInfo;
@end




