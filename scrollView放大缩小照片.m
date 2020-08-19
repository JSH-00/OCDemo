@property(nonatomic, strong) UIScrollView *scrollView1;
@property(nonatomic, strong) UIImageView *imageView;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scrollView1];
    [self.scrollView1 addSubview:self.imageView];
    [self setZoomScale];
}

- (void)viewWillLayoutSubviews {
    NSLog(@"viewWillLayoutSubviews");
    [super viewWillLayoutSubviews];

    // 1.移除子视图
    for (UIView *view in self.scrollView1.subviews) {
        [view removeFromSuperview];
    }

    // 2.初始化imageView 将其添加到scrollView 设置contentSize
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sv.png"]];
    [self.scrollView1 addSubview:self.imageView];
    self.scrollView1.contentSize = self.imageView.frame.size;

    // 3.重设minimumZoomScale
    [self setZoomScale];
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

- (void)setZoomScale {
    //取最小的缩小比例（缩到最小时，让宽或高满屏）
    CGFloat widthScale = CGRectGetWidth(self.scrollView1.frame) / CGRectGetWidth(self.imageView.frame);
    CGFloat heightScale = CGRectGetHeight(self.scrollView1.frame) / CGRectGetHeight(self.imageView.frame);
    self.scrollView1.minimumZoomScale = MIN(widthScale, heightScale);
}

- (UIImageView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
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
        _scrollView1 = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        _scrollView1.backgroundColor = [UIColor blackColor];
        _scrollView1.contentSize = self.imageView.frame.size;
//        _scrollView1.contentSize.height = self.imageView.frame.size.height; ！！！错误，contentSize不能单独赋值
        _scrollView1.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//        _scrollView1.scrollsToTop = NO;
//        _scrollView1.bounces = NO;

        _scrollView1.delegate = self;  //???
//        _scrollView1.minimumZoomScale = 0.5;
//        _scrollView1.maximumZoomScale = 4.0;
//        _scrollView1.zoomScale = 1.0;
    }
    return _scrollView1;
}

@end
