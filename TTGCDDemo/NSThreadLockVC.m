//
//  NSThreadLockVC.m
//  TTGCDDemo
//
//  Created by TT_code on 16/4/28.
//  Copyright © 2016年 TT_code. All rights reserved.
//

#import "NSThreadLockVC.h"
/**
 *  线程锁
 */
@interface NSThreadLockVC ()


/** 售票员01 */
@property (nonatomic, strong) NSThread *thread01;
/** 售票员02 */
@property (nonatomic, strong) NSThread *thread02;
/** 售票员03 */
@property (nonatomic, strong) NSThread *thread03;

/** 票的总数 */
@property (nonatomic, assign) NSInteger ticketCount;
@end

@implementation NSThreadLockVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //模拟售票
    
    
    //设置票总数
    self.ticketCount=100;
    
    
    //创建售票员
    self.thread01 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    self.thread01.name = @"售票员01";
    
    self.thread02 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    self.thread02.name = @"售票员02";
    
    self.thread03 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    self.thread03.name = @"售票员03";
    
   
}


/**
 *  开始售票
 *
 *  @param sender
 */
- (IBAction)Start:(UIButton *)sender {
    
    [self.thread01 start];
    [self.thread02 start];
    [self.thread03 start];
}




/**
 *  售票
 */
- (void)saleTicket
{
    while (1) {
        @synchronized(self) {//参数通常为self  就是当前对象还在就不会死掉。 如果死掉了肯定不能往下执行
            // 先取出总数
            NSInteger count = self.ticketCount;
            if (count > 0) {
                self.ticketCount = count - 1;
                NSLog(@"%@卖了一张票，还剩下%zd张", [NSThread currentThread].name, self.ticketCount);
            } else {
                NSLog(@"票已经卖完了");
                break;
            }
        }
    }
}

@end
