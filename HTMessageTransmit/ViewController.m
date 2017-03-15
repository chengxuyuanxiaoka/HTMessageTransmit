//
//  ViewController.m
//  HTMessageTransmit
//
//  Created by 一米阳光 on 17/3/14.
//  Copyright © 年 一米阳光. All rights reserved.
//

#import "ViewController.h"
#import "HTResolveMethod.h"
#import "HTResolveSonMethod.h"

@interface ViewController ()<
ResolveMethodCrashDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor purpleColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(30, 100, CGRectGetWidth(self.view.bounds)-60, 30);
    [button setTitle:@"准备崩溃" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonClick:(id)sender {
    HTResolveMethod *resolveMethod = [[HTResolveMethod alloc] init];
    resolveMethod.crashDelegate = self;
    resolveMethod.name = @"颖宝";
    NSLog(@"%@",resolveMethod.name);
    [resolveMethod setupDatasWithTitle:@"我的日记"];
    
    HTResolveSonMethod *resolveSonMethod = [[HTResolveSonMethod alloc] init];
    resolveSonMethod.crashDelegate = self;
    [resolveSonMethod tapNextButtonWithTag:4];
}

#pragma ResolveMethodCrashDelegate
- (void)resolveMethodCrashWithSelName:(NSString *)selName {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示信息" message:[NSString stringWithFormat:@"崩溃方法:%@",selName] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
    NSLog(@"此方法不存在selName==%@",selName);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
