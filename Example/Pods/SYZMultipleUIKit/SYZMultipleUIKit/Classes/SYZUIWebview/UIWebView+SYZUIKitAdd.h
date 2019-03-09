//
//  UIWebView+SYZUIKitAdd.h
//  SYZUIBasekit
//
//  Created by LeeRay on 2018/12/1.
//

#import <UIKit/UIKit.h>

@interface UIWebView (SYZUIKitAdd)
/** decument路径 */
- (NSString *)syz_documentTitle;

/** 加载网页 */
- (void)syz_loadRequestWithURL:(NSURL *)url;

/* 加载本地资源 */
- (void)syz_loadRequestWithFilePath:(NSString *)filePath;
@end
