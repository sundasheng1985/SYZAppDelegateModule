//
//  UIView+SYZCornerRadius.m
//  SYZMultipleUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import "UIView+SYZCornerRadius.h"
#import <objc/runtime.h>

@implementation UIView (SYZCornerRadius)

- (SYZRectCorner)syz_rectCorner {
    NSNumber *corner = objc_getAssociatedObject(self, @selector(syz_rectCorner));
    return corner.integerValue;
}

- (void)setSyz_rectCorner:(SYZRectCorner)syz_rectCorner {
    objc_setAssociatedObject(self, @selector(syz_rectCorner), @(syz_rectCorner), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)syz_setCornerRadius:(CGFloat)radius {
    if (radius == 0) {
        [self _setNoneCorner];
        return;
    }
    
    switch (self.syz_rectCorner) {
        case SYZRectCornerTop: {
            [self _setTopCornerRadius:radius];
            break;
        }
        case SYZRectCornerBottom: {
            [self _setBottomCornerRadius:radius];
            break;
        }
        case SYZRectCornerNone: {
            [self _setNoneCorner];
            break;
        }
        case SYZRectCornerAll: {
            [self _setAllCornerRadius:radius];
            break;
        }
        default:
            break;
    }
}

- (void)_setTopCornerRadius:(CGFloat)radius {
    if (radius < 0) {
        return;
    }
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
                                                         cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (void)_setBottomCornerRadius:(CGFloat)radius {
    if (radius < 0) {
        return;
    }
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight)
                                                         cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (void)_setAllCornerRadius:(CGFloat)radius {
    if (radius < 0) {
        return;
    }
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:radius];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (void)_setNoneCorner {
    self.layer.mask = nil;
}

@end
