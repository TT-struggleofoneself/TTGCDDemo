//
//  GCDgroupVC.m
//  TTGCDDemo
//
//  Created by TT_code on 16/4/28.
//  Copyright © 2016年 TT_code. All rights reserved.
//

#import "GCDgroupVC.h"

@interface GCDgroupVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imageview;

/** 图片1 */
@property (nonatomic, strong) UIImage *image1;
/** 图片2 */
@property (nonatomic, strong) UIImage *image2;


@end

@implementation GCDgroupVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

/**
 *  实际场景   ------下载图片1，2 合成图片
 *
 *  @param sender 
 */
- (IBAction)begain:(id)sender {
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // 创建一个队列组
    dispatch_group_t group = dispatch_group_create();
    // 1.下载图片1
    dispatch_group_async(group, queue, ^{
        // 图片的网络路径
        NSURL *url = [NSURL URLWithString:@"http://img.pconline.com.cn/images/photoblog/9/9/8/1/9981681/200910/11/1255259355826.jpg"];
        // 加载图片
        NSData *data = [NSData dataWithContentsOfURL:url];
        // 生成图片
        self.image1 = [UIImage imageWithData:data];
    });
    
    // 2.下载图片2
    dispatch_group_async(group, queue, ^{
        // 图片的网络路径
        NSURL *url = [NSURL URLWithString:@"http://pic38.nipic.com/20140228/5571398_215900721128_2.jpg"];
        // 加载图片
        NSData *data = [NSData dataWithContentsOfURL:url];
        // 生成图片
        self.image2 = [UIImage imageWithData:data];
    });
    
    // 3.将图片1、图片2合成一张新的图片
    dispatch_group_notify(group, queue, ^{
        // 开启新的图形上下文
        UIGraphicsBeginImageContext(CGSizeMake(100, 100));
        // 绘制图片
        [self.image1 drawInRect:CGRectMake(0, 0, 50, 100)];
        [self.image2 drawInRect:CGRectMake(50, 0, 50, 100)];
        
        // 取得上下文中的图片
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        // 结束上下文
        UIGraphicsEndImageContext();
        // 回到主线程显示图片
        dispatch_async(dispatch_get_main_queue(), ^{
            // 4.将新图片显示出来
            self.imageview.image = image;
        });
    });
}


@end
