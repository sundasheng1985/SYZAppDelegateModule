//
//  NSData+SYZFoundationAdd.h
//  Pods
//
//  Created by LeeRay on 2018/11/11.
//

#import <Foundation/Foundation.h>

@interface NSData (SYZFoundationAdd)
/** 字符串 转 data */
+ (NSData *)syz_dataWithBytesString:(NSString *)bytesString;

/** data 转 字符串 */
- (NSString *)syz_bytesString;
@end
