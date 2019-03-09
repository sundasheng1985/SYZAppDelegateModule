//
//  UIImageView+SYZBundleImage.h
//  SYZUIBasekit
//
//  Created by LeeRay on 2018/12/1.
//

#import <UIKit/UIKit.h>

@interface UIImageView (SYZBundleImage)

/** 加载这个bundle下面的图片 */
- (void)syz_imageNamed:(NSString *)imageName fromClassBundle:(Class)className;
@end
