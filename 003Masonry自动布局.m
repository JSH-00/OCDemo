//Masonry---------------------------------------------------------------------------
#import "Masonry.h"
@property(nonatomic, weak) UIButton *FirstButton;
@property(nonatomic, weak) UIButton *SecondButton;
@property(nonatomic, weak) UIButton *ThirdButton;
@property(nonatomic, weak) UIButton *FourthButton;
@property(nonatomic, assign) CGFloat ScreenWidth;
@property(nonatomic, assign) CGFloat ScreenHeight;
@property(nonatomic, assign) CGFloat ButtonWidth;
@property(nonatomic, assign) CGFloat ButtonHeight;
{
    NSArray *a = [[NSArray alloc]init];
    NSArray *btnTitle = @[@"First",@"Second",@"Third",@"Fourth"];
    NSMutableArray *btnAarry = [NSMutableArray new]; // 新建可变列表

    UIEdgeInsets padding = UIEdgeInsetsMake(10, 10, 10, 10);
    UIButton *view1 = [[UIButton alloc]init];
    view1.backgroundColor = [UIColor redColor];
    [self.view addSubview:view1];
# pragma mark 普通布局
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(padding.top); //with is an optional semantic filler
        make.left.equalTo(self.view.mas_left).with.offset(padding.left);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-padding.bottom);
        make.right.equalTo(self.view.mas_right).with.offset(-padding.right);
    }];
# pragma mark 多个布局
    UIEdgeInsets btnMargin = UIEdgeInsetsMake(0, 10, 0, 10);
    UIButton *btn1 = [[UIButton alloc]init];
    UIButton *btn2 = [[UIButton alloc]init];
    UIButton *btn3 = [[UIButton alloc]init];
    UIButton *btn4 = [[UIButton alloc]init];

    btn1.backgroundColor = [UIColor blackColor];
    [btn1 setTitle:btnTitle[0] forState:UIControlStateNormal];
    [view1 addSubview:btn1];
    [btnAarry addObject:btn1]; //把按钮插入列表

    btn2.backgroundColor = [UIColor blackColor];
    [btn2 setTitle:btnTitle[1] forState:UIControlStateNormal];
    [view1 addSubview:btn2];
    [btnAarry addObject:btn2];

    btn3.backgroundColor = [UIColor blackColor];
    [btn3 setTitle:btnTitle[2] forState:UIControlStateNormal];
    [view1 addSubview:btn3];
    [btnAarry addObject:btn3];

    btn4.backgroundColor = [UIColor blackColor];
    [btn4 setTitle:btnTitle[3] forState:UIControlStateNormal];
    [view1 addSubview:btn4];
    [btnAarry addObject:btn4];

    /**
    *  distribute with fixed spacing
    *
    *  @param axisType     横排还是竖排
    *  @param fixedSpacing 两个控件间隔
    *  @param leadSpacing  第一个控件与边缘的间隔
    *  @param tailSpacing  最后一个控件与边缘的间隔
    */

//    [btnAarry mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:30 leadSpacing:10 tailSpacing:10];     // 按钮间隔固定
    [btnAarry mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:80 leadSpacing:10 tailSpacing:10];    // 按钮宽固定
    [btnAarry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@-20);
        make.height.equalTo(@40);
    }];

# pragma mark - Safe Area
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
          make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
          make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
          make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
          make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
      }];
