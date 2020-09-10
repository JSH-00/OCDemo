# pragma mark - protocol.h

#import <Foundation/Foundation.h>

@protocol Cooker2Delegate <NSObject> // 创建协议
@required // 必须要在使用该协议的class中实现
- (void)CookStep1:(NSString *)name;
@optional // 选择性实现
@end

@interface Cooker2 : NSObject
@property(nonatomic,assign)id<Cooker2Delegate> delegate; // 创建Cooker2Delegate协议对应的delegate
@property (nonatomic, assign) NSString *coo;

- (void)Cook2Fangfa;
- (void)setCooValue:(NSString *)Coo;
@end

# pragma mark - protocol.m
#import "Cooker2.h"

@implementation Cooker2
// nil
@end

# pragma mark - VC.m

#import "protocol.h"
- (void)viewDidLoad {
    [super viewDidLoad];
    Cooker2 *c1 = [Cooker2 new];
    c1.delegate = (id)self;
    c1.coo = @"JSH";
    NSLog(@"%@",self);
    [c1.delegate CookStep1:c1.coo];
    
}

- (void)CookStep1:(NSString *)name // 实现protocol里的协议
{
    NSLog(@"CookStep1---%@",name);
}
@end
