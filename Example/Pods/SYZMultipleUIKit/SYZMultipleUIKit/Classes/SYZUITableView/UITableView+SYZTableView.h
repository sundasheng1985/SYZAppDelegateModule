//
//  UITableView+SYZTableView.h
//  SYZMultipleUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import <UIKit/UIKit.h>

@interface UITableView (SYZTableView)

/** 注册cell */
- (void)syz_registerCellClass:(Class)cellClass;

- (void)syz_registerNibWithClass:(Class)nibClass;

- (void)syz_registerNibWithClass:(Class)nibClass bundle:( NSBundle * _Nullable )bundle;

- (__kindof UITableViewCell *)syz_dequeueCellWithClass:(Class)cellClass;
@end
