//
//  UIScrollView+syzUIKitAdd.h
//  SYZUIBasekit
//
//  Created by LeeRay on 2018/12/1.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (SYZUIKitAdd)

/** 大小 */
- (CGSize)syz_availableBoundsSize;

/** 滚动到顶部 */
- (void)syz_scrollToTopAnimated:(BOOL)animated;

/** 滚动到底部 */
- (void)syz_scrollToBottomAnimated:(BOOL)animated;

/** 是否在底部 */
- (BOOL)syz_isReachingTheBottom;
@end
