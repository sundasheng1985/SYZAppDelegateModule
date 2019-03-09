//
//  UIView+SYZLayoutAddition.m
//  SYZMultipleUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import "UIView+SYZLayoutAddition.h"

/**
 此处不可使用 dispatch_once获取屏幕宽高，因为横屏时会变化
 */
CGRect const syz_fullScreenFrame(void) {
    return [UIScreen mainScreen].bounds;
}

//全屏 宽度
CGFloat const syz_screenWidth(void) {
    return syz_fullScreenFrame().size.width;
}
//全屏 高度
CGFloat const syz_screenHeight(void) {
    return syz_fullScreenFrame().size.height;
}

@implementation UIView (SYZLayoutAddition)

- (CGFloat)syz_x {
    return CGRectGetMinX(self.frame);
}

- (void)setSyz_x:(CGFloat)syz_x {
    self.frame = CGRectMake(syz_x, self.syz_y, self.syz_width, self.syz_height);
}

- (CGFloat)syz_maxX {
    return CGRectGetMaxX(self.frame);
}

- (void)setSyz_maxX:(CGFloat)syz_maxX {}

- (CGFloat)syz_centerX {
    return self.center.x;
}

- (void)setSyz_centerX:(CGFloat)syz_centerX {
    self.center = CGPointMake(syz_centerX, self.center.y);
}

- (CGFloat)syz_y {
    return CGRectGetMinY(self.frame);
}

- (void)setSyz_y:(CGFloat)syz_y {
    self.frame = CGRectMake(self.syz_x, syz_y, self.syz_width, self.syz_height);
}

- (CGFloat)syz_centerY {
    return self.center.y;
}

- (void)setSyz_centerY:(CGFloat)syz_centerY {
    self.center = CGPointMake(self.center.x, syz_centerY);
}

- (CGFloat)syz_maxY {
    return CGRectGetMaxY(self.frame);
}

- (void)setSyz_maxY:(CGFloat)syz_maxY {}

- (CGFloat)syz_width {
    return self.frame.size.width;
}

- (void)setSyz_width:(CGFloat)syz_width {
    CGRect frame = self.frame;
    frame.size.width = syz_width;
    self.frame = frame;
}

- (CGFloat)syz_height {
    return self.frame.size.height;
}

- (void)setSyz_height:(CGFloat)syz_height {
    CGRect frame = self.frame;
    frame.size.height = syz_height;
    self.frame = frame;
}

- (CGPoint)syz_origin {
    return self.frame.origin;
}

- (void)setSyz_origin:(CGPoint)syz_origin {
    CGRect frame = self.frame;
    frame.origin = syz_origin;
    self.frame = frame;
}

- (CGSize)syz_size {
    return self.frame.size;
}

- (void)setSyz_size:(CGSize)syz_size {
    CGRect frame = self.frame;
    frame.size = syz_size;
    self.frame = frame;
}

- (CGFloat)syz_top {
    return self.syz_origin.y;
}

- (void)setSyz_top:(CGFloat)syz_top {
    CGRect frame = self.frame;
    frame.origin.y = syz_top;
    self.frame = frame;
}

- (CGFloat)syz_left {
    return self.syz_origin.x;
}

- (void)setSyz_left:(CGFloat)syz_left {
    CGRect frame = self.frame;
    frame.origin.x = syz_left;
    self.frame = frame;
}

- (CGFloat)syz_bottom {
    return self.syz_origin.y + self.syz_size.height;
}

- (void)setSyz_bottom:(CGFloat)syz_bottom {
    CGRect frame = self.frame;
    frame.origin.y = syz_bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)syz_right {
    return self.syz_origin.x + self.syz_size.width;
}

- (void)setSyz_right:(CGFloat)syz_right {
    CGRect frame = self.frame;
    frame.origin.x = syz_right - frame.size.width;
    self.frame = frame;
}


@end
