/*
 //  CYLTabBarController
 //  CYLTabBarController
 //
 //  Created by 微博@iOS程序犭袁 ( http://weibo.com/luohanchenyilong/ ) on 03/06/19.
 //  Copyright © 2019 https://github.com/ChenYilong . All rights reserved.
 */

#import <UIKit/UIKit.h>
#import "UIView+CYLBadgeExtention.h"
#import "CYLBadgeProtocol.h"

@interface UIBarButtonItem (CYLBadgeExtention)<CYLBadgeProtocol>
- (BOOL)cyl_isShowBadge;

/**
 *  show badge with red dot style and CYLBadgeAnimTypeNone by default.
 */
- (void)cyl_showBadge;

/**
 *  cyl_showBadge
 *
 *  @param value String value, default is `nil`. if value equal @"" means red dot style.
 *  @param aniType
 */
- (void)cyl_showBadgeValue:(NSString *)value
         animationType:(CYLBadgeAnimType)aniType;


/**
 *  clear badge(hide badge)
 */
- (void)cyl_clearBadge;

/**
 *  make bage(if existing) not hiden
 */
- (void)cyl_resumeBadge;
- (BOOL)cyl_isPauseBadge;

@end
