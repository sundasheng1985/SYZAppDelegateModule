//
//  UIView+SYZAddition.h
//  SYZMultipleUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import <UIKit/UIKit.h>
#import <SYZMultipleUIKit/SYZTargetActions.h>
#import <SYZMultipleUIKit/UITapGestureRecognizer+SYZAddition.h>

@interface UIView (SYZAddition)

/**
 *  添加手势
 */
- (void)syz_addGestureRecognizer:(UIGestureRecognizer*)gestureRecognizer;

/**
 *  移除手势
 */
- (void)syz_removeGestureRecognizer:(UIGestureRecognizer*)gestureRecognizer;

/**
 添加点击手势
 */
- (void)syz_addTapGestureWithHandler:(SYZResponderActionHandler)handler;


/**
 简单的添加subview方法
 */
- (void)syz_addToSuperView:(UIView *)aSuperView;
- (void)syz_addToViewController:(UIViewController *)aViewController;
@end
