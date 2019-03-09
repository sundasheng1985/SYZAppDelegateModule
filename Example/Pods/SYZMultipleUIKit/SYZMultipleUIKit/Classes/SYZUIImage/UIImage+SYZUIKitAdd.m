//
//  UIImage+SYZUIKitAdd.m
//  SYZMultipleUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import "UIImage+SYZUIKitAdd.h"
#import <Accelerate/Accelerate.h>
#import <float.h>

typedef struct RGBAColor {
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat alpha;
} RGBAColor;

@implementation UIImage (SYZUIKitAdd)

- (UIImage *)syz_roundedImage {
    // begin context
    UIGraphicsBeginImageContext(self.size);
    // context ref
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // add a circle
    CGFloat min = fmin(self.size.width, self.size.height);
    CGRect rect = CGRectMake(0.5*(self.size.width-min), 0.5*(self.size.height-min), min, min);
    CGContextAddEllipseInRect(ctx, rect);
    // clip
    CGContextClip(ctx);
    // draw
    [self drawInRect:rect];
    // get circle image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // close context
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)syz_imageWithColor:(UIColor *)color size:(CGSize)size alpha:(float)alpha {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAlpha(context, alpha);
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (UIImage *)syz_blurEffectWithFactor:(CGFloat)factor {
    CIImage * ciImage = [[CIImage alloc]initWithImage:self];
    CIFilter* blurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [blurFilter setValue:ciImage forKey:kCIInputImageKey];
    [blurFilter setValue:@(factor) forKey:@"inputRadius"];
    CIImage* outImage = [blurFilter valueForKey:kCIOutputImageKey];
    CIContext * context = [CIContext contextWithOptions:nil];
    CGImageRef outCGImage = [context createCGImage:outImage fromRect:[outImage extent]];
    UIImage* blurImage = [UIImage imageWithCGImage:outCGImage];
    CGImageRelease(outCGImage);
    return blurImage;
}

+ (RGBAColor)syz_colorsFromColor:(UIColor *)color {
    size_t num = CGColorGetNumberOfComponents(color.CGColor);
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    RGBAColor colors;
    colors.red = components[0];
    colors.green = components[1];
    colors.blue = components[2];
    if (num > 3) {
        colors.alpha = components[3];
    } else {
        colors.alpha = 1.0f;
    }
    return colors;
}

+ (UIImage *)syz_imageWithSize:(CGSize)size color:(UIColor *)color {
    return [self syz_imageWithSize:size cornerRadius:0 color:color];
}

+ (UIImage *)syz_imageWithSize:(CGSize)size cornerRadius:(CGFloat)cornerRadius color:(UIColor *)color {
    UIGraphicsBeginImageContextWithOptions(size, YES, [UIScreen mainScreen].scale);
    [color setFill];
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    if (cornerRadius > 0) {
        [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius] addClip];
    }
    UIRectFill(rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [UIImage imageWithCGImage:image.CGImage scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
}

+ (UIImage *)syz_imageFromAttributedString:(NSAttributedString *)attributedString {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:13];
    label.textAlignment = NSTextAlignmentCenter;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    
    label.attributedText = attributedString;
    [label sizeToFit];
    UIGraphicsBeginImageContextWithOptions(label.bounds.size, NO, 0);
    [label.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)syz_maskWithImage:(UIImage *)maskImage {
    CGImageRef image = self.CGImage;
    CGImageRef cgMask = maskImage.CGImage;
    CGImageRef newImage = CGImageCreateWithMask(image, cgMask);
    UIImage *ret = [UIImage imageWithCGImage:newImage scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    CGImageRelease(newImage);
    return ret;
}

- (UIImage *)syz_maskWithImage:(UIImage *)maskImage andUnderlayImage:(UIImage *)underlay {
    UIImage *newImage = [self syz_maskWithImage:maskImage];
    return [UIImage syz_overlayImage:newImage onTopOfImage:underlay];
}

+ (UIImage *)syz_overlayImage:(UIImage *)overlay onTopOfImage:(UIImage *)underlay {
    CGImageRef imageRef = overlay.CGImage;
    CGImageRef underlayRef = underlay.CGImage;
    float width = CGImageGetWidth(imageRef);
    float height = CGImageGetHeight(imageRef);
    //    CGRect bounds = CGRectMake(0, 0, width, height);
    
    CGContextRef context = nil;
    
    context = CGBitmapContextCreate(NULL, width, height, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), CGImageGetColorSpace(imageRef), kCGImageAlphaPremultipliedLast);
    //    CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 0.0);
    //    CGContextFillRect(context, bounds);
    // now draw images
    CGRect r = CGRectMake(0, 0, CGImageGetWidth(underlayRef), CGImageGetHeight(underlayRef));
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGContextDrawImage(context, r, underlayRef);
    
    r = CGRectMake(0, 0, CGImageGetWidth(imageRef), CGImageGetHeight(imageRef));
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGContextDrawImage(context, r, imageRef);
    
    CGImageRef newImageRef = CGBitmapContextCreateImage(context);
    if (context) CGContextRelease(context);
    
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    CGImageRelease(newImageRef);
    return newImage;
}


- (UIImage *)syz_imageByRemovingColor:(UIColor *)color {
    return [self syz_imageByRemovingColorsWithMinColor:color maxColor:color];
}

- (UIImage *)syz_imageByRemovingColorsWithMinColor:(UIColor *)minColor maxColor:(UIColor *)maxColor {
    return [self syz_imageByReplacingColorsWithMinColor:minColor maxColor:maxColor withColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];
}

- (UIImage *)syz_imageByReplacingColor:(UIColor *)color withColor:(UIColor *)newColor {
    return [self syz_imageByReplacingColorsWithMinColor:color maxColor:color withColor:newColor];
}

- (UIImage *)syz_imageByReplacingColorsWithMinColor:(UIColor *)minColor maxColor:(UIColor *)maxColor withColor:(UIColor *)newColor {
    CGImageRef imageRef = self.CGImage;
    float width = CGImageGetWidth(imageRef);
    float height = CGImageGetHeight(imageRef);
    CGRect bounds = CGRectMake(0, 0, width, height);
    RGBAColor minColors = [UIImage syz_colorsFromColor:minColor];
    RGBAColor maxColors = [UIImage syz_colorsFromColor:maxColor];
    RGBAColor newColors = [UIImage syz_colorsFromColor:newColor];
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(imageRef);
    size_t numberOfComponents = CGColorSpaceGetNumberOfComponents(colorSpace);
    
    CGContextRef context = nil;
    
    context = CGBitmapContextCreate(NULL, width, height, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), CGImageGetColorSpace(imageRef), CGImageGetBitmapInfo(imageRef));
    CGContextSetRGBFillColor(context, newColors.red, newColors.green, newColors.blue, newColors.alpha);
    CGContextFillRect(context, bounds);
    CGImageRef maskedImageRef = NULL;
    if (numberOfComponents == 3) {
        CGFloat maskingColors[6] = {minColors.red, maxColors.red, minColors.green, maxColors.green, minColors.blue, maxColors.blue};
        maskedImageRef = CGImageCreateWithMaskingColors(imageRef, maskingColors);
    }
    else {
        CGFloat maskingColors[8] = {minColors.red, maxColors.red, minColors.green, maxColors.green, minColors.blue, maxColors.blue, minColors.alpha, maxColors.alpha};
        maskedImageRef = CGImageCreateWithMaskingColors(imageRef, maskingColors);
    }
    UIImage *newImage = nil;
    CGImageRef newImageRef = NULL;
    if (maskedImageRef != nil) {
        newImageRef = CGBitmapContextCreateImage(context);
        newImage = [UIImage imageWithCGImage:newImageRef];
    }
    if (context) CGContextRelease(context);
    if (maskedImageRef && newImageRef != maskedImageRef) CGImageRelease(maskedImageRef);
    if (newImageRef) {
        CGImageRelease(newImageRef);
    }
    return newImage;
}

- (UIImage*)syz_imageByScalingAndCroppingForSize:(CGSize)targetSize
{
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor) {
            scaleFactor = widthFactor; // scale to fit height
        } else {
            scaleFactor = heightFactor; // scale to fit width
        }
        
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else {
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
        }
    }
    
    UIGraphicsBeginImageContextWithOptions(targetSize, YES, 0.0); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil)
    {
        
    }
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    
    return newImage;
}


