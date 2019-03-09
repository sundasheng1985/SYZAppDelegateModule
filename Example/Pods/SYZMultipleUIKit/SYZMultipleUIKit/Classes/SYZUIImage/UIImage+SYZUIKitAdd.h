//
//  UIImage+SYZUIKitAdd.h
//  SYZMultipleUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import <UIKit/UIKit.h>
#import <SYZUIBasekit/SYZUIBasekit.h>

@interface UIImage (SYZUIKitAdd)

- (UIImage *)syz_roundedImage;

/*
 颜色转成图片
 */
+ (UIImage *)syz_imageWithColor:(UIColor *)color size:(CGSize)size alpha:(float)alpha;

/*
 图片加模糊效果
 */
- (UIImage *)syz_blurEffectWithFactor:(CGFloat)factor;

+ (UIImage *)syz_imageWithSize:(CGSize)size color:(UIColor *)color;
+ (UIImage *)syz_imageWithSize:(CGSize)size cornerRadius:(CGFloat)cornerRadius color:(UIColor *)color;
+ (UIImage *)syz_overlayImage:(UIImage *)overlay onTopOfImage:(UIImage *)underlay;

+ (UIImage *)syz_imageFromAttributedString:(NSAttributedString *)str;

- (UIImage *)syz_maskWithImage:(UIImage *)maskImage;
- (UIImage *)syz_maskWithImage:(UIImage *)maskImage andUnderlayImage:(UIImage *)underlay;
- (UIImage *)syz_imageByRemovingColor:(UIColor *)color;
- (UIImage *)syz_imageByRemovingColorsWithMinColor:(UIColor *)minColor maxColor:(UIColor *)maxColor;
- (UIImage *)syz_imageByReplacingColor:(UIColor *)color withColor:(UIColor *)newColor;
- (UIImage *)syz_imageByReplacingColorsWithMinColor:(UIColor *)minColor maxColor:(UIColor *)maxColor withColor:(UIColor *)newColor;

- (UIImage*)syz_imageByScalingAndCroppingForSize:(CGSize)targetSize;

- (UIImage *)syz_resizedImage:(CGSize)newSize
         interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)syz_resizedImageWithContentMode:(UIViewContentMode)contentMode
                                      bounds:(CGSize)bounds
                        interpolationQuality:(CGInterpolationQuality)quality;


- (UIImage *)syz_applyLightEffect;
- (UIImage *)syz_applyExtraLightEffect;
- (UIImage *)syz_applyDarkEffect;
- (UIImage *)syz_applyTintEffectWithColor:(UIColor *)tintColor;

- (UIImage *)syz_applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;

- (UIImage *)syz_rotatedImage;

- (NSString *)syz_toMD5;

/** 将PNG图片压缩或拉伸至目标大小*/
- (UIImage*)syz_resizePNGToSize:(CGSize)targetSize;
@end
