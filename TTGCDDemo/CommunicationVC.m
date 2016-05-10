//
//  
//  
//
//  线程间的通讯就是线程与线程的配合   就是子线程做耗时操作回到主线程更改UI这里是主线程和子线程的配合。
//
//

#import "CommunicationVC.h"

@interface CommunicationVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imageview;

@end

@implementation CommunicationVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
}




/**
 *  开始下载图片
 *
 *  @param sender
 */
- (IBAction)Start:(UIButton *)sender {
    
     [self performSelectorInBackground:@selector(download) withObject:nil];
    
}

/**
 *  下载过程
 */
- (void)download
{
    // 图片的网络路径
    NSURL *url = [NSURL URLWithString:@"http://img.pconline.com.cn/images/photoblog/9/9/8/1/9981681/200910/11/1255259355826.jpg"];
    // 加载图片
    NSData *data = [NSData dataWithContentsOfURL:url];
    // 生成图片
    UIImage *image = [UIImage imageWithData:data];
    
    
    // 回到主线程，显示图片
    //方法1
    [self.imageview performSelector:@selector(setImage:) onThread:[NSThread mainThread] withObject:image waitUntilDone:NO];
    
    
    //方法2
   // [self.imageview performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
    
}

@end
