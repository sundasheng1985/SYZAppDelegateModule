//
//  UITabBarController+SYZTabbarController.m
//  SYZMultipleUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import "UITabBarController+SYZTabbarController.h"

@implementation UITabBarController (SYZTabbarController)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self exchangeInstanceMethod:@selector(setViewControllers:) toMethod:@selector(syz_setViewControllers:)];
    });
}

- (void)syz_setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers {
    for (UIViewController * viewController in viewControllers) {
        
        if ([viewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController * navController = (UINavigationController *)viewController;
            if (navController.viewControllers.count > 0) {
                navController.viewControllers.firstObject.hidesBottomBarWhenPushed = NO;
            }
            
            continue;
        }
        
        viewController.hidesBottomBarWhenPushed = NO;
    }
    
    [self syz_setViewControllers:viewControllers];
}

@end
