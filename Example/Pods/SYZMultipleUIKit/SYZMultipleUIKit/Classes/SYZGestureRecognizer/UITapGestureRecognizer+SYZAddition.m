//
//  UITapGestureRecognizer+SYZAddition.m
//  SYZMultipleUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import "UITapGestureRecognizer+SYZAddition.h"

@implementation UITapGestureRecognizer (SYZAddition)

+ (UITapGestureRecognizer *)syz_tapGestureRecognizerWithHandler:(SYZResponderActionHandler)handler {
    SYZResponserBlockTarget * target = [[SYZResponserBlockTarget alloc] initWithBlock:handler];
    UITapGestureRecognizer * tagGes = [[UITapGestureRecognizer alloc] initWithTarget:target action:@selector(target_invoked:)];
    tagGes.numberOfTapsRequired = 1;
    tagGes.numberOfTouchesRequired = 1;
    [tagGes saveTarget:target];
    return tagGes;
}

@end
