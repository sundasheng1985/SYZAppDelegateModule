//
//  UIView+SYZAddition.m
//  SYZMultipleUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import "UIView+SYZAddition.h"

@implementation UIView (SYZAddition)

/**
 *  添加手势
 */
- (void)syz_addGestureRecognizer:(UIGestureRecognizer*)gestureRecognizer {
    [self syz_removeGestureRecognizer:gestureRecognizer];
    
    [self addGestureRecognizer:gestureRecognizer];
}

/**
 *  移除手势
 */
- (void)syz_removeGestureRecognizer:(UIGestureRecognizer*)gestureRecognizer {
    if ([self.gestureRecognizers containsObject:gestureRecognizer]) {
        [self removeGestureRecognizer:gestureRecognizer];
    }
}

- (void)syz_addTapGestureWithHandler:(SYZResponderActionHandler)handler {
    UITapGestureRecognizer * tapges = [UITapGestureRecognizer syz_tapGestureRecognizerWithHandler:handler];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tapges];
}

- (void)syz_addToSuperView:(UIView *)aSuperView {
    if ([aSuperView isKindOfClass:[UIView class]] && [aSuperView respondsToSelector:@selector(addSubview:)]) {
        [aSuperView addSubview:self];
    }
}

- (void)syz_addToViewController:(UIViewController *)aViewController {
    if ([aViewController isKindOfClass:[UIViewController class]] && aViewController.view != nil) {
        [self syz_addToSuperView:aViewController.view];
    }
}

@end
