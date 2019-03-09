//
//  SYZUIKitMacro.h
//  Pods
//
//  Created by LeeRay on 2018/12/22.
//
//

#ifndef SYZUIKitMacro_h
#define SYZUIKitMacro_h
#import <UIKit/UIKit.h>
/** 应用状态 */
static inline UIApplicationState SYZApplicationState() {
    return [UIApplication sharedApplication].applicationState;
}

#endif /* SYZUIKitMacro_h */
