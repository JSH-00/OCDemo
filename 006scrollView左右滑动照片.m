#import "PageViewController.h"
#define pageControlHeight 70
@interface PageViewController () <UIScrollViewDelegate> //为scrollView增加协议
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) NSArray *contentList;
@property (strong, nonatomic) UIPageControl *pageControl;
@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.navigationController setNavigationBarHidden:YES animated:YES]; // 隐藏NavigateBar
    // 1.初始化数组
    self.contentList = @[@"small_one.png", @"small_two.png", @"small_three.png", @"small_four.png", @"small_five.png"];
    
    // 2.将scrollView和pageControl添加到view 设定控制器背景颜色
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.pageControl];
    self.view.backgroundColor = [UIColor blackColor];
    
    // 3.为scrollView每一页添加图片
    for (NSUInteger i=0; i<self.contentList.count; ++i) {
        // 用 CGRectGetWidth(self.scrollView.frame) * i 计算 x 轴
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.scrollView.frame) * i, 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame))];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = [UIImage imageNamed:self.contentList[i]];
        [self.scrollView addSubview:imageView]; // 每添加一次就要addSubview一次
    }
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        // CGRectGetHeight(self.view.frame) - 2 * pageControlHeight 上下都空出 pageControlHeight 的高度
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, pageControlHeight, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 2 * pageControlHeight)];
        _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame) * self.contentList.count, CGRectGetHeight(self.view.frame) - 2*pageControlHeight);
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.pagingEnabled = YES;  // 为滚动视图启动分页，关闭后无分页段落感，默认为关闭
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO; // 下方横放的滚动条是否显示，默认显示
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - pageControlHeight, CGRectGetWidth(self.view.frame), pageControlHeight)];
        _pageControl.numberOfPages = self.contentList.count; // 页数等于数组内图片的个数
        _pageControl.currentPage = 0;  // 初始高亮点停留的位置
        // 增加点击事件
         [_pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    }
    return _pageControl;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = CGRectGetWidth(self.scrollView.frame);
    NSUInteger page = floor((scrollView.contentOffset.x - pageWidth/2)/pageWidth) + 1; // 根据当前动态移动的位置计算出当前视图所处的页数
//    NSInteger page = scrollView.contentOffset.x / pageWidth; //上行和这行有区别吗，实现效果一样啊???
    self.pageControl.currentPage = page;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    // 状态栏文字变为白色
    return UIStatusBarStyleLightContent;
}

- (void)changePage:(id)sener {
    NSUInteger page = self.pageControl.currentPage; // 计算页码
    CGRect bounds = self.scrollView.bounds;
    bounds.origin.x = CGRectGetWidth(bounds) * page;
    bounds.origin.y = self.scrollView.frame.origin.y;
    [self.scrollView scrollRectToVisible:bounds animated:YES]; // 使用scrollRectToVisible:方法 用bounds给scrollView赋值，滑动当前视图到该区域
}

@end
