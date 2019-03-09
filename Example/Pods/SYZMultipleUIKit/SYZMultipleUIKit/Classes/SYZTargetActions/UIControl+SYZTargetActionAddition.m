//
//  UIControl+SYZTargetActionAddition.m
//  SYZMultipleUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import "UIControl+SYZTargetActionAddition.h"
#import <objc/runtime.h>

@implementation UIControl (SYZTargetActionAddition)

- (NSMutableDictionary *)syz_targets {
    NSMutableDictionary * targets = objc_getAssociatedObject(self, _cmd);
    
    if (nil == targets) {
        targets = [NSMutableDictionary new];
        objc_setAssociatedObject(self, _cmd, targets, OBJC_ASSOCIATION_RETAIN);
    }
    
    return targets;
}

- (void)_saveTarget:(SYZResponserBlockTarget *)target forEvent:(UIControlEvents)event {
    if (SYZIsEmpty(target)) {
        return;
    }
    
    NSMutableArray * targetsArrayM = self.syz_targets[@(event)];
    if (targetsArrayM == nil) {
        targetsArrayM = [NSMutableArray new];
    }
    
    [targetsArrayM addObject:target];
    [self.syz_targets setObject:targetsArrayM forKey:@(event)];
}

- (void)saveTarget:(SYZResponserBlockTarget *)target forEvents:(UIControlEvents)events {
    if (SYZIsEmpty(target) || NO == [target isKindOfClass:[SYZResponserBlockTarget class]]) {
        return;
    }
    
    if (events & UIControlEventTouchDown) {
        [self _saveTarget:target forEvent:UIControlEventTouchDown];
    }
    
    if (events & UIControlEventTouchDownRepeat) {
        [self _saveTarget:target forEvent:UIControlEventTouchDownRepeat];
    }
    
    if (events & UIControlEventTouchDragInside) {
        [self _saveTarget:target forEvent:UIControlEventTouchDragInside];
    }
    
    if (events & UIControlEventTouchDragOutside) {
        [self _saveTarget:target forEvent:UIControlEventTouchDragOutside];
    }
    
    if (events & UIControlEventTouchDragEnter) {
        [self _saveTarget:target forEvent:UIControlEventTouchDragEnter];
    }
    
    if (events & UIControlEventTouchDragExit) {
        [self _saveTarget:target forEvent:UIControlEventTouchDragExit];
    }
    
    if (events & UIControlEventTouchUpInside) {
        [self _saveTarget:target forEvent:UIControlEventTouchUpInside];
    }
    
    if (events & UIControlEventTouchUpOutside) {
        [self _saveTarget:target forEvent:UIControlEventTouchUpOutside];
    }
    
    if (events & UIControlEventTouchCancel) {
        [self _saveTarget:target forEvent:UIControlEventTouchCancel];
    }
    
    if (events & UIControlEventValueChanged) {
        [self _saveTarget:target forEvent:UIControlEventValueChanged];
    }
    
    if (@available(iOS 9.0, *)) {
        if (events & UIControlEventPrimaryActionTriggered) {
            [self _saveTarget:target forEvent:UIControlEventPrimaryActionTriggered];
        }
    }
    
    if (events & UIControlEventEditingDidBegin) {
        [self _saveTarget:target forEvent:UIControlEventEditingDidBegin];
    }
    
    if (events & UIControlEventEditingChanged) {
        [self _saveTarget:target forEvent:UIControlEventEditingChanged];
    }
    
    if (events & UIControlEventEditingDidEnd) {
        [self _saveTarget:target forEvent:UIControlEventEditingDidEnd];
    }
    
    if (events & UIControlEventEditingDidEndOnExit) {
        [self _saveTarget:target forEvent:UIControlEventEditingDidEndOnExit];
    }
    
    if (events & UIControlEventAllTouchEvents) {
        [self _saveTarget:target forEvent:UIControlEventAllTouchEvents];
    }
    
    if (events & UIControlEventAllEditingEvents) {
        [self _saveTarget:target forEvent:UIControlEventAllEditingEvents];
    }
    
    if (events & UIControlEventApplicationReserved) {
        [self _saveTarget:target forEvent:UIControlEventApplicationReserved];
    }
    
    if (events & UIControlEventSystemReserved) {
        [self _saveTarget:target forEvent:UIControlEventSystemReserved];
    }
    
    if (events & UIControlEventAllEvents) {
        [self _saveTarget:target forEvent:UIControlEventAllEvents];
    }
}

@end
