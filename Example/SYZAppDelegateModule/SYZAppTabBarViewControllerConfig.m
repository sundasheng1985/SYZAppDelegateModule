//
//  SYZAppTabBarViewControllerConfig.m
//  SYZAppDelegateModule_Example
//
//  Created by LeeRay on 2019/3/9.
//  Copyright © 2019年 sundasheng1985. All rights reserved.
//

#import "SYZAppTabBarViewControllerConfig.h"
#import <SYZMultipleUIKit/SYZMultipleUIKit.h>
#import "SYZAppUINavigationViewController.h"
#import "SYZAppTabBarCenterButton.h"
#import "SYZFirstViewController.h"

@interface SYZAppTabBarViewControllerConfig ()<CYLTabBarControllerDelegate, UITabBarControllerDelegate>

@property (nonatomic, copy) NSArray<UIViewController *> *viewControllers;
@property (nonatomic, copy) NSArray<NSDictionary *> *attributes;
@property (nonatomic, strong) CYLTabBarController *tabBarController;
@end

@implementation SYZAppTabBarViewControllerConfig

/** 必须注册 */
SYZRegisterAppDelegateModule()


- (void)application:(UIApplication *)application willInitWindowWithLaunchOptions:(NSDictionary *)launchOptions {
    [SYZAppTabBarCenterButton registerPlusButton];
    self.tabBarController.delegate = self;
}

- (UIViewController *)application:(UIApplication *)application rootViewControllerForWindowWithLaunchOptions:(NSDictionary *)launchOptions {
    /** 项目必须要有根视图否则闪退 */
    return self.tabBarController;
}

#pragma mark - <UITabBarControllerDelegate>
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectControl:(UIControl *)control {
    //    if ([control cyl_isTabButton]) {
    //        UIView *view = [control cyl_tabImageView];
    //        [self _addAnimationOnView:view repeatCount:1];
    //    }
}

- (void)_addAnimationOnView:(UIView *)view repeatCount:(NSInteger)repeatCount {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@1.0,@1.01,@0.9,@1.15,@0.95,@1.02,@1.0];
    animation.duration = 1;
    animation.repeatCount = repeatCount;
    animation.calculationMode = kCAAnimationCubic;
    [view.layer addAnimation:animation forKey:nil];
}

#pragma mark - Lazy
- (CYLTabBarController *)tabBarController {
    if (!_tabBarController) {
        _tabBarController = [CYLTabBarController tabBarControllerWithViewControllers:self.viewControllers tabBarItemsAttributes:self.attributes imageInsets:UIEdgeInsetsMake(5.5, 0, -5.5, 0) titlePositionAdjustment:UIOffsetZero];
        _tabBarController.tabBarHeight = SYZSafeWindowInsets().bottom + 49;
        [[UITabBar appearance] setBackgroundImage:[UIImage new]];
        [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
        if (@available(iOS 10.0, *)) {
            [_tabBarController hideTabBadgeBackgroundSeparator];
        } else {
            [[UITabBar appearance] setShadowImage:[UIImage new]];
        }
    }
    return _tabBarController;
}

- (NSArray<UIViewController *> *)viewControllers {
    if (!_viewControllers) {
        _viewControllers = @[[self _packageVC:[SYZFirstViewController new]],
                             [self _packageVC:[SYZFirstViewController new]],
                             [self _packageVC:[SYZFirstViewController new]],
                             [self _packageVC:[SYZFirstViewController new]]];
    }
    return _viewControllers;
}

- (UIViewController *)_packageVC:(UIViewController *)vc {
    return [[SYZAppUINavigationViewController alloc] initWithRootViewController:vc];
}

- (NSArray<NSDictionary *> *)attributes {
    if (!_attributes) {
        _attributes = @[@{CYLTabBarItemImage: @"tabbar_home",
                          CYLTabBarItemSelectedImage: @"tabbar_home_selected"},
                        @{CYLTabBarItemImage: @"tabbar_home",
                          CYLTabBarItemSelectedImage: @"tabbar_home_selected"},
                        @{CYLTabBarItemImage: @"tabbar_home",
                          CYLTabBarItemSelectedImage: @"tabbar_home_selected"},
                        @{CYLTabBarItemImage: @"tabbar_home",
                          CYLTabBarItemSelectedImage: @"tabbar_home_selected"}];
    }
    return _attributes;
}


@end
