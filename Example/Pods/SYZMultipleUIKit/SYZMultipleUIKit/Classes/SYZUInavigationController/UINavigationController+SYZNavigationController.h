//
//  UINavigationController+SYZNavigationController.h
//  SYZMultipleUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import <UIKit/UIKit.h>
#import <SYZUIBasekit/SYZUIBasekit.h>

@interface UINavigationController (SYZNavigationController)

- (UIViewController *)syz_rootViewController;

/**
 同时从导航栈中移除多个viewControllers
 
 @param aViewControllers 多个控制器
 */
- (void)syz_popsViewControllers:(NSArray<UIViewController *> *)aViewControllers;

/**
 获取controller在导航栈中的索引,如果不在返回 -1
 */
- (NSInteger)syz_indexOfViewController:(UIViewController *)aViewController;

/**
 获取指定控制器在导航栈中的**前**一个控制器,如果没有则返回nil
 
 @param aViewController 指定的控制器
 */
- (UIViewController *)syz_previousOneOfViewController:(UIViewController *)aViewController;

/**
 获取制定控制器在导航栈中的**后**一个控制器,如果没有则返回nil
 
 @param aViewController 指定的控制器
 */
- (UIViewController *)syz_followingOneOfViewController:(UIViewController *)aViewController;

@end
