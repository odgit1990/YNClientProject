//
//  AttributeCollectionView.m
//  天巢新1期
//
//  Created by 唐建平 on 15/12/15.
//  Copyright © 2015年 JP. All rights reserved.
//

#import "AttributeView.h"
//#import "UIView+Extnesion.h"
#import "Head.h"
#define AppColor  Color(245, 58, 64)

#define margin 15
// 屏幕的宽
#define JPScreenW [UIScreen mainScreen].bounds.size.width
// 屏幕的高
#define JPScreenH [UIScreen mainScreen].bounds.size.height
//RGB
#define Color(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]


@interface AttributeView ()
@property (nonatomic,strong) UILabel *titleLB;

@end

@implementation AttributeView
#pragma mark - getter and setter
-(void)setDatas:(NSMutableArray *)datas
{
    _datas = datas;
    [self reloadView];
}
#pragma mark - method
-(void)reloadView
{
    for (UIView *btn in self.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            [btn removeFromSuperview];
        }
    }
    int count = 0;
    float btnW = 0;
    for (int i = 0; i<_datas.count; i++) {
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = i;


        btn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        NSString *str = _datas[i];
        [btn setTitle:str forState:UIControlStateNormal];
        CGSize strsize = [str sizeWithFont:[UIFont boldSystemFontOfSize:13]];
        
        btn.width = strsize.width + margin;
        btn.height = strsize.height+ margin;
        
        if (i == 0) {
            btn.x = margin;
            btnW += CGRectGetMaxX(btn.frame);
        }
        else{
            btnW += CGRectGetMaxX(btn.frame)+margin;
            if (btnW > self.width) {
                count++;
                btn.x = margin;
                btnW = CGRectGetMaxX(btn.frame);
            }
            else{
                btn.x += btnW - btn.width;
            }
        }
        btn.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.15f];
        btn.userInteractionEnabled = YES;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitleColor:Color(104, 97, 97) forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        btn.y += count * (btn.height + margin) + margin + _titleLB.height +8;
        
        btn.layer.cornerRadius = btn.height/2;
        
        btn.clipsToBounds = YES;
        btn.tag = i;
        [self addSubview:btn];
        if (i == _datas.count - 1) {
            self.height = CGRectGetMaxY(btn.frame) + 10;
            self.x = 0;
        }
        
        if (_isCanPress)
        {
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            if (_defaultSel)
            {
                if (i==0)
                {
                    btn.backgroundColor=HEXCOLOR(@"#FF7890");
                    btn.selected=YES;
                    self.btn=btn;
                }
            }
        }
        
    }
}
/**
 *  返回一个创建好的属性视图,并且带有标题.创建好之后必须设置视图的Y值.
 *
 *  @param texts 属性数组
 *
 *  @param viewWidth 视图宽度
 *
 *  @return attributeView
 */
+ (AttributeView *)attributeViewWithTitle:(NSString *)title titleFont:(UIFont *)font attributeTexts:(NSArray *)texts viewWidth:(CGFloat)viewWidth{
    AttributeView *view = [[AttributeView alloc]init];
    view.width = viewWidth;
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc]init];
    if (![WFFunctions WFStrCheckEmpty:title])
    {
        label.text = [NSString stringWithFormat:@"%@ : ",title];
    }
    label.font = font;
    label.textColor = HEXCOLOR(@"#333333");
    CGSize size = [label.text sizeWithFont:font];
    label.frame = (CGRect){{margin,10},size};
    [view addSubview:label];
    view.titleLB = label;
    
    if (texts) {
        view.datas = [[NSMutableArray alloc]initWithArray:texts];
    }
    return view;
}

- (void)btnClick:(UIButton *)sender{
    if (![self.btn isEqual:sender]) {
        self.btn.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.15f];
        self.btn.selected = NO;
        sender.backgroundColor = HEXCOLOR(@"#FF7890");
        sender.selected = YES;
    }else if([self.btn isEqual:sender]){
//        if (sender.selected == YES) {
//            sender.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.15f];
//            sender.selected = NO;
//        }else{
//            sender.backgroundColor = AppColor;
//            sender.selected = YES;
//        }
    }else{
        
    }
    self.btn = sender;
    if ([self.Attribute_delegate respondsToSelector:@selector(Attribute_View:didClickBtn:)] ) {
        [self.Attribute_delegate Attribute_View:self didClickBtn:sender];
    }
    
    
}

@end
