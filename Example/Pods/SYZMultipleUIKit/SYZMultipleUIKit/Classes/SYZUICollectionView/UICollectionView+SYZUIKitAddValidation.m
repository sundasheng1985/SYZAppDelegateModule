//
//  UICollectionView+SYZUIKitAddValidation.m
//  SYZMultipleUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import "UICollectionView+SYZUIKitAddValidation.h"

@implementation UICollectionView (SYZUIKitAddValidation)

- (BOOL)syz_isValidSection:(NSInteger)section {
    NSUInteger numberOfSections = [self numberOfSections];
    return section >= 0 && section < numberOfSections;
}

- (BOOL)syz_isValidSections:(NSIndexSet *)sections {
    if (sections.count <= 0) {
        return NO;
    }
    __block BOOL isValid = YES;
    [sections enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        if (NO == [self syz_isValidSection:idx]) {
            isValid = NO;
            *stop = YES;
        }
    }];
    return isValid;
}

- (BOOL)syz_isValidIndexPath:(NSIndexPath *)indexPath {
    if (SYZIsNotEmpty(indexPath) && [indexPath isKindOfClass:[NSIndexPath class]]) {
        return [self syz_isValidItem:indexPath.item atSection:indexPath.section];
    }
    return NO;
}

- (BOOL)syz_isValidIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    if (SYZIsNotEmptyArray(indexPaths)) {
        BOOL isValid = YES;
        for (NSIndexPath * indexPath in indexPaths) {
            if (NO == [self syz_isValidIndexPath:indexPath]) {
                isValid = NO;
                break;
            }
        }
        
        return isValid;
    }
    
    return NO;
}

/**
 校验 item是否越界
 */
- (BOOL)syz_isValidItem:(NSInteger)item atSection:(NSInteger)section {
    if ([self syz_isValidSection:section]) {
        NSUInteger itemsNumber = [self numberOfItemsInSection:section];
        return item >= 0 && item < itemsNumber;
    }
    
    return NO;
}
/**
 校验在 section = 0时，item是否越界
 */
- (BOOL)syz_isValidItemAtSection0:(NSInteger)item {
    return [self syz_isValidItem:item atSection:0];
}

- (BOOL)syz_canInsertSection:(NSInteger)section {
    NSUInteger numberOfSections = 1;
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInCollectionView:)]) {
        numberOfSections = [self.dataSource numberOfSectionsInCollectionView:self];
    }
    return section >= 0 && section < numberOfSections;
}

- (BOOL)syz_canInsertSections:(NSIndexSet *)sections {
    if (sections.count <= 0) {
        return NO;
    }
    
    __block BOOL isValid = YES;
    [sections enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        if (NO == [self syz_canInsertSection:idx]) {
            isValid = NO;
            *stop = YES;
        }
    }];
    return isValid;
}

- (BOOL)syz_canInsertIndexPath:(NSIndexPath *)indexPath {
    if (SYZIsEmpty(indexPath)) {
        return NO;
    }
    
    if ([self syz_canInsertSection:indexPath.section]) {
        NSUInteger itemsNumber = [self.dataSource collectionView:self numberOfItemsInSection:indexPath.section];
        return indexPath.item >= 0 && indexPath.item < itemsNumber;
    }
    
    return NO;
}

- (BOOL)syz_canInsertIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    if (SYZIsEmptyArray(indexPaths)) {
        return NO;
    }
    BOOL isValid = YES;
    for (NSIndexPath * indexPath in indexPaths) {
        if ([self syz_canInsertIndexPath:indexPath] == NO) {
            isValid = NO;
            break;
        }
    }
    
    return isValid;
}


@end
