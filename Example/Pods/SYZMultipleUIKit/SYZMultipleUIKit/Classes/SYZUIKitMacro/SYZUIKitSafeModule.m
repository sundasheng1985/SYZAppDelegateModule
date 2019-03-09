//
//  SYZUIKitSafeModule.m
//  SYZUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import "SYZUIKitSafeModule.h"

UIWindow * SYZSafeWindow() {
    UIWindow *safeWindow = [UIApplication sharedApplication].delegate.window;
    return safeWindow;
}

UIEdgeInsets SYZSafeWindowInsets() {
    if (@available(iOS 11.0, *)) {
        return SYZSafeWindow().safeAreaInsets;
    }
    return UIEdgeInsetsZero;
}

CGRect SYZStatusBarCGRect() {
    return [[UIApplication sharedApplication] statusBarFrame];
}

@implementation SYZUIKitSafeModule

@end
