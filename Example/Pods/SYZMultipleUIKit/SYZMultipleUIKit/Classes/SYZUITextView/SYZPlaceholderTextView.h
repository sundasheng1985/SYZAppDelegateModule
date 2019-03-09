//
//  SYZPlaceholderTextView.h
//  SYZMultipleUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import <UIKit/UIKit.h>

@interface SYZPlaceholderTextView : UITextView
//二选一使用

/** 占位文字 */
@property (nonatomic,copy) NSString * placeholder;

/** 占位label */
@property (nonatomic,strong,readonly) UILabel * placeholderLabel;

@end
