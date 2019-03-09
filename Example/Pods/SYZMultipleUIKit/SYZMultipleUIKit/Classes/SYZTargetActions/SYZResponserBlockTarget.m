//
//  SYZResponserBlockTarget.m
//  SYZMultipleUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import "SYZResponserBlockTarget.h"

@interface SYZResponserBlockTarget ()

@property (nonatomic,copy) SYZResponderActionHandler handler;

@end

@implementation SYZResponserBlockTarget

- (instancetype)initWithBlock:(SYZResponderActionHandler)handlerBlock {
    if (self = [super init]) {
        self.handler = handlerBlock;
    }
    
    return self;
}

- (void)target_invoked:(id)sender {
    if (self.handler) {
        self.handler(sender);
    }
}

- (void)dealloc {
    NSLog(@"SYZResponserBlockTarget dealloc");
}
@end
