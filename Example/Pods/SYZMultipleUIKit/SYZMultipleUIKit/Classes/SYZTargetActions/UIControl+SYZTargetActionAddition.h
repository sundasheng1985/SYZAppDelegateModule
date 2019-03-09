//
//  UIControl+SYZTargetActionAddition.h
//  SYZMultipleUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import <UIKit/UIKit.h>
#import <SYZUIBasekit/SYZUIBasekit.h>
#import <SYZMultipleUIKit/SYZResponserBlockTarget.h>

@interface UIControl (SYZTargetActionAddition)

- (void)saveTarget:(SYZResponserBlockTarget *)target forEvents:(UIControlEvents)events;

@end
