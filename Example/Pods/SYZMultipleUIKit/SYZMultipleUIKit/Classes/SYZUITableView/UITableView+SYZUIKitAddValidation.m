//
//  UITableView+SYZUIKitAddValidation.m
//  SYZMultipleUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import "UITableView+SYZUIKitAddValidation.h"

@implementation UITableView (SYZUIKitAddValidation)

- (BOOL)syz_isValidIndexPath:(NSIndexPath *)indexPath {
    if (SYZIsNotEmpty(indexPath) && [indexPath isKindOfClass:[NSIndexPath class]]) {
        return [self syz_isValidRow:indexPath.row atSection:indexPath.section];
    }
    
    return NO;
}

/**
 验证indexPaths是否越界
 */
- (BOOL)syz_isValidIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    if (SYZIsEmptyArray(indexPaths)) {
        return NO;
    }
    
    BOOL isValidIndexpaths = YES;
    for (NSIndexPath * indexPath in indexPaths) {
        if ([self syz_isValidIndexPath:indexPath] == NO) {
            isValidIndexpaths = NO;
            break;
        }
    }
    
    return isValidIndexpaths;
}

/**
 校验 section 是否越界
 */
- (BOOL)syz_isValidSection:(NSInteger)section {
    return section >= 0 && section < [self numberOfSections];
}
/**
 校验 sectios 是否越界，只要有一个越界，返回No ，否则YES
 */
- (BOOL)syz_isValidSections:(NSIndexSet *)sections {
    if (sections.count <= 0) {
        return NO;
    }
    
    __block BOOL isValid = YES;
    [sections enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        if ([self syz_isValidSection:idx] == NO) {
            isValid = NO;
        }
    }];
    
    return isValid;
}

/**
 校验row是否有效
 */
- (BOOL)syz_isValidRow:(NSInteger)row atSection:(NSInteger)section {
    if ([self syz_isValidSection:section]) {
        //验证row
        NSUInteger sectionRows = [self numberOfRowsInSection:section];
        return row >= 0 && row < sectionRows;
    }
    return NO;
}

- (BOOL)syz_isValidRowAtSection0:(NSInteger)row {
    return [self syz_isValidRow:row atSection:0];
}

- (BOOL)syz_canInsertSection:(NSInteger)section {
    NSUInteger numberOfSections = 1;
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        numberOfSections = [self.dataSource numberOfSectionsInTableView:self];
    }
    return section >= 0 && section < numberOfSections;
}

- (BOOL)syz_canInsertSections:(NSIndexSet *)indexSet {
    if (indexSet.count <= 0) {
        return NO;
    }
    
    __block BOOL isValid = YES;
    [indexSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        if ([self syz_canInsertSection:idx]) {
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
        NSUInteger numberOfRows = [self.dataSource tableView:self numberOfRowsInSection:indexPath.section];
        return indexPath.row >= 0 && indexPath.row < numberOfRows;
    }
    
    return NO;
}
- (BOOL)syz_canInsertIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    if (SYZIsEmptyArray(indexPaths)) {
        return NO;
    }
    
    BOOL isValid = YES;
    for (NSIndexPath * indexPath in indexPaths) {
        if (NO == [self syz_canInsertIndexPath:indexPath]) {
            isValid = NO;
            break;
        }
    }
    
    return isValid;
}
@end
