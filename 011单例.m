//// 单例
//    TableViewController * obj1 = [TableViewController sharedInstance] ;
//    NSLog(@"obj1 = %@.", obj1) ;
//
//    TableViewController* obj2 = [TableViewController sharedInstance] ;
//    NSLog(@"obj2 = %@.", obj2) ;
////    TableViewController* obj3 = [[TableViewController alloc] init] ;
////    NSLog(@"obj3 = %@.", obj3) ;
////    TableViewController* obj4 = [[TableViewController alloc] init] ;
////    NSLog(@"obj4 = %@.", [obj3 copy]) ;
//
//}
//
//// 单例
//+ (instancetype)sharedInstance {
//    static TableViewController *shareInstance = nil;
//    static dispatch_once_t once;
//    dispatch_once(&once, ^{
//        shareInstance = [[self alloc] init];
//    });
//    return shareInstance;
//}
//
//
//+(instancetype) allocWithZone:(struct _NSZone *)zone
//{
//    return [TableViewController sharedInstance] ;
//}
//
//-(instancetype) copyWithZone:(struct _NSZone *)zone
//{
//    return [TableViewController sharedInstance] ;
//}
//
//- (instancetype)mutableCopyWithZone:(nullable NSZone *)zone {
//    return [TableViewController sharedInstance];
//}

#pragma mark - 定义.h 一个单例需要创建一个model？
#import "Singleton.h"
 
@implementation Singleton
 
static Singleton* _instance = nil;
 
+(instancetype) shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init] ;
    }) ;
     
    return _instance ;
}
 
+(id) allocWithZone:(struct _NSZone *)zone
{
    return [Singleton shareInstance] ;
}
 
-(id) copyWithZone:(struct _NSZone *)zone
{
    return [Singleton shareInstance] ;
}
 
@end

#pragma mark - 使用
#import "ViewController.h"
#import "SingleClass.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"开始《《《");
    SingleClass *obj1 = [SingleClass shareInstance] ;
    NSLog(@"obj1 = %@.", obj1) ;
    
    SingleClass *obj2 = [SingleClass shareInstance] ;
    NSLog(@"obj2 = %@.", obj2) ;
    
    SingleClass *obj3 = [[SingleClass alloc] init] ;
    NSLog(@"obj3 = %@.", obj3) ;
    
    SingleClass* obj4 = [[SingleClass alloc] init] ;
    NSLog(@"obj4 = %@.", [obj4 copy]) ;

    NSLog(@"结束》》》");
}

@end
/*
 打印结果：
 
开始《《《
obj1 = <SingleClass: 0x7fd9e261d690>.
obj2 = <SingleClass: 0x7fd9e261d690>.
obj3 = <SingleClass: 0x7fd9e261d690>.
obj4 = <SingleClass: 0x7fd9e261d690>.
结束》》》
 */
