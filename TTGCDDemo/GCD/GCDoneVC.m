//
//  GCDoneVC.m
//  TTGCDDemo
//
//  Created by TT_code on 16/4/28.
//  Copyright © 2016年 TT_code. All rights reserved.
//

#import "GCDoneVC.h"

@interface GCDoneVC ()

@end

@implementation GCDoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}



/**
 *  开始执行-----因为只执行一次 所以通常用来写单例
 *
 *  @param sender
 */
- (IBAction)begain:(id)sender {
    dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"你们看我只能执行一次 什么情况");
    });

}



@end
