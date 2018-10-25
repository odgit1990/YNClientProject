//
//  YNHomeCollectView.m
//  YNClientProject
//
//  Created by 雅恩三河科技 on 2018/10/22.
//  Copyright © 2018年 雅恩三河科技. All rights reserved.
//

#import "YNHomeCollectView.h"
#import "Head.h"
@interface YNHomeCollectView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView *mCollection;
@end

@implementation YNHomeCollectView
@synthesize mCollection;
#pragma mark - getter and setter
#pragma mark - event
#pragma mark - method
#pragma mark - life
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        CGFloat size = WFCGFloatX((375 -45) / 2);
        
        [flowLayout setItemSize:CGSizeMake(size,  WFCGFloatY(220))];//设置cell的尺寸
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];//设置其布局方向
        flowLayout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);//设置其边界
        flowLayout.minimumInteritemSpacing = 0.0f;
        flowLayout.minimumLineSpacing = 15;
        //其布局很有意思，当你的cell设置大小后，一行多少个cell，由cell的宽度决定
        
        mCollection = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        
        mCollection.dataSource = self;
        mCollection.delegate = self;
        [mCollection setBackgroundColor:[UIColor whiteColor]];
        mCollection.showsVerticalScrollIndicator=NO;
        mCollection.showsHorizontalScrollIndicator=NO;
        mCollection.scrollEnabled=NO;
        //注册Cell，必须要有
        [mCollection registerClass:[ClassCollectionCell class] forCellWithReuseIdentifier:@"collectCell"];
        
        
        [self addSubview:mCollection];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setDataSource:(NSMutableArray *)dataSource
{
    _dataSource=dataSource;
    [mCollection reloadData];
}
#pragma mark - delegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataSource.count;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ClassCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectCell" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor yellowColor];
    [cell setData:self.dataSource[indexPath.row]];

    return cell;
}

#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.handler(indexPath.row);
}

@end

@implementation ClassCollectionCell
@synthesize imageIV,nameLB,backView;

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        backView=[UIView new];
        backView.x=0;
        backView.y=0;
        backView.width=frame.size.width;
        backView.height=frame.size.height;
        backView.backgroundColor=[UIColor whiteColor];
        [WFFunctions WFUIadddashtoView:backView radius:0 width:1 dashPattern:2 spacePattern:2 color:HEXCOLOR(@"#E5E5E5") borderType:BorderTypeDashed];
        [self addSubview:backView];
        
        
        imageIV = [[UIImageView alloc]init];
        imageIV.x=WFCGFloatX(5);
        imageIV.y=WFCGFloatX(5);
        imageIV.width=backView.width-WFCGFloatX(10);
        imageIV.height=imageIV.width;
        imageIV.backgroundColor=[UIColor whiteColor];
        imageIV.contentMode=UIViewContentModeScaleAspectFill;
        imageIV.layer.masksToBounds=YES;
        [self addSubview:imageIV];
        
        nameLB = [[UILabel alloc]init];
        [nameLB setTextColor:Main_Color_Black];
        nameLB.font=SYSTEMFONT(16);
        nameLB.numberOfLines=2;
        nameLB.x=WFCGFloatX(5);
        nameLB.y=imageIV.bottom;
        nameLB.width=backView.width-WFCGFloatX(10);
        nameLB.height=backView.height-nameLB.y;
        [self addSubview:nameLB];
    }
    return self;
}
-(void)setData:(NSDictionary*)info
{
    
    nameLB.text=[WFFunctions WFCheckEmptyBackStr:[info objectForKey:@"title"]];
    [imageIV sd_setImageWithURL:[NSURL URLWithString:[WFFunctions WFCheckEmptyBackStr:[info objectForKey:@"image"]]] placeholderImage:DefaultImage];

    
}
@end
