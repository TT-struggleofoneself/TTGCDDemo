//
//  GCDCommunicationVC.m
//  TTGCDDemo
//
//  Created by TT_code on 16/4/28.
//  Copyright © 2016年 TT_code. All rights reserved.
//

#import "GCDCommunicationVC.h"

@interface GCDCommunicationVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imageview;

@end

@implementation GCDCommunicationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}



- (IBAction)DownLoad:(id)sender {    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 图片的网络路径
        NSURL *url = [NSURL URLWithString:@"http://img.pconline.com.cn/images/photoblog/9/9/8/1/9981681/200910/11/1255259355826.jpg"];
        // 加载图片
        NSData *data = [NSData dataWithContentsOfURL:url];
        // 生成图片
        UIImage *image = [UIImage imageWithData:data];
        
        // 回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageview.image = image;
        });
    });
    
}





@end
