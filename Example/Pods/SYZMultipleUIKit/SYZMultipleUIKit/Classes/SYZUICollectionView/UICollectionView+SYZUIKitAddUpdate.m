//
//  UICollectionView+SYZUIKitAddUpdate.m
//  SYZMultipleUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import "UICollectionView+SYZUIKitAddUpdate.h"

@implementation UICollectionView (SYZUIKitAddUpdate)

- (BOOL)syz_reloadItem:(NSInteger)item atSection:(NSInteger)section {
    return [self syz_reloadItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:section]];
}
- (BOOL)syz_reloadItemAtIndexPath:(NSIndexPath *)indexPath {
    if (SYZIsNotEmpty(indexPath)) {
        [self syz_reloadItemsAtIndexPaths:@[indexPath]];
        return YES;
    } else {
        //抛出 exception
        return NO;
    }
}
- (BOOL)syz_reloadItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    if ([self syz_isValidIndexPaths:indexPaths]) {
        [self reloadItemsAtIndexPaths:indexPaths];
        return YES;
    } else {
        //抛出 exception
        return NO;
    }
}

- (BOOL)syz_deleteItem:(NSInteger)item atSection:(NSInteger)section {
    return [self syz_deleteItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:section]];
}
- (BOOL)syz_deleteItemAtIndexPath:(NSIndexPath *)indexPath {
    if (SYZIsNotEmpty(indexPath)) {
        [self syz_deleteItemsAtIndexPaths:@[indexPath]];
        return YES;
    } else {
        //抛出 exception
        return NO;
    }
}
- (BOOL)syz_deleteItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    if ([self syz_isValidIndexPaths:indexPaths]) {
        [self deleteItemsAtIndexPaths:indexPaths];
        return YES;
    } else {
        //抛出 exception
        return NO;
    }
}

- (BOOL)syz_deleteSection:(NSUInteger)section {
    return [self syz_deleteSections:[NSIndexSet indexSetWithIndex:section]];
}
- (BOOL)syz_deleteSections:(NSIndexSet *)sections {
    if ([self syz_isValidSections:sections]) {
        [self deleteSections:sections];
        return YES;
    } else {
        //抛出 exception
        return NO;
    }
}

- (BOOL)syz_insertItem:(NSInteger)item atSection:(NSInteger)section {
    return [self syz_insertItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:section]];
}
- (BOOL)syz_insertItemAtIndexPath:(NSIndexPath *)indexPath {
    if (SYZIsNotEmpty(indexPath)) {
        [self syz_insertItemsAtIndexPaths:@[indexPath]];
        return YES;
    } else {
        //抛出 exception
        return NO;
    }
}
- (BOOL)syz_insertItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    if ([self syz_isValidIndexPaths:indexPaths]) {
        [self insertItemsAtIndexPaths:indexPaths];
        return YES;
    } else {
        //抛出 exception
        return NO;
    }
}

- (BOOL)syz_moveSection:(NSInteger)section toSection:(NSInteger)newSection {
    if ([self syz_isValidSection:section] && [self syz_isValidSection:newSection]) {
        [self moveSection:section toSection:newSection];
        return YES;
    } else {
        //抛出 exception
        return NO;
    }
}

- (BOOL)syz_moveItemAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath {
    if ([self syz_isValidIndexPath:indexPath] && [self syz_isValidIndexPath:newIndexPath]) {
        [self syz_moveItemAtIndexPath:indexPath toIndexPath:newIndexPath];
        return YES;
    } else {
        //抛出 exception
        return NO;
    }
}


@end
