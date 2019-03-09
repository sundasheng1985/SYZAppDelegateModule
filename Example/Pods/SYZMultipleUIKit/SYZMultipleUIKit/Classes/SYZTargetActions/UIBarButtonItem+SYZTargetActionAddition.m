//
//  UIBarButtonItem+SYZTargetActionAddition.m
//  SYZMultipleUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import "UIBarButtonItem+SYZTargetActionAddition.h"
#import <objc/runtime.h>

@implementation UIBarButtonItem (SYZTargetActionAddition)

- (NSMutableArray *)snh_targets {
    NSMutableArray * targets = objc_getAssociatedObject(self, _cmd);
    
    if (targets == nil) {
        targets = [NSMutableArray new];
        objc_setAssociatedObject(self, _cmd, targets, OBJC_ASSOCIATION_RETAIN);
    }
    
    return targets;
}

- (void)saveTarget:(SYZResponserBlockTarget *)target {
    if (SYZIsEmpty(target) || NO == [target isKindOfClass:[SYZResponserBlockTarget class]]) {
        return;
    }
    
    [self.snh_targets addObject:target];
}

@end
