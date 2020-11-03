#import <AFNetworking/AFNetworking.h>
@property(nonatomic, assign) UIImageView *ImageView;

UIImageView *imageNetView = [UIImageView new];
[self.view addSubview: imageNetView];
self.ImageView = imageNetView;
imageNetView.frame = CGRectMake(200, 200, 200, 200);

#pragme mark - .创建会话管理者
AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
/* 知识点1：设置AFN采用什么样的方式来解析服务器返回的数据*/

 //如果返回的是XML，那么告诉AFN，响应的时候使用XML的方式解析
// manager.responseSerializer = [AFXMLParserResponseSerializer serializer];

 //如果返回的就是二进制数据，那么采用默认二进制的方式来解析数据（HTTP）
 manager.responseSerializer = [AFHTTPResponseSerializer serializer];

 //采用JSON的方式来解析数据
 //manager.responseSerializer = [AFJSONResponseSerializer serializer];


manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"image/png"]; //指定接收信号为image/png
NSDictionary *paramDict = @{
    @"j_username": @"jishuhan",
    @"j_password": @"00@Wuxian",
    @"from": @"/",
    @"Submit": @"登录",
    @"remember_me": @"on"
};
#pragme mark 发送GET请求
/*
 第一个参数:请求路径(不包含参数).NSString
 第二个参数:字典(发送给服务器的数据~参数)
 第三个参数:progress 进度回调
 第四个参数:success 成功回调
 task:请求任务
 responseObject:响应体信息(JSON--->OC对象)
 第五个参数:failure 失败回调
 error:错误信息
 响应头:task.response
 */


[manager GET:@"https://search-operate.cdn.bcebos.com/9dfdb7a4fa9dab231f5dd9b90dc91597.png" parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
    NSLog(@"%@---%@",[responseObject class],responseObject);
    self.ImageView.image = [UIImage imageWithData:responseObject]; //NSData转UIimage

} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    NSLog(@"请求失败--%@",error);
}];

#pragme mark - 下载文件
@property (nonatomic, strong) NSURLSessionDownloadTask* downloadTask;

- (void)downloadFromURL:(NSString *)downloadURL
{
    /* 创建网络下载对象 */
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    /* 下载地址 */
    NSURL *url = [NSURL URLWithString:downloadURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    /* 下载路径 */
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Announcement"]; // 指定下载到沙盒下新建的Announcement文件夹中
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 创建文件夹
    BOOL isDir = NO;
    BOOL existed = [fileManager fileExistsAtPath:path isDirectory:&isDir]; // fileExistsAtPath 判断一个文件或目录是否有效，isDirectory判断是否一个目录
    if (!(isDir && existed)) {
        // 在Document目录下创建一个Announcement目录
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *filePath = [path stringByAppendingPathComponent:url.lastPathComponent];

    /* 开始请求下载 */
    self.downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"下载进度：%.0f％，线程：%@", downloadProgress.fractionCompleted * 100, [NSThread currentThread]);
        dispatch_async(dispatch_get_main_queue(), ^{
            //进行UI操作（刷新进度条），需要切换到主线
        });

    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        /* 设定下载到的位置 */
        return [NSURL fileURLWithPath:filePath];

    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        [[[UIAlertView alloc] initWithTitle:@"下载完成" message:self.downloadTask.response.suggestedFilename delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil] show]; // 弹出下载完成弹窗提示
    }];
    [self.downloadTask resume];
}