- (UIImage *)syz_applyLightEffect {
    UIColor *tintColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    return [self syz_applyBlurWithRadius:30 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}

- (UIImage *)syz_applyExtraLightEffect {
    UIColor *tintColor = [UIColor colorWithWhite:0.97 alpha:0.82];
    return [self syz_applyBlurWithRadius:20 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}

- (UIImage *)syz_applyDarkEffect {
    UIColor *tintColor = [UIColor colorWithWhite:0.11 alpha:0.73];
    return [self syz_applyBlurWithRadius:20 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}

- (UIImage *)syz_applyTintEffectWithColor:(UIColor *)tintColor {
    const CGFloat EffectColorAlpha = 0.6;
    UIColor *effectColor = tintColor;
    size_t componentCount = CGColorGetNumberOfComponents(tintColor.CGColor);
    if (componentCount == 2) {
        CGFloat b;
        if ([tintColor getWhite:&b alpha:NULL]) {
            effectColor = [UIColor colorWithWhite:b alpha:EffectColorAlpha];
        }
    }
    else {
        CGFloat r, g, b;
        if ([tintColor getRed:&r green:&g blue:&b alpha:NULL]) {
            effectColor = [UIColor colorWithRed:r green:g blue:b alpha:EffectColorAlpha];
        }
    }
    return [self syz_applyBlurWithRadius:10 tintColor:effectColor saturationDeltaFactor:-1.0 maskImage:nil];
}


- (UIImage *)syz_applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage {
    // Check pre-conditions.
    if (self.size.width < 1 || self.size.height < 1) {
        NSLog (@"*** error: invalid size: (%.2f x %.2f). Both dimensions must be >= 1: %@", self.size.width, self.size.height, self);
        return nil;
    }
    if (!self.CGImage) {
        NSLog (@"*** error: image must be backed by a CGImage: %@", self);
        return nil;
    }
    if (maskImage && !maskImage.CGImage) {
        NSLog (@"*** error: maskImage must be backed by a CGImage: %@", maskImage);
        return nil;
    }
    
    CGRect imageRect = { CGPointZero, self.size };
    UIImage *effectImage = self;
    
    BOOL hasBlur = blurRadius > __FLT_EPSILON__;
    BOOL hasSaturationChange = fabs(saturationDeltaFactor - 1.) > __FLT_EPSILON__;
    if (hasBlur || hasSaturationChange) {
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectInContext = UIGraphicsGetCurrentContext();
        CGContextScaleCTM(effectInContext, 1.0, -1.0);
        CGContextTranslateCTM(effectInContext, 0, -self.size.height);
        CGContextDrawImage(effectInContext, imageRect, self.CGImage);
        
        vImage_Buffer effectInBuffer;
        effectInBuffer.data     = CGBitmapContextGetData(effectInContext);
        effectInBuffer.width    = CGBitmapContextGetWidth(effectInContext);
        effectInBuffer.height   = CGBitmapContextGetHeight(effectInContext);
        effectInBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectInContext);
        
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectOutContext = UIGraphicsGetCurrentContext();
        vImage_Buffer effectOutBuffer;
        effectOutBuffer.data     = CGBitmapContextGetData(effectOutContext);
        effectOutBuffer.width    = CGBitmapContextGetWidth(effectOutContext);
        effectOutBuffer.height   = CGBitmapContextGetHeight(effectOutContext);
        effectOutBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectOutContext);
        
        if (hasBlur) {
            // A description of how to compute the box kernel width from the Gaussian
            // radius (aka standard deviation) appears in the SVG spec:
            // http://www.w3.org/TR/SVG/filters.html#feGaussianBlurElement
            //
            // For larger values of 's' (s >= 2.0), an approximation can be used: Three
            // successive box-blurs build a piece-wise quadratic convolution kernel, which
            // approximates the Gaussian kernel to within roughly 3%.
            //
            // let d = floor(s * 3*sqrt(2*pi)/4 + 0.5)
            //
            // ... if d is odd, use three box-blurs of size 'd', centered on the output pixel.
            //
            CGFloat inputRadius = blurRadius * [[UIScreen mainScreen] scale];
            uint32_t radius = floor(inputRadius * 3. * sqrt(2 * M_PI) / 4 + 0.5);
            if (radius % 2 != 1) {
                radius += 1; // force radius to be odd so that the three box-blur methodology works.
            }
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectInBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
        }
        BOOL effectImageBuffersAreSwapped = NO;
        if (hasSaturationChange) {
            CGFloat s = saturationDeltaFactor;
            CGFloat floatingPointSaturationMatrix[] = {
                0.0722 + 0.9278 * s,  0.0722 - 0.0722 * s,  0.0722 - 0.0722 * s,  0,
                0.7152 - 0.7152 * s,  0.7152 + 0.2848 * s,  0.7152 - 0.7152 * s,  0,
                0.2126 - 0.2126 * s,  0.2126 - 0.2126 * s,  0.2126 + 0.7873 * s,  0,
                0,                    0,                    0,  1,
            };
            const int32_t divisor = 256;
            NSUInteger matrixSize = sizeof(floatingPointSaturationMatrix)/sizeof(floatingPointSaturationMatrix[0]);
            int16_t saturationMatrix[matrixSize];
            for (NSUInteger i = 0; i < matrixSize; ++i) {
                saturationMatrix[i] = (int16_t)roundf(floatingPointSaturationMatrix[i] * divisor);
            }
            if (hasBlur) {
                vImageMatrixMultiply_ARGB8888(&effectOutBuffer, &effectInBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
                effectImageBuffersAreSwapped = YES;
            }
            else {
                vImageMatrixMultiply_ARGB8888(&effectInBuffer, &effectOutBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
            }
        }
        if (!effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        if (effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    // Set up output context.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef outputContext = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(outputContext, 1.0, -1.0);
    CGContextTranslateCTM(outputContext, 0, -self.size.height);
    
    // Draw base image.
    CGContextDrawImage(outputContext, imageRect, self.CGImage);
    
    // Draw effect image.
    if (hasBlur) {
        CGContextSaveGState(outputContext);
        if (maskImage) {
            CGContextClipToMask(outputContext, imageRect, maskImage.CGImage);
        }
        CGContextDrawImage(outputContext, imageRect, effectImage.CGImage);
        CGContextRestoreGState(outputContext);
    }
    
    // Add in color tint.
    if (tintColor) {
        CGContextSaveGState(outputContext);
        CGContextSetFillColorWithColor(outputContext, tintColor.CGColor);
        CGContextFillRect(outputContext, imageRect);
        CGContextRestoreGState(outputContext);
    }
    
    // Output image is ready.
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outputImage;
}

- (UIImage *)syz_rotatedImage {
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef context = CGBitmapContextCreate(NULL, self.size.width * self.scale, self.size.height * self.scale,
                                                 CGImageGetBitsPerComponent(self.CGImage), 0,
                                                 CGImageGetColorSpace(self.CGImage),
                                                 CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(context, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(context, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(context, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(context);
    UIImage *img = [UIImage imageWithCGImage:cgimg scale:self.scale orientation:UIImageOrientationUp];
    CGContextRelease(context);
    CGImageRelease(cgimg);
    return img;
}

// Returns a copy of this image that is cropped to the given bounds.
// The bounds will be adjusted using CGRectIntegral.
// This method ignores the image's imageOrientation setting.
- (UIImage *)syz_croppedImage:(CGRect)bounds {
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], bounds);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return croppedImage;
}

// Returns a rescaled copy of the image, taking into account its orientation
// The image will be scaled disproportionately if necessary to fit the bounds specified by the parameter
- (UIImage *)syz_resizedImage:(CGSize)newSize interpolationQuality:(CGInterpolationQuality)quality {
    BOOL drawTransposed = NO;
    
    //    switch (self.imageOrientation) {
    //        case UIImageOrientationLeft:
    //        case UIImageOrientationLeftMirrored:
    //        case UIImageOrientationRight:
    //        case UIImageOrientationRightMirrored:
    //            drawTransposed = YES;
    //            break;
    //
    //        default:
    //            drawTransposed = NO;
    //    }
    
    return [self syz_resizedImage:newSize
                        transform:[self syz_transformForOrientation:newSize]
                   drawTransposed:drawTransposed
             interpolationQuality:quality];
}

// Resizes the image according to the given content mode, taking into account the image's orientation
- (UIImage *)syz_resizedImageWithContentMode:(UIViewContentMode)contentMode
                                      bounds:(CGSize)bounds
                        interpolationQuality:(CGInterpolationQuality)quality {
    CGFloat horizontalRatio = bounds.width / self.size.width;
    CGFloat verticalRatio = bounds.height / self.size.height;
    CGFloat ratio;
    
    switch (contentMode) {
        case UIViewContentModeScaleAspectFill:
            ratio = MAX(horizontalRatio, verticalRatio);
            break;
            
        case UIViewContentModeScaleAspectFit:
            ratio = MIN(horizontalRatio, verticalRatio);
            break;
            
        default:
            [NSException raise:NSInvalidArgumentException format:@"Unsupported content mode: %ld", (long)contentMode];
    }
    
    CGSize newSize = CGSizeMake(self.size.width * ratio, self.size.height * ratio);
    
    return [self syz_resizedImage:newSize interpolationQuality:quality];
}

#pragma mark -
#pragma mark Private helper methods

// Returns a copy of the image that has been transformed using the given affine transform and scaled to the new size
// The new image's orientation will be UIImageOrientationUp, regardless of the current image's orientation
// If the new size is not integral, it will be rounded up
- (UIImage *)syz_resizedImage:(CGSize)newSize
                    transform:(CGAffineTransform)transform
               drawTransposed:(BOOL)transpose
         interpolationQuality:(CGInterpolationQuality)quality {
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height));
    CGRect transposedRect = CGRectMake(0, 0, newRect.size.height, newRect.size.width);
    CGImageRef imageRef = self.CGImage;
    
    // Build a context that's the same dimensions as the new size
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                newRect.size.width,
                                                newRect.size.height,
                                                CGImageGetBitsPerComponent(imageRef),
                                                0,
                                                CGImageGetColorSpace(imageRef),
                                                CGImageGetBitmapInfo(imageRef));
    
    // Rotate and/or flip the image if required by its orientation
    CGContextConcatCTM(bitmap, transform);
    
    // Set the quality level to use when rescaling
    CGContextSetInterpolationQuality(bitmap, quality);
    
    // Draw into the context; this scales the image
    CGContextDrawImage(bitmap, transpose ? transposedRect : newRect, imageRef);
    
    // Get the resized image from the context and a UIImage
    CGImageRef newImageRef = CGBitmapContextCreateImage(bitmap);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    // Clean up
    CGContextRelease(bitmap);
    CGImageRelease(newImageRef);
    
    return newImage;
}

// Returns an affine transform that takes into account the image orientation when drawing a scaled image
- (CGAffineTransform)syz_transformForOrientation:(CGSize)newSize {
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:           // EXIF = 3
        case UIImageOrientationDownMirrored:   // EXIF = 4
            transform = CGAffineTransformTranslate(transform, newSize.width, newSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:           // EXIF = 6
        case UIImageOrientationLeftMirrored:   // EXIF = 5
            transform = CGAffineTransformTranslate(transform, newSize.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:          // EXIF = 8
        case UIImageOrientationRightMirrored:  // EXIF = 7
            transform = CGAffineTransformTranslate(transform, 0, newSize.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:     // EXIF = 2
        case UIImageOrientationDownMirrored:   // EXIF = 4
            transform = CGAffineTransformTranslate(transform, newSize.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:   // EXIF = 5
        case UIImageOrientationRightMirrored:  // EXIF = 7
            transform = CGAffineTransformTranslate(transform, newSize.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    return transform;
}

- (NSString *)syz_toMD5 {
    UIImage * tempImage = self;
    NSData * imageData = UIImagePNGRepresentation(tempImage);
    NSString * imageDataString = [imageData description];
    return [imageDataString syz_32md5];
}

/** 将PNG图片压缩或拉伸至目标大小*/
- (UIImage*)syz_resizePNGToSize:(CGSize)targetSize {
    if (targetSize.width <= 0 || targetSize.height <= 0) return nil;
    CGFloat width = targetSize.width;
    CGFloat height = targetSize.height;
    void* data = malloc(width * height * 4);
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(data, width, height, 8, 4 * width, colorSpaceRef, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), self.CGImage);
    CGImageRef imgRef = CGBitmapContextCreateImage(context);
    UIImage* retImage = [UIImage imageWithCGImage:imgRef];
    if (colorSpaceRef) CGColorSpaceRelease(colorSpaceRef);
    if (context) CGContextRelease(context);
    if (imgRef) CGImageRelease(imgRef);
    return retImage;
}

@end
