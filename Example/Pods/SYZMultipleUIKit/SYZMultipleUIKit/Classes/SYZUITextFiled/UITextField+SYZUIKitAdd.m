//
//  UITextField+SYZUIKitAdd.m
//  SYZMultipleUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import "UITextField+SYZUIKitAdd.h"

@implementation UITextField (SYZUIKitAdd)

- (void)syz_clearText {
    self.text = @"";
}
@end
