#pragma mark - dispatch_semaphore 信号
#pragma mark - 保证线程间同步
dispatch_queue_t que = dispatch_queue_create("com.vc.downloadQueue", DISPATCH_QUEUE_SERIAL);

// 设置信号量为 3
dispatch_semaphore_t semaphore = dispatch_semaphore_create(3); //
dispatch_async(que, ^{
    // 若 signal 0，则 wait forever 否则  signal - 1 并执行后面的代码
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
});

// singal + 1
dispatch_semaphore_signal(self.semaphore);


#pragma mark - 为线程加锁
dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
        
for (int i = 0; i < 100; i++) {
     dispatch_async(queue, ^{
          // 相当于加锁
         dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
          NSLog(@"i = %zd semaphore = %@", i, semaphore);
          // 相当于解锁
          dispatch_semaphore_signal(semaphore);
      });
}
