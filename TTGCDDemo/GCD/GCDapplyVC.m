//
//  GCDapplyVC.m
//  TTGCDDemo
//
//  Created by TT_code on 16/4/28.
//  Copyright © 2016年 TT_code. All rights reserved.
//

#import "GCDapplyVC.h"

@interface GCDapplyVC ()

@end

@implementation GCDapplyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

/**
 *  理论知识
 *
 *  @param sender
 */
- (IBAction)start:(UIButton *)sender {
    __block NSArray* array=@[@"姓名1",@"姓名2",@"姓名3",@"姓名4"];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //queue 可以是主线程---[NSThread mainThread]
    dispatch_apply(array.count, queue, ^(size_t index) {
        NSLog(@"我是获取到的元素:%@",array[index]);  //不是按顺序遍历的
    });
    
    
    
}

/**
 *  真实场景------把A文件的东西剪切到B文件---好处 同时进行 效率高
 *
 *  @param sender
 */
- (IBAction)begin:(id)sender {
   
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
   
        NSString *from =@"/Users/tt_code/Desktop/A";
        NSString *to = @"/Users/tt_code/Desktop/B";
        NSFileManager *mgr = [NSFileManager defaultManager];
        NSArray *subpaths = [mgr subpathsAtPath:from];
    
    dispatch_apply(subpaths.count, queue, ^(size_t index) {
        NSString *subpath = subpaths[index];
        NSString *fromFullpath = [from stringByAppendingPathComponent:subpath];
        NSString *toFullpath = [to stringByAppendingPathComponent:subpath];
        // 剪切
        [mgr moveItemAtPath:fromFullpath toPath:toFullpath error:nil];
        NSLog(@"%@---%@", [NSThread currentThread], subpath);
    });
    
}

@end
