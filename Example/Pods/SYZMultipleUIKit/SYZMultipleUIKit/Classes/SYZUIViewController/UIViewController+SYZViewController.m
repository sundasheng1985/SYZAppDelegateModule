//
//  UIViewController+SYZViewController.m
//  SYZMultipleUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import "UIViewController+SYZViewController.h"
#import <objc/runtime.h>

@implementation UIViewController (SYZViewController)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self exchangeInstanceMethod:@selector(initWithNibName:bundle:)
                            toMethod:@selector(syz_initWithNibName:bundle:)];
    });
}

- (instancetype)syz_initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil {
    UIViewController * instance = [self syz_initWithNibName:nibNameOrNil bundle:nil];
    //    if (![instance isKindOfClass:[UITabBarController class]] && ![instance isKindOfClass:[UINavigationController class]]) {
    //         instance.hidesBottomBarWhenPushed = YES;
    //    }
    return instance;
}


- (void)syz_removeFromNavigationController {
    if (self.navigationController) {
        NSUInteger index = [self.navigationController.viewControllers indexOfObject:self];
        if (index != NSNotFound) {
            NSMutableArray * viewControllers = [self.navigationController.viewControllers mutableCopy];
            if ([viewControllers containsObject:self]) {
                [viewControllers removeObject:self];
            }
            
            [self.navigationController setViewControllers:viewControllers animated:NO];
        }
    }
}

- (UIViewController *)syz_addChildViewController:(UIViewController *)subViewController
                                           frame:(CGRect)frame
                              lastViewController:(UIViewController *)lastViewController
                                   containerView:(nonnull UIView *)containerView{
    if (lastViewController == subViewController) {
        return lastViewController;
    }
    
    [lastViewController removeFromParentViewController];
    [lastViewController.view removeFromSuperview];
    
    [subViewController willMoveToParentViewController:self];
    [containerView addSubview:subViewController.view];
    [containerView bringSubviewToFront:subViewController.view];
    subViewController.view.frame = frame;
    [self addChildViewController:subViewController];
    [subViewController didMoveToParentViewController:self];
    
    return subViewController;
}

- (UINavigationController *)syz_toPackagedNavigationController {
    return [[UINavigationController alloc] initWithRootViewController:self];
}

- (void)syz_dismissOrPop:(BOOL)animated {
    if (self.navigationController) {
        if (self.navigationController.viewControllers.count > 0) {
            if (self.navigationController.viewControllers.firstObject == self) {
                [self.navigationController dismissViewControllerAnimated:animated completion:nil];
            } else {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    } else {
        if (self.presentingViewController) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

- (void)syz_addSubview:(UIView *)aSubview {
    if ([aSubview isKindOfClass:[UIView class]]) {
        [self.view addSubview:aSubview];
    }
}

/** 获取根Controller*/
+ (UIViewController*)syz_currentRootViewController {
    return [UIApplication sharedApplication].delegate.window.rootViewController;
}

/** 获取当前显示的Controller*/
+ (UIViewController*)syz_currentTopViewController {
    UIViewController *topViewController = [self syz_currentRootViewController];
    while (true) {
        if (topViewController.presentedViewController) {
            topViewController = topViewController.presentedViewController;
        } else if ([topViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)topViewController topViewController]) {
            topViewController = [(UINavigationController *)topViewController topViewController];
        } else if ([topViewController isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tab = (UITabBarController *)topViewController;
            topViewController = tab.selectedViewController;
        } else {
            break;
        }
    }
    return topViewController;
}

@end
