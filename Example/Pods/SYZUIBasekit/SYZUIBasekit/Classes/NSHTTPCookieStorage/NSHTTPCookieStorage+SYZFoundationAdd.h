//
//  NSHTTPCookieStorage+SYZFoundationAdd.h
//  Pods-SYZUIBasekit_Example
//
//  Created by LeeRay on 2018/12/1.
//

#import <Foundation/Foundation.h>
#import <SYZUIBasekit/NSString+SYZString.h>
#import <SYZUIBasekit/NSArray+SYZArrayAdd.h>

@interface NSHTTPCookieStorage (SYZFoundationAdd)
- (void)syz_removeCookiesForDomain:(NSString *)domain;

- (void)syz_removeCookiesForDomains:(NSArray*)domains;
@end
