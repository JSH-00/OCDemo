@property(nonatomic, strong) UIScrollView *scrollView1;
@property(nonatomic, strong) UIImageView *imageView;

@implementation ViewController

- (void)nextVc{
    SHNewViewController *newVc = [SHNewViewController new];
    [self.navigationController pushViewController:newVc animated:true];
    
   // [self presentViewController:newVc animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
        
  
    // Do any additional setup after loading the view.
    [self.view addSubview:self.scrollView1];
    [self.scrollView1 addSubview:self.imageView];
    [self setZoomScale];
    
    
    // 双击
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    [self.scrollView1 addGestureRecognizer:doubleTap];
    
    
    //button
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
      [button setBackgroundColor:[UIColor redColor]];
      [self.view addSubview:button];
      [button addTarget:self action:@selector(nextVc) forControlEvents:UIControlEventTouchUpInside];
      [button setFrame:CGRectMake(60, 60, 100, 100)];
      return;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    // 指定缩放视图为imageView
    return self.imageView;
    
}

- (UIImageView *)imageView
{
    //懒加载中初始化并添加图片
    if(!_imageView)
    {
        UIImage *image = [UIImage imageNamed:@"sv.png"];
        _imageView = [[UIImageView alloc]initWithImage:image];
    }
    return _imageView;
}

- (UIScrollView *)scrollView1
{
    if (!_scrollView1) {
        // 2.初始化、配置scrollView
        _scrollView1 = [[UIScrollView alloc]initWithFrame:self.view.frame];
        _scrollView1.backgroundColor = [UIColor blackColor];
        _scrollView1.contentSize = self.imageView.frame.size;
        //        _scrollView1.contentSize.height = self.imageView.frame.size.height; ！！！错误，contentSize不能单独赋值
        //        _scrollView1.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;  // ???
        //        _scrollView1.scrollsToTop = NO; //多个视图时，默认不top，单个视图时默认totop为YES
        //        _scrollView1.bounces = NO; // 拖到边缘时是否有反弹效果，默认yes
        //        _scrollView1.contentOffset = CGPointMake(100, 100); //scrollView原点不动，内容向左上偏移的量
        _scrollView1.delegate = self; // 控制器VC设置为scrollView1的代理
        /*
         //此段无法自动适配scrollView的大小,与缩小为满屏冲突
 
         _scrollView1.minimumZoomScale = 0.2; // 缩放最大比例
         _scrollView1.maximumZoomScale = 4.0; // 缩放最小比例
         _scrollView1.zoomScale = 0.2; // 当前缩放比例, 要在最大、最小缩放比例之间
         */
    }
    return _scrollView1;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    // 1.移除子视图
    for (UIView *view in self.scrollView1.subviews) {
        [view removeFromSuperview];
    }
    
    // 2.初始化imageView 将其添加到scrollView 设置contentSize（可滑动区域）
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sv.png"]];
    [self.scrollView1 addSubview:self.imageView];
    self.scrollView1.contentSize = self.imageView.frame.size; // 可滑动区域为imageView的size
    
    // 3.重设minimumZoomScale
    [self setZoomScale];
}


- (void)setZoomScale {
    //取最小的缩小比例（缩到最小时，让宽或高满屏），放大到默认值1.0，初始zoomScale为 1.0
    CGFloat widthScale = CGRectGetWidth(self.scrollView1.frame) / CGRectGetWidth(self.imageView.frame);
    CGFloat heightScale = CGRectGetHeight(self.scrollView1.frame) / CGRectGetHeight(self.imageView.frame);
    self.scrollView1.minimumZoomScale = MIN(widthScale, heightScale);
    self.scrollView1.zoomScale = self.scrollView1.minimumZoomScale; // 初始化时为最小Size
}


- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    // 计算imageView缩小到最小时 imageView与scrollView.frame边缘距离
    // 使双指在放大缩小的同时可以让图片保持局中（两侧黑边大小相等，无黑边时，边距为0）
    CGFloat horizontalPadding = CGRectGetWidth(self.imageView.frame) < CGRectGetWidth(scrollView.frame) ? (CGRectGetWidth(scrollView.frame) - CGRectGetWidth(self.imageView.frame)) / 2 : 0 ;
    NSLog(@"scrollViewDidZoom，%f",horizontalPadding);
    CGFloat verticalPadding = CGRectGetHeight(self.imageView.frame) < CGRectGetHeight(scrollView.frame) ? (CGRectGetHeight(scrollView.frame) - CGRectGetHeight(self.imageView.frame)) / 2 : 0 ;
    NSLog(@"scrollViewDidZoom，%f",verticalPadding);
    scrollView.contentInset = UIEdgeInsetsMake(verticalPadding, horizontalPadding, verticalPadding, horizontalPadding);
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)doubleTap {
    if (self.scrollView1.zoomScale > self.scrollView1.minimumZoomScale) {
        // 视图大于最小视图时 双击将视图缩小至最小
        [self.scrollView1 setZoomScale:self.scrollView1.minimumZoomScale animated:YES];
    }
    else // 以双击点放大视图
    {
        /*
         // 视图为最小时 双击将视图放大至最大
         [self.scrollView setZoomScale:self.scrollView.maximumZoomScale animated:YES];
         */
         
         // 1.获取点击位置
         CGPoint touchPoint = [doubleTap locationInView:self.imageView];
         // 2.获取要显示的imageView区域
         CGRect zoomRect = [self zoomRectForScrollView:self.scrollView1 withScale:self.scrollView1.maximumZoomScale withCenter:touchPoint];
         // 5.将要显示的imageView区域显示到scrollView
         [self.scrollView1 zoomToRect:zoomRect animated:YES];
    }
}

- (CGRect)zoomRectForScrollView:(UIScrollView *)scrollView withScale:(CGFloat)scale withCenter:(CGPoint)center {
    // 3.声明一个区域 滚动视图的宽除以放大倍数可以得到要显示imageView宽度
    
    //touchPoint为放大后的center
    CGRect zoomRect;
    zoomRect.size.width = CGRectGetWidth(scrollView.frame) / scale;  // 把zoomRect的比例放大，放大为 1 / scale
    zoomRect.size.height = CGRectGetHeight(scrollView.frame) / scale;
    
    // 4.点击位置（center）坐标减去1/2图像宽/高度，可以得到要显示imageView的原点x、y坐标
    zoomRect.origin.x = center.x - zoomRect.size.width / 2;  //确定zoomRect坐标
    zoomRect.origin.y = center.y - zoomRect.size.height / 2;
    return zoomRect;
}
@end
