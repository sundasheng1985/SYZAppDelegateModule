//
//  SYZAppUINavigationViewController.m
//  SYZAppDelegateModule_Example
//
//  Created by LeeRay on 2019/3/9.
//  Copyright © 2019年 sundasheng1985. All rights reserved.
//

#import "SYZAppUINavigationViewController.h"

@interface SYZAppUINavigationViewController ()
@property (nonatomic, strong) UIBarButtonItem *returnItem;
@end

@implementation SYZAppUINavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = self.returnItem;
    }
    [super pushViewController:viewController animated:animated];
}
#pragma mark - Action
- (void)onActionReturn {
    [self popViewControllerAnimated:YES];
}

#pragma mark - Lazy
- (UIBarButtonItem *)returnItem {
    if (!_returnItem) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"nva_return"] forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 30, 30);
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        [button addTarget:self action:@selector(onActionReturn) forControlEvents:UIControlEventTouchUpInside];
        _returnItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    return _returnItem;
}


@end
