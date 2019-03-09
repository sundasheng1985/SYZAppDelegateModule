//
//  UITapGestureRecognizer+SYZAddition.h
//  SYZMultipleUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import <UIKit/UIKit.h>
#import <SYZMultipleUIKit/SYZTargetActions.h>

@interface UITapGestureRecognizer (SYZAddition)


+ (UITapGestureRecognizer *)syz_tapGestureRecognizerWithHandler:(SYZResponderActionHandler)handler;

@end
