//
//  UIImageView+SYZCornerRadius.m
//  SYZMultipleUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import "UIImageView+SYZCornerRadius.h"
#import <objc/runtime.h>

@interface UIImage (SYZCornerRadius)
@property (nonatomic , assign) BOOL isCornerRadius;

@end

@implementation UIImage (SYZCornerRadius)

- (BOOL)isCornerRadius {
    return [objc_getAssociatedObject(self, @selector(isCornerRadius)) boolValue];
}

- (void)setIsCornerRadius:(BOOL)isCornerRadius {
    objc_setAssociatedObject(self, @selector(isCornerRadius), @(isCornerRadius), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end

@interface SYZImageObserver : NSObject
@property (nonatomic, assign) UIImageView *originImageView;
@property (nonatomic, strong) UIImage *originImage;
@property (nonatomic, assign) CGFloat cornerRadius;

- (instancetype)initWithImageView:(UIImageView *)imageView;

@end

@implementation SYZImageObserver

- (void)dealloc {
    [self.originImageView removeObserver:self forKeyPath:@"image"];
    [self.originImageView removeObserver:self forKeyPath:@"contentMode"];
}

- (instancetype)initWithImageView:(UIImageView *)imageView {
    if (self = [super init]) {
        self.originImageView = imageView;
        [imageView addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
        [imageView addObserver:self forKeyPath:@"contentMode" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString*, id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"image"]) {
        UIImage *image = change[@"new"];
        if (![image isKindOfClass:[UIImage class]] || image.isCornerRadius) {
            return;
        }
        [self updateImageView];
    }
    
    if ([keyPath isEqualToString:@"contentMode"]) {
        self.originImageView.image = self.originImage;
    }
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    if (_cornerRadius == cornerRadius) {
        return;
    }
    
    _cornerRadius = cornerRadius;
    if (_cornerRadius > 0) {
        [self updateImageView];
    }
}

- (void)updateImageView {
    self.originImage = self.originImageView.image;
    if (!self.originImage) {
        return;
    }
    
    UIImage *image = nil;
    UIGraphicsBeginImageContextWithOptions(self.originImageView.bounds.size, NO, [UIScreen mainScreen].scale);
    CGContextRef currnetContext = UIGraphicsGetCurrentContext();
    if (currnetContext) {
        CGContextAddPath(currnetContext, [UIBezierPath bezierPathWithRoundedRect:self.originImageView.bounds cornerRadius:self.cornerRadius].CGPath);
        CGContextClip(currnetContext);
        [self.originImageView.layer renderInContext:currnetContext];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    if ([image isKindOfClass:[UIImage class]]) {
        image.isCornerRadius = YES;
        self.originImageView.image = image;
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateImageView];
        });
    }
}

@end

@implementation UIImageView (SYZCornerRadius)

- (CGFloat)syz_cornerRadius {
    return [self imageObserver].cornerRadius;
}

- (void)setSyz_cornerRadius:(CGFloat)snh_cornerRadius {
    [self imageObserver].cornerRadius = snh_cornerRadius;
}

- (SYZImageObserver *)imageObserver {
    SYZImageObserver *imageObserver = objc_getAssociatedObject(self, @selector(imageObserver));
    if (!imageObserver) {
        imageObserver = [[SYZImageObserver alloc]initWithImageView:self];
        objc_setAssociatedObject(self, @selector(imageObserver), imageObserver, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return imageObserver;
}

@end
