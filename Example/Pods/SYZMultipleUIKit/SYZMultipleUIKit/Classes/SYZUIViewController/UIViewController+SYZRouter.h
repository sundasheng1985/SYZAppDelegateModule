//
//  UIViewController+SYZRouter.h
//  SYZMultipleUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import <UIKit/UIKit.h>
#import <SYZMultipleUIKit/UINavigationController+SYZNavigationController.h>

@interface UIViewController (SYZRouter)

/** 按照 导航控制器 由顶往根 进行事件的传递*/
- (void)syz_stackRouterEventName:(NSString *)eventName userInfo:(NSDictionary *)userInfo;

/** 寻找导航控制器下一个controller,如果不在导航堆栈中，会寻找parentViewController，方向：由顶往根*/
- (UIViewController *)syz_stackNextViewController;

- (UIViewController *)syz_realPresentingViewController;

@end
