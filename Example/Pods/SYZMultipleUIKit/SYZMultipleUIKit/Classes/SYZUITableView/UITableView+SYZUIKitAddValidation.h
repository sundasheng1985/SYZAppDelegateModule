//
//  UITableView+SYZUIKitAddValidation.h
//  SYZMultipleUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import <UIKit/UIKit.h>
#import <SYZUIBasekit/SYZUIBasekit.h>

@interface UITableView (SYZUIKitAddValidation)

/**
 验证indexPath是否越界
 */
- (BOOL)syz_isValidIndexPath:(NSIndexPath *)indexPath;
/**
 验证indexPaths是否越界，只要有一个越界即返回NO
 */
- (BOOL)syz_isValidIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

/**
 校验 section 是否越界
 */
- (BOOL)syz_isValidSection:(NSInteger)section;
/**
 校验 sectios 是否越界，只要有一个越界，返回No ，否则YES
 */
- (BOOL)syz_isValidSections:(NSIndexSet *)sections;
/**
 校验row是否有效
 */
- (BOOL)syz_isValidRow:(NSInteger)row atSection:(NSInteger)section;
/**
 默认section为0
 */
- (BOOL)syz_isValidRowAtSection0:(NSInteger)row;

- (BOOL)syz_canInsertIndexPath:(NSIndexPath *)indexPath;
- (BOOL)syz_canInsertIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

- (BOOL)syz_canInsertSection:(NSInteger)section;
- (BOOL)syz_canInsertSections:(NSIndexSet *)indexSet;

@end
