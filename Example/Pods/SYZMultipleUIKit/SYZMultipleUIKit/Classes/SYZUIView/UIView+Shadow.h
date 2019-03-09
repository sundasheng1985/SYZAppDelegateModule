//
//  UIView+Shadow.h
//  SYZMultipleUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import <UIKit/UIKit.h>

@interface UIView (Shadow)

/** 设置阴影 */
- (void) makeInsetShadow;

/** 设置阴影倒角和透明度 */
- (void) makeInsetShadowWithRadius:(float)radius Alpha:(float)alpha;

/** 设置阴影倒角和透明度和方向 */
- (void) makeInsetShadowWithRadius:(float)radius Color:(UIColor *)color Directions:(NSArray *)directions;


@end
