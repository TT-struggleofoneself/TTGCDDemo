//
//  NSInvocationOperationVC.m
//  TTGCDDemo
//
//  Created by TT_code on 16/4/28.
//  Copyright © 2016年 TT_code. All rights reserved.
//

#import "NSInvocationOperationVC.h"

@interface NSInvocationOperationVC ()

@end

@implementation NSInvocationOperationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
  
}



/**
 *  开始
 *
 *  @param sender
 */
- (IBAction)start:(id)sender {
    
    // 创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 创建操作（任务）
    // 创建NSInvocationOperation
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(download1) object:nil];
    NSInvocationOperation *op2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(download2) object:nil];
    
    // 创建NSBlockOperation
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"download3 --- %@", [NSThread currentThread]);
    }];
    
    [op3 addExecutionBlock:^{
        NSLog(@"download4 --- %@", [NSThread currentThread]);
    }];
    [op3 addExecutionBlock:^{
        NSLog(@"download5 --- %@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *op4 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"download6 --- %@", [NSThread currentThread]);
    }];
    // 添加任务到队列中
    [queue addOperation:op1]; // [op1 start]
    [queue addOperation:op2]; // [op2 start]
    [queue addOperation:op3]; // [op3 start]
    [queue addOperation:op4]; // [op4 start]
    
}



- (void)download1
{
    NSLog(@"download1 --- %@", [NSThread currentThread]);
}

- (void)download2
{
    NSLog(@"download2 --- %@", [NSThread currentThread]);
}


@end
