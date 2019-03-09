//
//  SYZPlaceholderTextView.m
//  SYZMultipleUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import "SYZPlaceholderTextView.h"

@interface SYZPlaceholderTextView ()

@property (nonatomic,strong) UILabel * placeholderLabel;

@end

@implementation SYZPlaceholderTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initialize];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self _initialize];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_placeholderLabel sizeToFit];
    
    CGSize placeholderSize = [self.placeholder sizeWithAttributes:@{NSFontAttributeName:self.font}];
    CGRect placeholderFrame = CGRectMake(self.textContainerInset.left + 4, self.textContainerInset.top, placeholderSize.width, CGRectGetHeight(self.placeholderLabel.frame));
    _placeholderLabel.frame = placeholderFrame;
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    _placeholderLabel.font = font;
}

#pragma mark - Public Method
- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    
    if (_placeholderLabel == nil) {
        _placeholderLabel = [[UILabel alloc] init];
        _placeholderLabel.font = self.font;
        _placeholderLabel.textColor = [UIColor lightGrayColor];
        _placeholderLabel.backgroundColor = [UIColor orangeColor];
        [self addSubview:_placeholderLabel];
    }
    
    self.placeholderLabel.text = _placeholder;
    [self _updatePlaceholderLabel];
}

#pragma mark - Private Method
- (void)_initialize {
    self.selectedRange = NSMakeRange(0, 0); //光标归零
}

- (void)_updatePlaceholderLabel {
    self.placeholderLabel.alpha = !self.hasText;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (id<UITextViewDelegate>)delegate {
    [self _updatePlaceholderLabel];
    return [super delegate];
}

@end
