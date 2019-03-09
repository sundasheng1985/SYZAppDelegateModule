//
//  UICollectionView+SYZUIKitAddValidation.h
//  SYZMultipleUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import <UIKit/UIKit.h>
#import <SYZUIBasekit/SYZUIBasekit.h>

@interface UICollectionView (SYZUIKitAddValidation)

/**
 校验 section 是否越界
 */
- (BOOL)syz_isValidSection:(NSInteger)section;
/**
 校验一组 sections 是否越界
 */
- (BOOL)syz_isValidSections:(NSIndexSet *)sections;

/**
 校验 indexPath 是否越界
 */
- (BOOL)syz_isValidIndexPath:(NSIndexPath *)indexPath;

/**
 校验 一组 indexpath ，只要有一个越界，返回NO  否则 返回YES
 */
- (BOOL)syz_isValidIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

/**
 校验 item是否越界
 */
- (BOOL)syz_isValidItem:(NSInteger)item atSection:(NSInteger)section;
/**
 校验在 section = 0时，item是否越界
 */
- (BOOL)syz_isValidItemAtSection0:(NSInteger)item;

- (BOOL)syz_canInsertIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;
- (BOOL)syz_canInsertIndexPath:(NSIndexPath *)indexPath;
- (BOOL)syz_canInsertSections:(NSIndexSet *)sections;
- (BOOL)syz_canInsertSection:(NSInteger)section;

@end
