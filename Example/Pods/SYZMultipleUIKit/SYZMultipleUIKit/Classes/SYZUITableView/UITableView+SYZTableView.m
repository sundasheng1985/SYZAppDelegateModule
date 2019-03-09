//
//  UITableView+SYZTableView.m
//  SYZMultipleUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import "UITableView+SYZTableView.h"

@implementation UITableView (SYZTableView)

- (void)syz_registerCellClass:(Class)cellClass {
    [self registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
}

- (void)syz_registerNibWithClass:(Class)nibClass {
    [self syz_registerNibWithClass:nibClass bundle:nil];
}

- (void)syz_registerNibWithClass:(Class)nibClass bundle:(NSBundle *)bundle {
    NSString * cellName = NSStringFromClass(nibClass);
    UINib * cellNib = [UINib nibWithNibName:cellName bundle:bundle];
    [self registerNib:cellNib forCellReuseIdentifier:cellName];
}

- (UITableViewCell *)syz_dequeueCellWithClass:(Class)cellClass {
    return [self dequeueReusableCellWithIdentifier:NSStringFromClass(cellClass)];
}


@end
