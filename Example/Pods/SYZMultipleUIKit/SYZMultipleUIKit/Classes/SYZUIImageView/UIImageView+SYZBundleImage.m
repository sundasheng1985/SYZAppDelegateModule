//
//  UIImageView+SYZBundleImage.m
//  SYZUIBasekit
//
//  Created by LeeRay on 2018/12/1.
//

#import "UIImageView+SYZBundleImage.h"

@implementation UIImageView (SYZBundleImage)

- (void)syz_imageNamed:(NSString *)imageName fromClassBundle:(Class)className {
    NSArray *imageNames = [imageName componentsSeparatedByString:@"_"];
    NSBundle *bundle = [NSBundle bundleForClass:className];
    UIImage *img = nil;
    NSString *bundleName = nil;
    if (imageNames.count > 0) {
        NSString *bundleName = imageNames.firstObject;
        NSBundle *subBundle = [NSBundle bundleWithURL:[bundle URLForResource:bundleName withExtension:@"bundle"]];
        if (subBundle) {
            img = [UIImage imageNamed:imageName inBundle:subBundle compatibleWithTraitCollection:nil];
        }
    }
    
    if (img == nil) {
        unsigned int scale = [[UIScreen mainScreen] scale];
        imageName = [imageName stringByAppendingFormat:@"@%dx",scale];
        img = [UIImage imageNamed:imageName inBundle:bundle compatibleWithTraitCollection:nil];
        if (img == nil) {
            NSBundle *subBundle = [NSBundle bundleWithURL:[bundle URLForResource:bundleName withExtension:@"bundle"]];
            if (subBundle) {
                img = [UIImage imageNamed:imageName inBundle:subBundle compatibleWithTraitCollection:nil];
            }
        }
    }
    self.image = img;
}

@end
