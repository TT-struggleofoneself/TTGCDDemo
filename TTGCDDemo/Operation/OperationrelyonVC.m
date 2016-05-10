//
//  OperationrelyonVC.m
//  TTGCDDemo
//
//  Created by TT_code on 16/4/28.
//  Copyright © 2016年 TT_code. All rights reserved.
//

#import "OperationrelyonVC.h"

@interface OperationrelyonVC ()

@end

@implementation OperationrelyonVC

- (void)viewDidLoad {
    [super viewDidLoad];
 
}


/**
 *  开始
 *
 *  @param sender 
 */
- (IBAction)begain:(id)sender {
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"download1----%@", [NSThread  currentThread]);
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"download2----%@", [NSThread  currentThread]);
    }];
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"download3----%@", [NSThread  currentThread]);
    }];
    NSBlockOperation *op4 = [NSBlockOperation blockOperationWithBlock:^{
        for (NSInteger i = 0; i<10; i++) {
            NSLog(@"download4----%@", [NSThread  currentThread]);
        }
    }];
    NSBlockOperation *op5 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"download5----%@", [NSThread  currentThread]);
    }];
    op5.completionBlock = ^{
        NSLog(@"op5执行完毕---%@", [NSThread currentThread]);
    };
    // 设置依赖
    [op3 addDependency:op1];//增加的依赖是1，2，4 先执行了之后 才执行3
    [op3 addDependency:op2];
    [op3 addDependency:op4];
    
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    [queue addOperation:op4];
    [queue addOperation:op5];
    
}




@end
