//
//  SYZAppDelegateModule.h
//  AppDelegateDemo
//
//  Created by sundasheng1985 on 03/09/2019.
//  Copyright (c) 2019 sundasheng1985. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SYZUIBasekit/SYZUIBasekit.h>
#import <UserNotifications/UserNotifications.h>
#import "SYZAppDelegateModuleProtocol.h"

extern void SYZAppDelegateRegisterModule(Class cls);
extern void SYZAppDelegateUnRegisterModule(id<SYZAppDelegateModuleProtocol> module);

#define SYZSharedAppDelegateInstance ([SYZAppDelegateEventDispatcher sharedInstance])

@interface SYZAppDelegateEventDispatcher : NSObject<SYZAppDelegateModuleProtocol>

SYZSingletonInterface()

/**
 所有已经注册的模块
 */
- (NSArray<Class> *)allModules;

/**
 所以已注册模块的实例
 */
- (NSArray<id<SYZAppDelegateModuleProtocol>> *)allRegisterdModuleInstances;

/**
 取消注册某个模块
 如果已经存在实例，将会移除
 */
- (void)unregisterModule:(id<SYZAppDelegateModuleProtocol>)module;
- (void)unregisterModuleClass:(Class)cls;

@end
