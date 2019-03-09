//
//  UITableView+SYZUIKitAddUpdate.h
//  SYZMultipleUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import <UIKit/UIKit.h>
#if __has_include(<SNHUIKit/SNHUIKitTableView>)
#import <SYZMultipleUIKit/UITableView+SYZUIKitAddValidation.h>
#else
#import "UITableView+SYZUIKitAddValidation.h"
#endif


@interface UITableView (SYZUIKitAddUpdate)
/** 更新 */
- (BOOL)syz_deleteRow:(NSInteger)row atSection:(NSInteger)section;
- (BOOL)syz_deleteRowAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)syz_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

- (BOOL)syz_insertRow:(NSInteger)row atSection:(NSInteger)section;
- (BOOL)syz_insertRowAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)syz_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

- (BOOL)syz_reloadRow:(NSInteger)row atSection:(NSInteger)section;
- (BOOL)syz_reloadRowAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)syz_reloadRowsWithIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

- (BOOL)syz_moveRowAtIndexPath:(NSIndexPath *)atIndexPath toIndexPath:(NSIndexPath *)toIndexPath;

- (BOOL)syz_moveSection:(NSInteger)section toSection:(NSInteger)newSection;
- (BOOL)syz_deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation;
- (BOOL)syz_insertSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation;
- (BOOL)syz_reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation;

@end
