//
//  UIView+SYZUIKitAdd.m
//  SYZMultipleUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import "UIView+SYZUIKitAdd.h"
#import <objc/runtime.h>

@implementation UIView (SYZUIKitAdd)

- (void)setSyz_tag:(NSString *)syz_tag {
    objc_setAssociatedObject(self, @"syz_tag", syz_tag, OBJC_ASSOCIATION_COPY);
}

- (NSString *)syz_tag {
    return objc_getAssociatedObject(self, @"syz_tag");
}

- (void)syz_removeAllSubviews {
    [self syz_removeSubviewsOfClass:[UIView class]];
}

- (void)syz_removeSubviewsOfClass:(Class)viewClass {
    //空或者非UIView类型，不执行移除操作
    if (SYZIsEmpty(viewClass) ||
        (![viewClass isSubclassOfClass:[UIView class]] &&
         ![NSStringFromClass(viewClass) isEqualToString:NSStringFromClass([UIView class])])) {
            return;
        }
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:viewClass]) {
            [obj removeFromSuperview];
        }
    }];
}

- (void)syz_removeAllGestureRecognizers {
    for (UIGestureRecognizer *gesture in self.gestureRecognizers) {
        [self removeGestureRecognizer:gesture];
    }
}

- (void)syz_removeGestureRecognizersOfClass:(Class)theClass {
    for (UIGestureRecognizer *gesture in self.gestureRecognizers) {
        if ([gesture isKindOfClass:theClass]) {
            [self removeGestureRecognizer:gesture];
        }
    }
}

/*
 controller容器
 */
- (UIViewController *)syz_viewController {
    UIResponder * nextResponder = self.nextResponder;
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return (UIViewController *)nextResponder;
    } else if ([nextResponder isKindOfClass:[UIView class]]) {
        return [((UIView *)nextResponder) syz_viewController];
    }
    
    return nil;
}

/*
 批量添加subview
 */
- (void)syz_addSubviews:(NSArray<UIView *> *)subviews {
    NSArray * tempSubviews = [subviews copy];
    for (UIView * view in tempSubviews) {
        if ([view isKindOfClass:[UIView class]]) {
            [self addSubview:view];
        }
    }
}

@end
