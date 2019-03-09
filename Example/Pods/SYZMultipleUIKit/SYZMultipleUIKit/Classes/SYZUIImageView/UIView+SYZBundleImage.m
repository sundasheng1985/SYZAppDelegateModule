//
//  UIView+SYZBundleImage.m
//  SYZMultipleUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import "UIView+SYZBundleImage.h"
#import "UIImageView+SYZBundleImage.h"

@implementation UIView (SYZBundleImage)

- (void)syz_loadImageNamed:(NSString *)imageNamed toImageView:(UIImageView *)imgView {
    [imgView syz_imageNamed:imageNamed fromClassBundle:[self class]];
}

@end
