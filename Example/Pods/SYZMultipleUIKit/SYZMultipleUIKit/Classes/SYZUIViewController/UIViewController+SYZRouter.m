//
//  UIViewController+SYZRouter.m
//  SYZMultipleUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import "UIViewController+SYZRouter.h"

@implementation UIViewController (SYZRouter)

- (void)syz_stackRouterEventName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    [[self syz_stackNextViewController] syz_stackRouterEventName:eventName userInfo:userInfo];
}

- (UIViewController *)syz_stackNextViewController {
    if (self.navigationController && [self.navigationController.viewControllers containsObject:self]) {
        return [self.navigationController syz_previousOneOfViewController:self];
    }
    
    if (self.presentingViewController) return [self syz_realPresentingViewController];
    
    return self.parentViewController;
}

- (UIViewController *)syz_realPresentingViewController {
    UIViewController *presentingViewController = self.presentingViewController;
    return [presentingViewController syz_findTopViewController];
}

- (UIViewController *)syz_findTopViewController {
    if ([self isKindOfClass:[UINavigationController class]]) {
        return [[(UINavigationController *)self topViewController] syz_findTopViewController];
    }
    
    if ([self isKindOfClass:[UITabBarController class]]) {
        return [[(UITabBarController *)self selectedViewController] syz_findTopViewController];
    }
    
    if (self.childViewControllers.count > 0) {
        return [[self.childViewControllers firstObject] syz_findTopViewController];
    }
    
    return self;
}


@end
