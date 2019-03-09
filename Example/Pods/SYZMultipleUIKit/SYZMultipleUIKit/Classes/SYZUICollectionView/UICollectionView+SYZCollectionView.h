//
//  UICollectionView+SYZCollectionView.h
//  SYZMultipleUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import <UIKit/UIKit.h>
#import <SYZUIBasekit/SYZUIBasekit.h>

@interface UICollectionView (SYZCollectionView)

/**
 注册Cell
 */
- (void)syz_registerCellClass:(nullable Class)cellClass;
- (void)syz_registerNibClass:(Class)nibClass; //从默认bundle中取
- (void)syz_registerNibClass:(Class)nibClass bundle:(nullable NSBundle *)bundle;

/**
 注册HeaderView
 */
- (void)syz_registerSupplementaryHeaderViewClass:(nullable Class)viewClass;
- (void)syz_registerHeaderViewWithNibClass:(nullable Class)nibClass; //从默认bundle中取
- (void)syz_registerHeaderViewWithNibClass:(nullable Class)nibClass bundle:(nullable NSBundle *)bundle;

/**
 注册FooterView
 */
- (void)syz_registerSupplementaryFooterViewClass:(nullable Class)viewClass;
- (void)syz_registerFooterViewWithNibClass:(nullable Class)nibClass;
- (void)syz_registerFooterViewWithNibClass:(nullable Class)nibClass bundle:(nullable NSBundle *)bundle;

/**
 获取FooterView
 */
- (__kindof UICollectionReusableView *)syz_dequeueReusableSupplementaryFooterViewClass:(nullable Class)viewClass forIndexPath:(NSIndexPath *)indexPath;

/**
 获取HeaderView
 */
- (__kindof UICollectionReusableView *)syz_dequeueReusableSupplementaryHeaderViewClass:(nullable Class)viewClass forIndexPath:(NSIndexPath *)indexPath;

/**
 获取Cell
 */
- (__kindof UICollectionViewCell *)syz_dequeueReusableCellWithReuseIdentifier:(nullable Class)cellClass forIndexPath:(NSIndexPath *)indexPath;

@end

@interface NSString (SYZCollectionViewAdditions)

/**
 是否是Header类型
 */
- (BOOL)syz_isKindSectionHeader;

/**
 是否是Footer类型
 */
- (BOOL)syz_isKindSectionFooter;


@end
