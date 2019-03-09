//
//  SYZAppDelegateModule.m
//  AppDelegateDemo
//
//  Created by sundasheng1985 on 03/09/2019.
//  Copyright (c) 2019 sundasheng1985. All rights reserved.
//

#import "SYZAppDelegateEventDispatcher.h"

#define SYZAppDelegateManagerExecuteMethod(block) \
    do {    \
        NSArray * allInstances = nil;   \
        @synchronized (self.allModuleInstances) {   \
            allInstances = [self.allModuleInstances copy];  \
        }   \
        for (id<SYZAppDelegateModuleProtocol> module in allInstances) { \
            if ([module respondsToSelector:_cmd]) { \
                block(module);  \
            }   \
        }   \
    } while (0);

static NSMutableArray * allModules;
void SYZAppDelegateRegisterModule(Class cls) {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        allModules = [NSMutableArray new];
    });

    if ([cls conformsToProtocol:@protocol(SYZAppDelegateModuleProtocol)] == NO) {
        [[NSException exceptionWithName:@"SYZAppDelegateManager" reason:[NSString stringWithFormat:@"%@ 模块没有遵循SYZAppDelegateModuleProtocol协议",cls] userInfo:nil] raise];
    }

    [allModules addObject:cls];
}

void SYZAppDelegateUnRegisterModule(id<SYZAppDelegateModuleProtocol> module) {
    [SYZSharedAppDelegateInstance unregisterModule:module];
}

@interface SYZAppDelegateEventDispatcher ()
@property (nonatomic,strong) NSMutableArray * allModuleInstances;
@end

@implementation SYZAppDelegateEventDispatcher

SYZSingletonImplementation(SYZAppDelegateEventDispatcher)

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self _instanceModules];
    }
    return self;
}

#pragma mark - Public
- (NSArray<Class> *)allModules {
    NSArray * _allModules = nil;
    @synchronized (allModules) {
        _allModules = [allModules copy];
    }
    return _allModules;
}

- (NSArray<id<SYZAppDelegateModuleProtocol>> *)allRegisterdModuleInstances {
    NSArray * allInstances = nil;
    @synchronized (self.allModuleInstances) {
        allInstances = [self.allModuleInstances copy];
    }
    return allInstances;
}

- (void)unregisterModule:(id<SYZAppDelegateModuleProtocol>)module {
    @synchronized (self.allModuleInstances) {
        if ([self.allModuleInstances containsObject:module]) {
            [self.allModuleInstances removeObject:module];
            [allModules removeObject:[module class]];
        }
    }
}

- (void)unregisterModuleClass:(Class)cls {
    NSString * clsName = NSStringFromClass(cls);
    NSArray * allInstances = [self allRegisterdModuleInstances];
    for (id<SYZAppDelegateModuleProtocol> instance in allInstances) {
        if ([NSStringFromClass([instance class]) isEqualToString:clsName]) {
            [self unregisterModule:instance];
            break;
        }
    }
}

#pragma mark - Private
- (void)_instanceModules {
    if (allModules.count > 0) {
        _allModuleInstances = [NSMutableArray new];
        NSArray * allModulesI = [self allModules];
        for (Class moduleClass in allModulesI) {
            id moduleInstance = [[moduleClass alloc] init];
            if (moduleInstance) {
                [_allModuleInstances addObject:moduleInstance];
            }
        }
    }
}

/**
 将要初始化根视图
 */
- (void)application:(UIApplication *)application willInitWindowWithLaunchOptions:(NSDictionary *)launchOptions {
    SYZAppDelegateManagerExecuteMethod(^(id<SYZAppDelegateModuleProtocol> module){
        [module application:application willInitWindowWithLaunchOptions:launchOptions];
    })
}

/**
 获取根视图
 */
- (UIViewController *)application:(UIApplication *)application rootViewControllerForWindowWithLaunchOptions:(NSDictionary *)launchOptions {

//#ifdef DEBUG
//    //如果检测到多个module或者没有任何模块实现该方法，则直接崩溃
//    NSArray * debugModules = [self.allModuleInstances copy];
//    BOOL didIMP = NO;
//    for (id<SYZAppDelegateModuleProtocol> module in debugModules) {
//        if ([module respondsToSelector:@selector(application:rootViewControllerForWindowWithLaunchOptions:)]) {
//            if (didIMP) {
//                    //说明是第二个实现的模块了，崩溃
//                [[NSException exceptionWithName:@"启动失败" reason:@"多个模块实现了application:rootViewControllerForWindowWithLaunchOptions:" userInfo:nil] raise];
//            } else {
//                didIMP = YES;
//            }
//        }
//    }
//
//    if (didIMP == NO) {
//            //说明没有任何模块实现，崩溃
//        [[NSException exceptionWithName:@"启动失败" reason:@"没有任何模块实现application:rootViewControllerForWindowWithLaunchOptions:" userInfo:nil] raise];
//    }
//
//#endif

    UIViewController * rootViewController = nil;
    NSArray * modules = [self.allModuleInstances copy];
    for (id<SYZAppDelegateModuleProtocol> module in modules) {
        if ([module respondsToSelector:@selector(application:rootViewControllerForWindowWithLaunchOptions:)]) {
            UIViewController * viewController = [module application:application rootViewControllerForWindowWithLaunchOptions:launchOptions];
            if (viewController) {
                rootViewController = viewController;
                break;
            }
        }
    }

    return rootViewController;
}

