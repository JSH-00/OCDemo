//
//  MyCollectionViewController.m
//  NetImage
//
//  Created by JSH on 2020/9/2.
//  Copyright © 2020 JSH. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "MyCollectionViewCell.h"
#import "NewCollectionViewCell.h"

#define fDeviceWidth ([UIScreen mainScreen].bounds.size.width)
#define fDeviceHeight ([UIScreen mainScreen].bounds.size.height)
static float AD_height = 50;//广告栏高度
@interface MyCollectionViewController ()
@property (nonatomic, strong) NSMutableArray * cellArray;     //collectionView数据
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation MyCollectionViewController
static NSString * const reuseIdentifier1 = @"MyCollectionViewCell";
static NSString * const reuseIdentifier2 = @"NewCollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    //Bar背景颜色
     [self.navigationController.navigationBar setBarTintColor:[UIColor orangeColor]];
     [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:20.0f],NSFontAttributeName, nil]];
     self.navigationItem.title = @"自定义collectionView";
     
     /**
      *  创建collectionView self自动调用setter getter方法
      */
     [self.view addSubview:self.collectionView];
    NSArray *imgArray = [NSArray arrayWithObjects:@"small_one.png",@"small_two.png",@"small_three.png",@"small_four.png",@"small_five.png",@"small_six.png", nil];
       
       //collectionView数据
    self.cellArray = [imgArray mutableCopy]; // NSArray 转 NSMutableArray

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.cellArray.count;
}

#pragma mark 每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

     UICollectionViewCell *cell = [UICollectionViewCell new];
// 不同的 item 显示不同的 cell
     if (indexPath.item % 2 ) {
         cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier1 forIndexPath:indexPath];
         MyCollectionViewCell *newcell = (MyCollectionViewCell *)cell;
         [cell sizeToFit];
         newcell.imgView.image = [UIImage imageNamed:_cellArray[indexPath.item]];
         newcell.text.text = [NSString stringWithFormat:@"Cell %ld",indexPath.item];
     }
     else
     {
         cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier2 forIndexPath:indexPath];
         NewCollectionViewCell *newcell2 = (NewCollectionViewCell *)cell;
         newcell2.imgView.image = [UIImage imageNamed:_cellArray[indexPath.item + 1]];
         newcell2.text.text = [NSString stringWithFormat:@"Cell New %ld",indexPath.item];
     }
    //按钮事件就不实现了……
    return cell;
}

#pragma mark - 创建collectionView并设置代理
- (UICollectionView *)collectionView
{
    if (!_collectionView) {

        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];

        flowLayout.headerReferenceSize = CGSizeMake(fDeviceWidth/2, AD_height+10);//头部大小

        self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, fDeviceHeight) collectionViewLayout:flowLayout];

        // 设置UICollectionView为横向滚动
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //定义每个UICollectionView 的大小
        flowLayout.itemSize = CGSizeMake((fDeviceWidth-20)/2, (fDeviceWidth-20)/2+50);
        //定义每个UICollectionView 横向的间距
        flowLayout.minimumLineSpacing = 5;
        //定义每个UICollectionView 纵向的间距
        flowLayout.minimumInteritemSpacing = 300;
        //定义每个UICollectionView 的边距距
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 5, 5);//上左下右

        //注册cell和ReusableView
        [self.collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"MyCollectionViewCell"];
        [self.collectionView registerClass:[NewCollectionViewCell class] forCellWithReuseIdentifier:@"NewCollectionViewCell"];

        [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];

        //设置代理
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;

        //背景颜色
        self.collectionView.backgroundColor = [UIColor whiteColor];
        //自适应大小
        self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    }
    return _collectionView;
}

#pragma mark 定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

#pragma mark UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选择%ld",indexPath.item);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
