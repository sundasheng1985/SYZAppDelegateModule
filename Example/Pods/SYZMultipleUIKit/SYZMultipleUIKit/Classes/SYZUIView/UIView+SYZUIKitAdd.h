//
//  UIView+SYZUIKitAdd.h
//  SYZMultipleUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import <UIKit/UIKit.h>
#import <SYZUIBasekit/SYZUIBasekit.h>

@interface UIView (SYZUIKitAdd)

/** View的唯一标识符*/
@property (nonatomic,copy) NSString * syz_tag;

/*
 移除所有的子视图
 */
- (void)syz_removeAllSubviews;

/*
 移除某种类型的视图
 */
- (void)syz_removeSubviewsOfClass:(Class)viewClass;

/*
 移除所有手势
 */
- (void)syz_removeAllGestureRecognizers;

/*
 移除某种类型的手势
 */
- (void)syz_removeGestureRecognizersOfClass:(Class)theClass;

/*
 controller容器
 */
- (UIViewController *)syz_viewController;

/*
 批量添加subview
 */
- (void)syz_addSubviews:(NSArray<UIView *> *)subviews;

@end
