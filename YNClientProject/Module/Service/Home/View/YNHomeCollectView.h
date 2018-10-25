//
//  YNHomeCollectView.h
//  YNClientProject
//
//  Created by 雅恩三河科技 on 2018/10/22.
//  Copyright © 2018年 雅恩三河科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^collectCellPress)(NSInteger index);
@interface YNHomeCollectView : UIView
@property(nonatomic,strong)NSMutableArray* dataSource;
@property(nonatomic,copy)collectCellPress handler;
@end
//cell
@interface ClassCollectionCell : UICollectionViewCell
@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UIImageView *imageIV;
@property (nonatomic,strong) UILabel *nameLB;

-(void)setData:(NSDictionary*)info;
@end
NS_ASSUME_NONNULL_END
