//
//  MyCollectionViewCell.h
//  NetImage
//
//  Created by JSH on 2020/9/2.
//  Copyright © 2020 JSH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyCollectionViewCell : UICollectionViewCell

@property(nonatomic ,strong)UIImageView *imgView;
@property(nonatomic ,strong)UILabel *text;
@property(nonatomic ,strong)UIButton *btn;

@end

NS_ASSUME_NONNULL_END
