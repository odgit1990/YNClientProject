//
//  GCBaseTableView.m
//  CBHGroupCar
//
//  Created by mac on 2018/1/24.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "GCBaseTableView.h"
#import "Head.h"

@implementation GCBaseTableView

#pragma mark - setter and getter
-(UIButton *)noDataBtn
{
    if (_noDataBtn) {
        _noDataBtn = [[UIButton alloc]init];
        _noDataBtn.frame = CGRectMake(0, 0, 200, 40);
        _noDataBtn.width=150;
        [WFFunctions WFUIaddbordertoView:_noDataBtn radius:WFCGFloatY(3) width:0.5f color:HEXCOLOR(@"#CD0000")];
        [_noDataBtn setTitle:@"暂无数据" forState:UIControlStateNormal];
        [_noDataBtn setTitleColor:HEXCOLOR(@"#CD0000") forState:UIControlStateNormal];
        _noDataBtn.titleLabel.font = SYSTEMFONT(14);
        _noDataBtn.hidden = YES;
    }
    return _noDataBtn;
}



-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        if (@available(iOS 11.0, *)) {
//            self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//            self.scrollIndicatorInsets = self.contentInset;
            self.estimatedRowHeight = 0;
            self.estimatedSectionFooterHeight = 0;
            self.estimatedSectionHeaderHeight = 0;
            //self.tableFooterView = [UIView new];
        }
        [self addSubview:self.noDataBtn];
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
-(void)layoutSubviews
{
    [super layoutSubviews];
    if (self.visibleCells.count > 0 || self.tableHeaderView || self.tableFooterView) {
        self.noDataBtn.hidden = YES;
    }else{
        self.noDataBtn.hidden = NO;
        _noDataBtn.centerX = self.centerX;
        _noDataBtn.centerY = self.centerY - 50;
    }
}
@end
