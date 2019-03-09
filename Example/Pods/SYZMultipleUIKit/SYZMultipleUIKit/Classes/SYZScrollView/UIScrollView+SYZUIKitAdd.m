//
//  UIScrollView+syzUIKitAdd.m
//  SYZUIBasekit
//
//  Created by LeeRay on 2018/12/1.
//

#import "UIScrollView+SYZUIKitAdd.h"

@implementation UIScrollView (SYZUIKitAdd)

- (CGSize)syz_availableBoundsSize {
    UIEdgeInsets inset = self.contentInset;
    CGFloat width = CGRectGetWidth(self.bounds) - inset.left - inset.right;
    CGFloat height = CGRectGetHeight(self.bounds) - inset.top - inset.bottom;
    return CGSizeMake(width, height);
}

- (void)syz_scrollToTopAnimated:(BOOL)animated {
    CGPoint offset = self.contentOffset;
    offset.y = -self.contentInset.top;
    [self setContentOffset:offset animated:animated];
}

- (void)syz_scrollToBottomAnimated:(BOOL)animated {
    CGFloat contentHeight = self.contentSize.height;
    CGFloat boundsHeight = self.bounds.size.height;
    UIEdgeInsets insets = self.contentInset;
    if (contentHeight <= [self syz_availableBoundsSize].height) {
        return;
    }
    
    CGPoint offset = self.contentOffset;
    offset.y = contentHeight - boundsHeight + insets.bottom;
    [self setContentOffset:offset animated:animated];
}

- (BOOL)syz_isReachingTheBottom {
    return CGRectGetHeight(self.bounds) + self.contentOffset.y - self.contentSize.height >= 0;
}

@end
