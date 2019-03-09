//
//  UIViewController+SYZViewController.h
//  SYZMultipleUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import <UIKit/UIKit.h>
#import <SYZUIBasekit/SYZUIBasekit.h>

@interface UIViewController (SYZViewController)

/*!
 *  @brief 将ViewController从导航堆栈中移除，建议在ViewWillDisappear或者ViewDidDisappear中调用，移除的ViewController与所在索引无关
 *  如果当前导航堆栈的ViewControllers是: A、B，接着
 *  B push C 并且 B 在ViewDidDisappear中调用 syz_removeFromNavigationController
 *  那么导航堆栈的ViewControllers变成：A、C
 *
 *  @since 0.2.6
 */
- (void)syz_removeFromNavigationController;

- (UIViewController *)syz_addChildViewController:(UIViewController *)subViewController
                                           frame:(CGRect)frame
                              lastViewController:(UIViewController * _Nullable )lastViewController
                                   containerView:(UIView *)containerView;

/**
 创建导航控制器，rootViewController为self
 */
- (UINavigationController *)syz_toPackagedNavigationController;


/**
 如果 是push 出来的会执行 pop
 如果 是present 会执行 dismiss
 */
- (void)syz_dismissOrPop:(BOOL)animated;


/**
 [self.view addSubview]的简单写法
 */
- (void)syz_addSubview:(UIView *)aSubview;

/** 获取根Controller*/
+ (UIViewController*)syz_currentRootViewController;

/** 获取当前显示的Controller*/
+ (UIViewController*)syz_currentTopViewController;

@end
