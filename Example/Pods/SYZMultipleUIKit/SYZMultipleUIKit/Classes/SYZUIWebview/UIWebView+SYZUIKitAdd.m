//
//  UIWebView+SYZUIKitAdd.m
//  SYZUIBasekit
//
//  Created by LeeRay on 2018/12/1.
//

#import "UIWebView+SYZUIKitAdd.h"

@implementation UIWebView (SYZUIKitAdd)

- (NSString *)syz_documentTitle {
    return [self stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (void)syz_loadRequestWithURL:(NSURL *)url {
    [self loadRequest:[NSURLRequest requestWithURL:url]];
}

/*
 加载本地资源
 */
- (void)syz_loadRequestWithFilePath:(NSString *)filePath {
    [self syz_loadRequestWithURL:[NSURL fileURLWithPath:filePath]];
}
@end