/**
 已经初始化根视图
 */
- (void)application:(UIApplication *)application didInitWindowWithLaunchOptions:(NSDictionary *)launchOptions {
    SYZAppDelegateManagerExecuteMethod(^(id<SYZAppDelegateModuleProtocol> module){
        [module application:application didInitWindowWithLaunchOptions:launchOptions];
    })
}

#pragma mark - UIApplicationDelegate
- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    SYZAppDelegateManagerExecuteMethod(^(id<SYZAppDelegateModuleProtocol> module) {
        [module application:application willFinishLaunchingWithOptions:launchOptions];
    })
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    SYZAppDelegateManagerExecuteMethod(^(id<SYZAppDelegateModuleProtocol> module){
        [module application:application didFinishLaunchingWithOptions:launchOptions];
    })
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    SYZAppDelegateManagerExecuteMethod(^(id<SYZAppDelegateModuleProtocol> module){
        [module applicationWillResignActive:application];
    })
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    SYZAppDelegateManagerExecuteMethod(^(id<SYZAppDelegateModuleProtocol> module){
        [module applicationDidEnterBackground:application];
    })
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    SYZAppDelegateManagerExecuteMethod(^(id<SYZAppDelegateModuleProtocol> module){
        [module applicationWillEnterForeground:application];
    })
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    SYZAppDelegateManagerExecuteMethod(^(id<SYZAppDelegateModuleProtocol> module){
        [module applicationDidBecomeActive:application];
    })
}

- (void)applicationWillTerminate:(UIApplication *)application {
    SYZAppDelegateManagerExecuteMethod(^(id<SYZAppDelegateModuleProtocol> module){
        [module applicationWillTerminate:application];
    })
}

#pragma mark - 处理URL
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    SYZAppDelegateManagerExecuteMethod(^(id<SYZAppDelegateModuleProtocol> module){
        [module application:app openURL:url options:options];
    })
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    SYZAppDelegateManagerExecuteMethod(^(id<SYZAppDelegateModuleProtocol> module){
        [module application:application handleOpenURL:url];
    })
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    SYZAppDelegateManagerExecuteMethod(^(id<SYZAppDelegateModuleProtocol> module){
        [module application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
    })
    return YES;
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    SYZAppDelegateManagerExecuteMethod(^(id<SYZAppDelegateModuleProtocol> module){
        [module application:application performActionForShortcutItem:shortcutItem completionHandler:completionHandler];
    })
}

#pragma mark - Spotlight
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler {
    SYZAppDelegateManagerExecuteMethod(^(id<SYZAppDelegateModuleProtocol> module) {
        [module application:application continueUserActivity:userActivity restorationHandler:restorationHandler];
    })
    return YES;
}

#pragma mark - 远程推送
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    SYZAppDelegateManagerExecuteMethod(^(id<SYZAppDelegateModuleProtocol> module){
        [module application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
    })
}

    //ios 8 支持
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    [application registerForRemoteNotifications];
}

    //注册推送失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    SYZAppDelegateManagerExecuteMethod(^(id<SYZAppDelegateModuleProtocol> module){
        [module application:application didFailToRegisterForRemoteNotificationsWithError:error];
    })
}

    //远程推送
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    SYZAppDelegateManagerExecuteMethod(^(id<SYZAppDelegateModuleProtocol> module){
        [module application:application didReceiveRemoteNotification:userInfo];
    })
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
    SYZAppDelegateManagerExecuteMethod(^(id<SYZAppDelegateModuleProtocol> module){
        [module userNotificationCenter:center didReceiveNotificationResponse:response withCompletionHandler:completionHandler];
    })
}

    //ios 10 以上程序在前台调用
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
        //程序在前台
    SYZAppDelegateManagerExecuteMethod(^(id<SYZAppDelegateModuleProtocol> module){
        [module userNotificationCenter:center willPresentNotification:notification withCompletionHandler:completionHandler];
    })
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    SYZAppDelegateManagerExecuteMethod(^(id<SYZAppDelegateModuleProtocol> module){
        [module application:application didReceiveLocalNotification:notification];
    })
}

    //程序在前台和后台都会走此方法
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    SYZAppDelegateManagerExecuteMethod(^(id<SYZAppDelegateModuleProtocol> module){
        [module application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
    })
}

#pragma mark - Remote Control
- (void)remoteControlReceivedWithEvent:(UIEvent *)event {
    SYZAppDelegateManagerExecuteMethod(^(id<SYZAppDelegateModuleProtocol> module){
        [module remoteControlReceivedWithEvent:event];
    })
}

#pragma mark - User Status
- (void)userDidLoginWithUserInfo:(id)userInfo {
    SYZAppDelegateManagerExecuteMethod(^(id<SYZAppDelegateModuleProtocol> module){
        [module userDidLoginWithUserInfo:userInfo];
    })
}

- (void)userDidLogoutWithUserInfo:(id)userInfo {
    SYZAppDelegateManagerExecuteMethod(^(id<SYZAppDelegateModuleProtocol> module){
        [module userDidLogoutWithUserInfo:userInfo];
    })
}

- (void)userDidResumeLoginWithUserInfo:(id)userInfo {
    SYZAppDelegateManagerExecuteMethod(^(id<SYZAppDelegateModuleProtocol> module){
        [module userDidResumeLoginWithUserInfo:userInfo];
    })
}

@end
