//
//  UICollectionView+SYZCollectionView.m
//  SYZMultipleUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import "UICollectionView+SYZCollectionView.h"

@implementation UICollectionView (SYZCollectionView)

- (void)syz_registerCellClass:(nullable Class)cellClass {
    [self registerClass:cellClass forCellWithReuseIdentifier:NSStringFromClass(cellClass)];
}

- (void)syz_registerNibClass:(Class)nibClass {
    [self syz_registerNibClass:nibClass bundle:nil];
}

- (void)syz_registerNibClass:(Class)nibClass bundle:(NSBundle *)bundle {
    NSString * cellName = NSStringFromClass(nibClass);
    UINib * nib = [UINib nibWithNibName:cellName bundle:bundle];
    [self registerNib:nib forCellWithReuseIdentifier:cellName];
}

- (void)syz_registerSupplementaryHeaderViewClass:(nullable Class)viewClass {
    [self registerClass:viewClass forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(viewClass)];
}

- (void)syz_registerHeaderViewWithNibClass:(nullable Class)nibClass {
    [self syz_registerHeaderViewWithNibClass:nibClass bundle:nil];
}

- (void)syz_registerHeaderViewWithNibClass:(nullable Class)nibClass bundle:(NSBundle *)bundle {
    NSString * viewName = NSStringFromClass(nibClass);
    UINib * nib = [UINib nibWithNibName:viewName bundle:bundle];
    [self registerNib:nib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:viewName];
}

- (void)syz_registerSupplementaryFooterViewClass:(nullable Class)viewClass {
    [self registerClass:viewClass forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass(viewClass)];
}

- (void)syz_registerFooterViewWithNibClass:(nullable Class)nibClass {
    [self syz_registerFooterViewWithNibClass:nibClass bundle:nil];
}

- (void)syz_registerFooterViewWithNibClass:(nullable Class)nibClass bundle:(NSBundle *)bundle {
    NSString * viewName = NSStringFromClass(nibClass);
    UINib * nib = [UINib nibWithNibName:viewName bundle:bundle];
    [self registerNib:nib forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:viewName];
}

- (__kindof UICollectionViewCell *)syz_dequeueReusableCellWithReuseIdentifier:(nullable Class)cellClass forIndexPath:(NSIndexPath *)indexPath {
    return [self dequeueReusableCellWithReuseIdentifier:NSStringFromClass(cellClass) forIndexPath:indexPath];
}

- (__kindof UICollectionReusableView *)syz_dequeueReusableSupplementaryHeaderViewClass:(nullable Class)viewClass forIndexPath:(NSIndexPath *)indexPath {
    return [self dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                    withReuseIdentifier:NSStringFromClass(viewClass)
                                           forIndexPath:indexPath];
}

- (__kindof UICollectionReusableView *)syz_dequeueReusableSupplementaryFooterViewClass:(nullable Class)viewClass forIndexPath:(NSIndexPath *)indexPath {
    return [self dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                    withReuseIdentifier:NSStringFromClass(viewClass)
                                           forIndexPath:indexPath];
}

@end

@implementation NSString (SYZCollectionViewAdditions)

- (BOOL)syz_isKindSectionHeader {
    return [self isEqualToString:UICollectionElementKindSectionHeader];
}

- (BOOL)syz_isKindSectionFooter {
    return [self isEqualToString:UICollectionElementKindSectionFooter];
}

@end
