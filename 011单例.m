// 单例
    TableViewController * obj1 = [TableViewController sharedInstance] ;
    NSLog(@"obj1 = %@.", obj1) ;
    
    TableViewController* obj2 = [TableViewController sharedInstance] ;
    NSLog(@"obj2 = %@.", obj2) ;
//    TableViewController* obj3 = [[TableViewController alloc] init] ;
//    NSLog(@"obj3 = %@.", obj3) ;
//    TableViewController* obj4 = [[TableViewController alloc] init] ;
//    NSLog(@"obj4 = %@.", [obj3 copy]) ;

}

// 单例
+ (instancetype)sharedInstance {
    static TableViewController *shareInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}


+(instancetype) allocWithZone:(struct _NSZone *)zone
{
    return [TableViewController sharedInstance] ;
}
 
-(instancetype) copyWithZone:(struct _NSZone *)zone
{
    return [TableViewController sharedInstance] ;
}

- (instancetype)mutableCopyWithZone:(nullable NSZone *)zone {
    return [TableViewController sharedInstance];
}
