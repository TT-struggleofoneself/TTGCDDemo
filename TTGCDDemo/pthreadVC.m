//
//  pthreadVC.m
//  TTGCDDemo
//
//  Created by TT_code on 16/4/28.
//  Copyright © 2016年 TT_code. All rights reserved.
//

#import "pthreadVC.h"

#import <pthread.h>//注意 需要导入库---库不用加
@interface pthreadVC ()

@end

@implementation pthreadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}


void * run(void *param)
{
    for (NSInteger i = 0; i<50000; i++) {
        NSLog(@"------点击button---%zd--%@", i, [NSThread currentThread]);
    }
    return NULL;
}


- (IBAction)Start:(UIButton *)sender {
    pthread_t thread;
    pthread_create(&thread, NULL, run, NULL);
    
}



@end
