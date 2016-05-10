//
//  NSThreadVC.m
//  TTGCDDemo
//
//  Created by TT_code on 16/4/28.
//  Copyright © 2016年 TT_code. All rights reserved.
//

#import "NSThreadVC.h"

@interface NSThreadVC ()

@end

@implementation NSThreadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}




- (IBAction)Start:(UIButton *)sender {
    [self CreateThread1];
}

- (IBAction)start2:(UIButton *)sender {
    [self CreateThread2];
}

- (IBAction)start3:(UIButton *)sender {
    [self CreateThread3];
}


-(void)CreateThread1
{
    //这样开启只是在主线程。
    NSThread* thread=[[NSThread alloc]initWithTarget:self selector:@selector(run:) object:@"参数"];
    thread.name=@"线程1";//设置标识符
    [thread start];//开启
}


-(void)CreateThread2
{
    //在后台执行线程。
    [self performSelectorInBackground:@selector(run:) withObject:@"参数2"];
}

-(void)CreateThread3
{
    [NSThread detachNewThreadSelector:@selector(run:) toTarget:self withObject:@"参数3"];
}

-(void)run:(id)param
{
    NSLog(@"这里处理一些比较耗时的操作,   打印下参数:%@",param);
}




@end
