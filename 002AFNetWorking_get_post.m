@property(nonatomic, assign) UIImageView *ImageView;

UIImageView *imageNetView = [UIImageView new];
[self.view addSubview: imageNetView];
self.ImageView = imageNetView;
imageNetView.frame = CGRectMake(200, 200, 200, 200);

//1.创建会话管理者
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
//2.发送GET请求
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
