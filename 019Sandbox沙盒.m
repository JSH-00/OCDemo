#pragma mark - Documents获取路径

// 方法一：
 NSString *document =  [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];

// 方法二(更安全)：
 NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];

// 方法三（与方法一，二得到的资源路径相比，多了file: //协议头）
 NSURL *document =  [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask]lastObject];

#pragma mark - tmp 获取路径
//方法一：
  NSString *tmp = [NSHomeDirectory() stringByAppendingPathComponent:@"tmp"];

//方法二：
  NSString *tmp = NSTemporaryDirectory();

#pragma mark - Library 获取路径

//苹果建议用来存放默认设置或其它状态信息
//方法一：
NSString *library = [NSHomeDirectory() stringByAppendingPathComponent:@"Library"];

//方法二：
  NSString *library = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)objectAtIndex:0];

//方法三：
 NSURL * library = [[[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask]lastObject];

#pragma mark - Library/Caches 获取路径
//方法一：
NSString *caches =  [[NSHomeDirectory() stringByAppendingPathComponent:@"Library"] stringByAppendingPathComponent:@"Caches"];

//方法二：
  NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0];

//方法三：
 NSURL *caches = [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask]lastObject];

#pragma mark - Library/Preference 获取路径
NSString *preferences =  [[NSHomeDirectory() stringByAppendingPathComponent:@"Library"]stringByAppendingPathComponent:@"Preferences"];

/* 安全的获取方式：
NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
 
NSSearchPathForDirectoriesInDomains 方法用于返回指定范围内的指定名称的目录的路径集合。
有三个参数：
 
directory（表明我们要搜索的目录名称，NSSearchPathDirectory类型的enum值）
 
         NSDocumentDirectory表明我们要搜索的是Documents目录
         NSCachesDirectory就表示我们搜索的是Library/Caches目录。
 
domainMask（指定搜索范围，NSSearchPathDomainMask类型的enum值）
 
         这里的NSUserDomainMask表示搜索的范围限制于当前应用的沙盒目录。
         还可以写成NSLocalDomainMask（表示/Library）
         NSNetworkDomainMask（表示/Network）等。
 
BOOL值（表示是否展开波浪线）
        
        该值为YES，则用全写形式/User/userName
        为NO就形式/Documents
        一般都会用YES，获取完整路径字符串
 
*/

#pragma mark - 创建/删除文件夹

if ([[NSFileManager defaultManager] fileExistsAtPath:createPath]) {
    //文件夹已存在
    return;
} else {
    //创建文件夹
    [[NSFileManager defaultManager] createDirectoryAtPath:createPath withIntermediateDirectories:YES attributes:nil error:nil];
}
#pragma mark - 把文件夹下所有文件/文件夹浅搜索，存入Array中
NSString *homeDirectory = NSHomeDirectory();
NSArray *fileNameList=[[NSFileManager defaultManager]
                       contentsOfDirectoryAtPath:homeDirectory error:nil];
NSLog(@"fileNameList:%@",fileNameList);


#pragma mark - 新建文件夹并写入文件
NSString *createPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]stringByAppendingPathComponent:@"Announcement"];

#pragma mark 判断是否要新建文件夹
if (![[NSFileManager defaultManager] fileExistsAtPath:createPath]) {
    //创建文件夹
    [[NSFileManager defaultManager] createDirectoryAtPath:createPath withIntermediateDirectories:YES attributes:nil error:nil];
}

#pragma mark 写入/读取文件
NSArray *arrayA = [[NSArray alloc] init];
arrayA = @[@"1", @"2", @3, @"4"];
[arrayA writeToFile:[createPath stringByAppendingPathComponent:@"111.txt"] atomically:YES];

NSArray *arrayA2 = [[NSArray alloc] initWithContentsOfFile:[createPath stringByAppendingPathComponent:@"111.txt"]];
NSLog(@"%@",arrayA2);

#pragma mark 删除文件夹
if([[NSFileManager defaultManager] fileExistsAtPath:[createPath stringByAppendingPathComponent:@"111.txt"]]) //如果存在临时文件的配置文件
{
    [[NSFileManager defaultManager]  removeItemAtPath:createPath error:nil];
    NSLog(@"删除文件");
}
