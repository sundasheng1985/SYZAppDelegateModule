//
//  UIView+SYZLayoutAddition.h
//  SYZMultipleUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import <UIKit/UIKit.h>

/**
 全屏frame
 */
extern CGRect const syz_fullScreenFrame(void);

//全屏 宽度
extern CGFloat const syz_screenWidth(void);
//全屏 高度
extern CGFloat const syz_screenHeight(void);

@interface UIView (SYZLayoutAddition)

@property (nonatomic, assign) CGFloat syz_x;
@property (nonatomic, assign) CGFloat syz_maxX;
@property (nonatomic, assign) CGFloat syz_centerX;

@property (nonatomic, assign) CGFloat syz_y;
@property (nonatomic, assign) CGFloat syz_maxY;
@property (nonatomic, assign) CGFloat syz_centerY;

@property (nonatomic, assign) CGFloat syz_height;
@property (nonatomic, assign) CGFloat syz_width;
@property (nonatomic, assign) CGSize syz_size;

@property (nonatomic, assign) CGPoint syz_origin;
@property (nonatomic, assign) CGFloat syz_top;
@property (nonatomic, assign) CGFloat syz_left;
@property (nonatomic, assign) CGFloat syz_bottom;
@property (nonatomic, assign) CGFloat syz_right;

@end
