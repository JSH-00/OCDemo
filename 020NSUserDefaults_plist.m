/*
    NSUserDefaults是iOS系统提供的一个单例
 */
#pragma mark - plist 创建
NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults]; //获取NSUserDefaults单例
[defaults setObject:@"jack" forKey:@"firstName"];
[defaults setInteger:10 forKey:@"Age"];

UIImage *image =[UIImage imageNamed:@"loading.png"];
NSData *imageData = UIImageJPEGRepresentation(image, 1.0);//把image归档为NSData
[defaults setObject:imageData forKey:@"image"];
[defaults synchronize];
//synchronise是为了强制存储，非必要，会在系统中默认调用，但是需要马上存储的，可这样操作

#pragma mark - plist 获取
NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
NSString *firstName = [defaults objectForKey:@"firstName"];
NSInteger age = [defaults integerForKey:@"Age"];
NSData *imageData = [defaults dataForKey:@"image"];
UIImage *image = [UIImage imageWithData:imageData]; //NSData 转 UIImage
NSLog(@"NAME:%@  AGE:%ld",firstName,(long)age);
/*
     - setObject:forKey:
     - setFloat:forKey:
     - setDouble:forKey:
     - setInteger:forKey:
     - setBool:forKey:
     - setURL:forKey:
 */
