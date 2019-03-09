//
//  UITextView+SYZUIKitAdd.m
//  SYZMultipleUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import "UITextView+SYZUIKitAdd.h"
#import <objc/runtime.h>

@interface UITextView ()<UITextViewDelegate>

@end

@implementation UITextView (SYZUIKitAdd)

- (void)syz_clearText {
    self.text = @"";
}

- (void)setMaxCount:(NSInteger)maxCount {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextViewTextDidChangeNotification
                                                  object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onTextChanged:)
                                                 name:UITextViewTextDidChangeNotification
                                               object:self];
    self.delegate = self;
    objc_setAssociatedObject(self, _cmd, @(maxCount), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSInteger)maxCount {
    return [objc_getAssociatedObject(self, @selector(setMaxCount:)) integerValue];
}

- (void)onTextChanged:(NSNotification *)noti {
    
    UITextRange * textRange = [self markedTextRange];
    NSString * markedText = @"";
    if (NO == textRange.isEmpty) {
        markedText = [self textInRange:textRange];
    }
    if (markedText.length > 0) {
        return;
    }
    
    if (self.maxCount >= 0 && self.text.length > self.maxCount) {
        self.text = [self.text substringToIndex:self.maxCount];
    }
}


@end
