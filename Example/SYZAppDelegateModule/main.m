//
//  main.m
//  SYZAppDelegateModule
//
//  Created by sundasheng1985 on 03/09/2019.
//  Copyright (c) 2019 sundasheng1985. All rights reserved.
//

@import UIKit;
//#import "SYZAppDelegate.h"
#import <SYZAppDelegateModule/SYZOriginAppDelegate.h>

int main(int argc, char * argv[])
{
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([SYZOriginAppDelegate class]));
    }
}
