//
//  SNHFoundationShorthandMarcos.h
//  SNHFoundation
//
//  Created by 陈建蕾 on 2018/8/17.
//

#ifndef SNHFoundationShorthandMarcos_h
#define SNHFoundationShorthandMarcos_h
#import <Foundation/Foundation.h>

/** 判断代理能不能执行 */
static inline BOOL SNHIsRespondsToSelector(id<NSObject> delegate, SEL sel) {
    return (delegate && [delegate respondsToSelector:sel]);
}

/** 判断某个类里面时候包含此协议 */
static inline BOOL SYZIsConformsToProtocol(id object, Protocol *protocol) {
    return [[object class] conformsToProtocol:protocol];
}


#endif /* SNHFoundationShorthandMarcos_h */
