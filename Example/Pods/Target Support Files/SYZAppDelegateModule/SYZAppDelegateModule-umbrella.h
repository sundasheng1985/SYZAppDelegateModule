#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "SYZAppDelegateEventDispatcher.h"
#import "SYZAppDelegateModuleProtocol.h"
#import "SYZOriginAppDelegate.h"

FOUNDATION_EXPORT double SYZAppDelegateModuleVersionNumber;
FOUNDATION_EXPORT const unsigned char SYZAppDelegateModuleVersionString[];

