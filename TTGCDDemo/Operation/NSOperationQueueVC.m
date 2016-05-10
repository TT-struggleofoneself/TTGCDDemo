//
//  NSOperationQueueVC.m
//  TTGCDDemo
//
//  Created by TT_code on 16/4/28.
//  Copyright © 2016年 TT_code. All rights reserved.
//

#import "NSOperationQueueVC.h"

@interface NSOperationQueueVC ()

@end

@implementation NSOperationQueueVC

- (void)viewDidLoad {
    [super viewDidLoad];
  
}



- (IBAction)serial:(id)sender {
    
    // 创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
      // 设置最大并发操作数
        queue.maxConcurrentOperationCount = 1; // 就变成了串行队列
        // 添加操作
        [queue addOperationWithBlock:^{
                NSLog(@"11111111111 -- ");
        }];
        [queue addOperationWithBlock:^{
              NSLog(@"22222222222222222 -- ");
        }];
        [queue addOperationWithBlock:^{
                  NSLog(@"333333333333333 -- ");
        }];
}






@end
