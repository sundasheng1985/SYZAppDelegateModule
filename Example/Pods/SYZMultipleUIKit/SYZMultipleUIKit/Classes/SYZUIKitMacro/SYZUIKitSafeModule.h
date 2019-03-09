//
//  SYZUIKitSafeModule.h
//  SYZUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import <Foundation/Foundation.h>

extern UIWindow * SYZSafeWindow(void);
extern UIEdgeInsets SYZSafeWindowInsets(void);
extern CGRect SYZStatusBarCGRect(void);

@interface SYZUIKitSafeModule : NSObject

@end
