@property(nonatomic, strong) dispatch_queue_t queue1;

{
    dispatch_queue_t que1 = dispatch_queue_create("com.vc.testQueue", DISPATCH_QUEUE_SERIAL); //串型队列
    self.queue1 = que1;
    
    NSLog(@"main start ");
    
    
    dispatch_async(que1, ^{
        
        
        NSLog(@"1 start ");
        sleep(0.25);
        dispatch_sync(que1, ^{
            
            NSLog(@"2 start ");
            sleep(0.25);
            NSLog(@"2 end");
        });
        NSLog(@"1 end");
        
        
        return;
        
    });
    
    NSLog(@"main finish");
}

- (void)func1 {
    NSLog(@"LOG-----> func1 start %@",[NSThread currentThread]);//打印当前线程
    NSLog(@"LOG-----> func1 finish %@",[NSThread currentThread]);
    
}
11
- (void)func2 {
    NSLog(@"LOG-----> 2 %@",[NSThread currentThread]);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s",__func__);
    
}
