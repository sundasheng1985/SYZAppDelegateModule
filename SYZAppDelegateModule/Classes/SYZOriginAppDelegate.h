//
//  AppDelegate.h
//  AppDelegateDemo
//
//  Created by sundasheng1985 on 03/09/2019.
//  Copyright (c) 2019 sundasheng1985. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SYZUIBasekit/SYZUIBasekit.h>

@interface SYZOriginAppDelegate : UIResponder <UIApplicationDelegate>

SYZSingletonInterface()

@property (strong, nonatomic) UIWindow *window;

/**
 重新替换根视图
 */
- (void)reloadRootViewController;

@end

