//
//  NSHTTPCookieStorage+SYZFoundationAdd.m
//  Pods-SYZUIBasekit_Example
//
//  Created by LeeRay on 2018/12/1.
//

#import "NSHTTPCookieStorage+SYZFoundationAdd.h"

@implementation NSHTTPCookieStorage (SYZFoundationAdd)
- (void)syz_removeCookiesForDomain:(NSString *)domain {
    if (SYZIsEmptyString(domain)) {
        return;
    }
    [self syz_removeCookiesForDomains:@[domain]];
}

- (void)syz_removeCookiesForDomains:(NSArray*)domains{
    if (SYZIsEmptyArray(domains)) {
        return;
    }
    for (NSHTTPCookie* cookie in self.cookies) {
        NSString* _domain = [cookie domain];
        for (NSString* domain in domains) {
            if ([_domain rangeOfString:domain options:NSCaseInsensitiveSearch].location != NSNotFound) {
                [self deleteCookie:cookie];
                break;
            }
        }
    }
}
@end
