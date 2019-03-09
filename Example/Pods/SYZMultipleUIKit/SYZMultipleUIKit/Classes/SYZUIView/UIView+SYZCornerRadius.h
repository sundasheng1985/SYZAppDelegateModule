//
//  UIView+SYZCornerRadius.h
//  SYZMultipleUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSInteger, SYZRectCorner) {
    SYZRectCornerTop = 1 << 0,
    SYZRectCornerBottom = 1 << 1,
    SYZRectCornerNone = 0,
    SYZRectCornerAll = SYZRectCornerTop | SYZRectCornerBottom,
};

@interface UIView (SYZCornerRadius)

/** 设置倒角类型 */
@property (nonatomic , assign) SYZRectCorner syz_rectCorner;

/** 倒角 */
- (void)syz_setCornerRadius:(CGFloat)radius;

@end
