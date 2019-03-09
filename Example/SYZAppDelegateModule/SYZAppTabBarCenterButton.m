//
//  SYZAppTabBarCenterButton.m
//  SYZAppDelegateModule_Example
//
//  Created by LeeRay on 2019/3/9.
//  Copyright © 2019年 sundasheng1985. All rights reserved.
//

#import "SYZAppTabBarCenterButton.h"
#import <SYZUIBasekit/SYZUIBasekit.h>
#import <SYZMultipleUIKit/SYZMultipleUIKit.h>

@implementation SYZAppTabBarCenterButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.adjustsImageWhenDisabled = NO;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat const imageWidth = self.bounds.size.width * 0.9;
    CGFloat const imageHeight = imageWidth;
    CGFloat const centerX = self.bounds.size.width * 0.5;
    
    CGFloat const titleLineHeight = self.titleLabel.font.lineHeight;
    CGFloat const verticalMargin = (self.bounds.size.height - titleLineHeight - imageHeight) * 0.5;
    
    CGFloat const centerOfImage = verticalMargin + imageHeight * 0.5;
    CGFloat const centerOfTitle = imageHeight + verticalMargin * 2 + titleLineHeight * 0.5 + 5;
    
    self.imageView.bounds = CGRectMake(0, 0, imageWidth, imageHeight);
    self.imageView.center = CGPointMake(centerX, centerOfImage);
    
    self.titleLabel.bounds = CGRectMake(0, 0, self.bounds.size.width, titleLineHeight);
    self.titleLabel.center = CGPointMake(centerX, centerOfTitle);
}

+ (id)plusButton {
    SYZAppTabBarCenterButton *button = [[SYZAppTabBarCenterButton alloc] init];
    [button setImage:[UIImage imageNamed:@"tabbar_create"] forState:UIControlStateNormal];
    [button addTarget:button action:@selector(onActionCenter) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    return button;
}

+ (CGFloat)multiplierOfTabBarHeight:(CGFloat)tabBarHeight {
    return 0.6;
}

+ (CGFloat)constantOfPlusButtonCenterYOffsetForTabBarHeight:(CGFloat)tabBarHeight {
    return (SYZSafeWindowInsets().bottom > 0) ? -20 : 0;
}

#pragma mark - 中间按钮点击事件 --
- (void)onActionCenter {
    NSLog(@"点了中间");
}

@end
