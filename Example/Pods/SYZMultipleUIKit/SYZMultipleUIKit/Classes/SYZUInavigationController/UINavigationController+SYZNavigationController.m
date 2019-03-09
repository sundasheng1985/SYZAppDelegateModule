//
//  UINavigationController+SYZNavigationController.m
//  SYZMultipleUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import "UINavigationController+SYZNavigationController.h"


@implementation UINavigationController (SYZNavigationController)

- (UIViewController *)syz_rootViewController {
    if (SYZIsNotEmptyArray(self.viewControllers)) {
        return self.viewControllers.firstObject;
    }
    return nil;
}

/**
 同时从导航栈中移除多个viewControllers
 
 @param aViewControllers 多个控制器
 */
- (void)syz_popsViewControllers:(NSArray<UIViewController *> *)aViewControllers {
    if (self.viewControllers.count <= 1) return;
    
    NSMutableArray * pushedViewControllers = [self.viewControllers mutableCopy];
    for (UIViewController * viewController in aViewControllers) {
        if ([self.viewControllers containsObject:viewController ]) {
            [pushedViewControllers removeObject:viewController];
        }
    }
    
    [self setViewControllers:pushedViewControllers animated:NO];
}

/**
 获取controller在导航栈中的索引,如果不在返回 -1
 */
- (NSInteger)syz_indexOfViewController:(UIViewController *)aViewController {
    if ([self.viewControllers containsObject:aViewController]) {
        return [self.viewControllers indexOfObject:aViewController];
    }
    
    return -1;
}

/**
 获取指定控制器在导航栈中的**前**一个控制器,如果没有则返回nil
 @param aViewController 指定的控制器
 */
- (UIViewController *)syz_previousOneOfViewController:(UIViewController *)aViewController {
    NSInteger index = [self syz_indexOfViewController:aViewController];
    if (index == -1 || index == 0) return nil;
    if ([self.viewControllers syz_isValidIndex:(index - 1)]) {
        return self.viewControllers[index - 1];
    }
    return nil;
}

/**
 获取制定控制器在导航栈中的**后**一个控制器,如果没有则返回nil
 @param aViewController 指定的控制器
 */
- (UIViewController *)syz_followingOneOfViewController:(UIViewController *)aViewController {
    NSInteger index = [self syz_indexOfViewController:aViewController];
    if (index == -1) return nil;
    if ([self.viewControllers syz_isValidIndex:(index + 1)]) {
        return self.viewControllers[index + 1];
    }
    return nil;
}


@end
