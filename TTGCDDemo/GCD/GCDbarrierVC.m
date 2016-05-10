//
//  
//  
//  barrier: 使用的时候 在他之前的线程会先执行完，然后在执行他 在执行后面的
//  
//
//

#import "GCDbarrierVC.h"

@interface GCDbarrierVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
/** 图片1 */
@property (nonatomic, strong) UIImage *image1;
/** 图片2 */
@property (nonatomic, strong) UIImage *image2;
@end

@implementation GCDbarrierVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
   
}



/**
 *  真实场-----合成下载图片1，2
 *
 *  @param sender
 */
- (IBAction)begin:(id)sender {
    
    
    dispatch_queue_t queue = dispatch_queue_create("12312312", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        // 图片的网络路径
        NSURL *url = [NSURL URLWithString:@"http://img.pconline.com.cn/images/photoblog/9/9/8/1/9981681/200910/11/1255259355826.jpg"];
        
        // 加载图片
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        // 生成图片
        self.image1 = [UIImage imageWithData:data];
        NSLog(@"----1-----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        
        // 图片的网络路径
        NSURL *url = [NSURL URLWithString:@"http://pic38.nipic.com/20140228/5571398_215900721128_2.jpg"];
        
        // 加载图片
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        // 生成图片
        self.image2 = [UIImage imageWithData:data];
        
        
        NSLog(@"----2-----%@", [NSThread currentThread]);
    });
    
    dispatch_barrier_async(queue, ^{
        
     
    });
    
    dispatch_async(queue, ^{
        
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
        NSLog(@"----barrier-----%@", [NSThread currentThread]);
        NSLog(@"----3-----%@", [NSThread currentThread]);
    });
}






- (IBAction)Start:(id)sender {
    
    //说明:barrier ----》之前 1，2 先执行 1，2执行顺序不确定 ---》 然后才是barrier——————
    //----> 3,4   3,4 顺序不确定
    dispatch_queue_t queue = dispatch_queue_create("com.barrier.tiantao", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        NSLog(@"----11111111111-----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        
        
        NSLog(@"----222222222-----%@", [NSThread currentThread]);
    });
    
    
    dispatch_barrier_async(queue, ^{
       
    });
    
    dispatch_async(queue, ^{
        NSLog(@"----33333333333-----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----44444444444-----%@", [NSThread currentThread]);
    });
    
}

@end
