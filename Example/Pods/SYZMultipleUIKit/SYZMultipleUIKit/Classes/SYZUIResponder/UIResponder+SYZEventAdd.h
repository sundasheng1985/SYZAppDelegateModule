//
//  UIResponder+SYZEventAdd.h
//  SYZUIBasekit
//
//  Created by LeeRay on 2018/12/1.
//

#import <UIKit/UIKit.h>

@interface UIResponder (SYZEventAdd)

/** 基于响应链传递事件*/
- (void)syz_routerEventName:(NSString *)eventName params:(NSDictionary *)params;
@end
