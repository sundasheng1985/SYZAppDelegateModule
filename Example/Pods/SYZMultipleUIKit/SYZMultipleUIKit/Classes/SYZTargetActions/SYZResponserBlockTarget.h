//
//  SYZResponserBlockTarget.h
//  SYZMultipleUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import <Foundation/Foundation.h>

typedef void(^SYZResponderActionHandler)(id sender);
@interface SYZResponserBlockTarget : NSObject

- (instancetype)initWithBlock:(SYZResponderActionHandler)handlerBlock;

- (void)target_invoked:(id)sender;
@end
