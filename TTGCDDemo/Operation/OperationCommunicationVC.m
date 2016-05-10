//
//  OperationCommunicationVC.m
//  TTGCDDemo
//
//  Created by TT_code on 16/4/28.
//  Copyright © 2016年 TT_code. All rights reserved.
//

#import "OperationCommunicationVC.h"

@interface OperationCommunicationVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imageview;

@end

@implementation OperationCommunicationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
}


/**
 *  下载图片
 *
 *  @param sender
 */
- (IBAction)download:(id)sender {
    [[[NSOperationQueue alloc] init] addOperationWithBlock:^{
        // 图片的网络路径
        NSURL *url = [NSURL URLWithString:@"http://img.pconline.com.cn/images/photoblog/9/9/8/1/9981681/200910/11/1255259355826.jpg"];
        // 加载图片
        NSData *data = [NSData dataWithContentsOfURL:url];
        // 生成图片
        UIImage *image = [UIImage imageWithData:data];
        // 回到主线程
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.imageview.image = image;
        }];
    }];
}





/**
 *  合成图片
 *
 *  @param sender
 */
- (IBAction)synthesis:(id)sender {
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    __block UIImage *image1 = nil;
    // 下载图片1
    NSBlockOperation *download1 = [NSBlockOperation blockOperationWithBlock:^{
        // 图片的网络路径
        NSURL *url = [NSURL URLWithString:@"http://img.pconline.com.cn/images/photoblog/9/9/8/1/9981681/200910/11/1255259355826.jpg"];
        // 加载图片
        NSData *data = [NSData dataWithContentsOfURL:url];
        // 生成图片
        image1 = [UIImage imageWithData:data];
    }];
    
    __block UIImage *image2 = nil;
    // 下载图片2
    NSBlockOperation *download2 = [NSBlockOperation blockOperationWithBlock:^{
        
        // 图片的网络路径
        NSURL *url = [NSURL URLWithString:@"http://pic38.nipic.com/20140228/5571398_215900721128_2.jpg"];
         // 加载图片
        NSData *data = [NSData dataWithContentsOfURL:url];
        // 生成图片
        image2 = [UIImage imageWithData:data];
    }];
    
    // 合成图片
    NSBlockOperation *combine = [NSBlockOperation blockOperationWithBlock:^{
        // 开启新的图形上下文
        UIGraphicsBeginImageContext(CGSizeMake(100, 100));
        
        // 绘制图片
        [image1 drawInRect:CGRectMake(0, 0, 50, 100)];
        image1 = nil;
        [image2 drawInRect:CGRectMake(50, 0, 50, 100)];
        image2 = nil;
        // 取得上下文中的图片
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        // 结束上下文
        UIGraphicsEndImageContext();
        
        // 回到主线程
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.imageview.image = image;
        }];
    }];
    
    //重点在这里 增加依赖
    [combine addDependency:download1];
    [combine addDependency:download2];
    
    [queue addOperation:download1];
    [queue addOperation:download2];
    [queue addOperation:combine];
}

@end
