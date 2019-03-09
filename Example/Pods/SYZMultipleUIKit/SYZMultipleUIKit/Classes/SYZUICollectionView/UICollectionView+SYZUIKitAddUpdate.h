//
//  UICollectionView+SYZUIKitAddUpdate.h
//  SYZMultipleUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import <UIKit/UIKit.h>
#import <SYZMultipleUIKit/UICollectionView+SYZUIKitAddValidation.h>

@interface UICollectionView (SYZUIKitAddUpdate)

/** 更新 */
- (BOOL)syz_reloadItem:(NSInteger)item atSection:(NSInteger)section;
- (BOOL)syz_reloadItemAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)syz_reloadItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

- (BOOL)syz_deleteItem:(NSInteger)item atSection:(NSInteger)section;
- (BOOL)syz_deleteItemAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)syz_deleteItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

- (BOOL)syz_insertItem:(NSInteger)item atSection:(NSInteger)section;
- (BOOL)syz_insertItemAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)syz_insertItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

- (BOOL)syz_moveSection:(NSInteger)section toSection:(NSInteger)newSection;
- (BOOL)syz_moveItemAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath;
- (BOOL)syz_deleteSection:(NSUInteger)section;

@end
