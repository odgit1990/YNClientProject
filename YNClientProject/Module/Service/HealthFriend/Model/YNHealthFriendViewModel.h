//
//  YNHealthFriendViewModel.h
//  YNClientProject
//
//  Created by 雅恩三河科技 on 2018/10/19.
//  Copyright © 2018年 雅恩三河科技. All rights reserved.
//

#import "GCBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface YNHealthNewSModel : NSObject
@property (nonatomic, strong) NSString * posts_author;
@property (nonatomic, strong) NSString * posts_date;
@property (nonatomic, strong) NSString * posts_desc;
@property (nonatomic, strong) NSString * posts_id;
@property (nonatomic, strong) NSString * posts_thumbnail;
@property (nonatomic, strong) NSString * posts_title;
@property (nonatomic, strong) NSString * posts_url;
@end

@interface YNHealthFriendViewModel : GCBaseViewModel
@property(nonatomic,strong)NSMutableArray* docArr;
@property(nonatomic,strong)NSMutableArray* healthArr;
@property(nonatomic,assign)BOOL leftAdd;
@property(nonatomic,assign)BOOL rightAdd;
-(void)requestLeftData:(NSMutableDictionary *)para;
-(void)requestRightData:(NSMutableDictionary *)para;
@end

NS_ASSUME_NONNULL_END
