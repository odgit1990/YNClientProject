//
//  YNHealthPubCell.h
//  YNClientProject
//
//  Created by 雅恩三河科技 on 2018/10/23.
//  Copyright © 2018年 雅恩三河科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YNPubDrugViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface YNHealthPubCell : UITableViewCell
@property(nonatomic,strong)UIButton* minbtn;
@property(nonatomic,strong)UIButton* addBtn;
@property(nonatomic,strong)YNPubDrugViewModel* pubViewModel;
@property(nonatomic,strong)UITextField* detailTF;
-(void)setMarkTitle:(NSString*)title image:(NSString*)imageStr detail:(NSString*)detail cellType:(NSInteger)type;
@end

NS_ASSUME_NONNULL_END
