//
//  UIButton+SYZTouchBounds.m
//  SYZMultipleUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import "UIButton+SYZTouchBounds.h"

@implementation UIButton (SYZTouchBounds)

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect bounds = self.bounds;
    static float responderSize = 44;
    if (bounds.size.width < responderSize && bounds.size.height < responderSize) {
        CGFloat width = responderSize - bounds.size.width;
        CGFloat height = responderSize - bounds.size.height;
        bounds = CGRectInset(bounds, - 0.5 * width, - 0.5 * height);
    }
    return CGRectContainsPoint(bounds, point);
}

@end
