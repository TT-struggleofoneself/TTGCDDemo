//
//  
//   先了解下函数的区别
//   1.获得全局的并发队列---并发（一起发送 高效率）
//   dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//
//   2.创建串行队列----串行，只有一条线  ---创建一个线程 给一个名称
//   dispatch_queue_t queue = dispatch_queue_create("com.520it.queue", DISPATCH_QUEUE_SERIAL);
//
//
//   3.  GCD  异步函数: dispatch_async(queue, ^{});
//
//   4.   3.  GCD  同步函数: dispatch_sync(queue, ^{});
//

#import "GCDConcurrentSynVC.h"

@interface GCDConcurrentSynVC ()

@end

@implementation GCDConcurrentSynVC

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title=@"GCD队列和函数的合并使用";
    
    
    
    
    
    
}

//异步函数 + 并发队列：可以同时开启多条线程
- (IBAction)Start1:(id)sender {
    
    // 1.创建一个并发队列
    // label : 相当于队列的名字
    //    dispatch_queue_t queue = dispatch_queue_create("com.520it.queue", DISPATCH_QUEUE_CONCURRENT);
    // 1.获得全局的并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 2.将任务加入队列
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i<10; i++) {
            NSLog(@"1-----%@", [NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i<10; i++) {
            NSLog(@"2-----%@", [NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i<10; i++) {
            NSLog(@"3-----%@", [NSThread currentThread]);
        }
    });
    NSLog(@"asyncConcurrent--------end");
    
}


//异步函数 + 串行队列：会开启新的线程任务-注:但是任务是串行的，执行完一个任务，再执行下一个
- (IBAction)Start2:(id)sender {
    // 1.创建串行队列
    dispatch_queue_t queue = dispatch_queue_create("com.520it.queue", DISPATCH_QUEUE_SERIAL);
    //    dispatch_queue_t queue = dispatch_queue_create("com.520it.queue", NULL);
    
    // 2.将任务加入队列
    dispatch_async(queue, ^{
        NSLog(@"1-----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"2-----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"3-----%@", [NSThread currentThread]);
    });

}



//同步函数 + 串行队列：不会开启新的线程在当前线程执行任务。任务是串行的，执行完一个任务，再执行下一个任务
- (IBAction)start4:(id)sender {
    
    // 1.创建串行队列
    dispatch_queue_t queue = dispatch_queue_create("com.520it.queue", DISPATCH_QUEUE_SERIAL);
    
    // 2.将任务加入队列
    dispatch_sync(queue, ^{
        NSLog(@"1-----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"2-----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"3-----%@", [NSThread currentThread]);
    });
    
}









//异步函数 + 主队列：只在主线程中执行任务
- (IBAction)start5:(id)sender {
    // 1.获得全局的并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 2.将任务加入队列
    dispatch_sync(queue, ^{
        NSLog(@"1-----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"2-----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"3-----%@", [NSThread currentThread]);
    });
    NSLog(@"syncConcurrent--------end");
}




//同步函数 + 主队列
- (IBAction)start6:(id)sender {
    
    NSLog(@"syncMain ----- begin");
    
    // 1.获得主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    // 2.将任务加入队列
    dispatch_sync(queue, ^{
        NSLog(@"1-----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"2-----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"3-----%@", [NSThread currentThread]);
    });
    
    NSLog(@"syncMain ----- end");
}




//同步函数 + 并发队列：不会开启新的线程
- (IBAction)start3:(id)sender {
    
    // 1.获得全局的并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 2.将任务加入队列
    dispatch_sync(queue, ^{
        NSLog(@"1-----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"2-----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"3-----%@", [NSThread currentThread]);
    });
    NSLog(@"syncConcurrent--------end");
}



@end
