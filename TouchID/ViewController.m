//
//  ViewController.m
//  TouchID
//
//  Created by 冷求慧 on 17/1/21.
//  Copyright © 2017年 冷求慧. All rights reserved.
//

#import "ViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>   // 导入本地认证的头文件
@interface ViewController ()
@end
@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
}
#pragma mark 指纹验证
- (IBAction)checkAction:(UIButton *)sender {
    LAContext *context=[[LAContext alloc]init];
    NSError *err=nil;
    NSString *requestMess=@"需要您的指纹认证";   // 提示信息
    if([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&err]){   // 判断指纹是否有用  支持指纹的设备
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:requestMess reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                NSLog(@"指纹验证成功,进行其他页面的跳转");
            }
            else{
                switch (error.code) {
                    case kLAErrorAuthenticationFailed:
                        NSLog(@"授权失败");
                        break;
                    case kLAErrorUserCancel:
                        NSLog(@"用户取消授权");
                        break;
                    case kLAErrorUserFallback:
                        NSLog(@"用户取消授权");
                        break;
                    case kLAErrorSystemCancel:
                        NSLog(@"切换到其他APP,系统取消验证Touch ID");
                        break;
                    default:
                        break;
                }
            }
        }];
    }
    else{
        NSLog(@"尚未开启指纹!!!");
    }
}

@end
