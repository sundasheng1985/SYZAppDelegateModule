//
//  UIButton+SYZButton.m
//  SYZMultipleUIKit
//
//  Created by LeeRay on 2018/12/22.
//

#import "UIButton+SYZButton.h"

@implementation UIButton (SYZButton)

+ (UIButton *)syz_buttonForEvents:(UIControlEvents)events WithHandler:(SYZResponderActionHandler)handler {
    SYZResponserBlockTarget * target = [[SYZResponserBlockTarget alloc] initWithBlock:handler];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:target action:@selector(target_invoked:) forControlEvents:events];
    [button saveTarget:target forEvents:events];
    return button;
}

- (void)syz_startCountDownWithSecond:(NSInteger)leftSecond{
    
    __block NSInteger time = leftSecond; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [self setTitle:@"重试" forState:UIControlStateNormal];
                self.titleLabel.font = [UIFont systemFontOfSize:16.0];
                [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [self setTitle:[NSString stringWithFormat:@"%.2d", seconds] forState:UIControlStateNormal];
                self.titleLabel.font = [UIFont systemFontOfSize:16.0];
                [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}


@end
