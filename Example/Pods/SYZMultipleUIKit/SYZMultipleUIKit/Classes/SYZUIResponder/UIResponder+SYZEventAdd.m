//
//  UIResponder+SYZEventAdd.m
//  SYZUIBasekit
//
//  Created by LeeRay on 2018/12/1.
//

#import "UIResponder+SYZEventAdd.h"

@implementation UIResponder (SYZEventAdd)

- (void)syz_routerEventName:(NSString *)eventName params:(NSDictionary *)params {
    [[self nextResponder] syz_routerEventName:eventName params:params];
}
@end
