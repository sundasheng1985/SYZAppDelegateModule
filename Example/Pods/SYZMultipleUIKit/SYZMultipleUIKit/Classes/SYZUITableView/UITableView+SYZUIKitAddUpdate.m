//
//  UITableView+SYZUIKitAddUpdate.m
//  SYZMultipleUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import "UITableView+SYZUIKitAddUpdate.h"

@implementation UITableView (SYZUIKitAddUpdate)

- (BOOL)syz_deleteRow:(NSInteger)row atSection:(NSInteger)section {
    return [self syz_deleteRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
}

- (BOOL)syz_deleteRowAtIndexPath:(NSIndexPath *)indexPath {
    if (SYZIsNotEmpty(indexPath)) {
        return [self syz_deleteRowsAtIndexPaths:@[indexPath]];
    } else {
        //抛出exception
        return NO;
    }
}

- (BOOL)syz_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    //验证 indexPaths
    if ([self syz_isValidIndexPaths:indexPaths]) {
        [self _beginEditorTableView];
        [self deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        [self _endEditorTableView];
        return YES;
    } else {
        //抛出exception
        return NO;
    }
}

- (BOOL)syz_insertRow:(NSInteger)row atSection:(NSInteger)section {
    return [self syz_insertRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
}
- (BOOL)syz_insertRowAtIndexPath:(NSIndexPath *)indexPath {
    if (SYZIsNotEmpty(indexPath)) {
        [self syz_insertRowsAtIndexPaths:@[indexPath]];
        return YES;
    } else {
        //抛出exception
        return NO;
    }
}

- (BOOL)syz_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    if ([self syz_canInsertIndexPaths:indexPaths]) {
        [self _beginEditorTableView];
        [self insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        [self _endEditorTableView];
        return YES;
    } else {
        //抛出exception
        return NO;
    }
}

- (BOOL)syz_reloadRow:(NSInteger)row atSection:(NSInteger)section {
    return [self syz_reloadRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
}

- (BOOL)syz_reloadRowAtIndexPath:(NSIndexPath *)indexPath {
    if (SYZIsNotEmpty(indexPath)) {
        [self syz_reloadRowsWithIndexPaths:@[indexPath]];
        return YES;
    } else {
        //抛出exception
        return NO;
    }
}

- (BOOL)syz_reloadRowsWithIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    if ([self syz_isValidIndexPaths:indexPaths]) {
        [self reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        return YES;
    } else {
        //抛出exception
        return NO;
    }
}

- (BOOL)syz_moveRowAtIndexPath:(NSIndexPath *)atIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    if ([self syz_isValidIndexPath:atIndexPath] && [self syz_isValidIndexPath:toIndexPath]) {
        [self _beginEditorTableView];
        [self moveRowAtIndexPath:atIndexPath toIndexPath:toIndexPath];
        [self _endEditorTableView];
        return YES;
    } else {
        //抛出exception
        return NO;
    }
}

- (BOOL)syz_moveSection:(NSInteger)section toSection:(NSInteger)newSection {
    if ([self syz_isValidSection:section] && [self syz_isValidSection:newSection]) {
        [self _beginEditorTableView];
        [self moveSection:section toSection:newSection];
        [self _endEditorTableView];
        return YES;
    } else {
        //抛出exception
        return NO;
    }
}

- (BOOL)syz_deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    if ([self syz_isValidSections:sections]) {
        [self _beginEditorTableView];
        [self deleteSections:sections withRowAnimation:animation];
        [self _endEditorTableView];
        return YES;
    } else {
        //抛出exception
        return NO;
    }
}

- (BOOL)syz_insertSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    if ([self syz_canInsertSections:sections]) {
        [self insertSections:sections withRowAnimation:animation];
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)syz_reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    if ([self syz_isValidSections:sections]) {
        [self reloadSections:sections withRowAnimation:animation];
        return YES;
    } else {
        return NO;
    }
}

- (void)_beginEditorTableView {
    [self beginUpdates];
}

- (void)_endEditorTableView {
    [self endUpdates];
}


@end
