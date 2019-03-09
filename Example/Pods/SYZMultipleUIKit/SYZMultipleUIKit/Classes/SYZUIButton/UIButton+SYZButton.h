//
//  UIButton+SYZButton.h
//  SYZMultipleUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import <UIKit/UIKit.h>
#import <SYZMultipleUIKit/SYZTargetActions.h>

@interface UIButton (SYZButton)

+ (UIButton *)syz_buttonForEvents:(UIControlEvents)events WithHandler:(SYZResponderActionHandler)handler ;

- (void)syz_startCountDownWithSecond:(NSInteger)leftSecond;
@end
