// 发送
[[NSNotificationCenter defaultCenter] postNotificationName:@"Download_Progress_Update" object:currentModel];
 
 // 监听
 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(progressUpdate:) name:@"Download_Progress_Update" object:nil];

// 监听后执行
 - (void)progressUpdate:(NSNotification *)noti {
     
 }
