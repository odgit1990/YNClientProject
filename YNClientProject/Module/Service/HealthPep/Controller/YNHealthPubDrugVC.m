//
//  YNHealthPubDrugVC.m
//  YNClientProject
//
//  Created by 雅恩三河科技 on 2018/10/23.
//  Copyright © 2018年 雅恩三河科技. All rights reserved.
//

//
//                .-~~~~~~~~~-._       _.-~~~~~~~~~-.
//            __.'              ~.   .~              `.__
//          .'//                  \./                  \\`.
//        .'//                     |                     \\`.
//      .'// .-~"""""""~~~~-._     |     _,-~~~~"""""""~-. \\`.
//    .'//.-"                 `-.  |  .-'                 "-.\\`.
//  .'//______.============-..   \ | /   ..-============.______\\`.
//.'______________________________\|/______________________________`.
//
//

#import "YNHealthPubDrugVC.h"
#import "Head.h"
#import "YNPubDrugViewModel.h"
#import "YNHealthPubCell.h"
#import "HealthPeoPleViewModel.h"
@interface YNHealthPubDrugVC ()<UITextViewDelegate,TZImagePickerControllerDelegate>
@property(nonatomic,strong)YNPubDrugViewModel* viewModel;
@end

@implementation YNHealthPubDrugVC
#pragma mark - getter and setter
-(YNPubDrugViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel=[YNPubDrugViewModel new];
    }
    return _viewModel;
}
#pragma mark - event
#pragma mark - method
#pragma mark - method
-(void)initilization
{
    
    
    self.isGroup = YES;
    @WeakSelf;
    self.navigationItem.title = @"药品发布";
    self.extendedLayoutIncludesOpaqueBars = YES;

    
    
    self.baseTable.contentInset = UIEdgeInsetsMake([self topShelterHeight], 0, [self bottomShelterHeight], 0);
    self.view.backgroundColor = Main_Color_BG;
    
    [self.view addSubview:self.baseTable];
    [self.baseTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.baseTable setSeparatorColor:Main_Color_BG];
    
    [self viewModelBand];
    
    [self reloadData];
    
}
-(void)viewModelBand
{
    @WeakSelf;
    GCBaseObservationModel* saleOber=[GCBaseObservationModel new];
    saleOber.keyPath=@"pubModel";
    saleOber.observation=self.viewModel;
    saleOber.handler = ^(NSString *keyPath) {
        [selfp.baseTable reloadData];
    };
    [self registObservation:saleOber];
    
}
-(void)reloadListData
{
    NSMutableDictionary* para=[NSMutableDictionary new];
    [para setObject:@"117.119999" forKey:@"lng"];
    [para setObject:@"36.651216" forKey:@"lat"];
    [para setObject:@"1" forKey:@"orderby"];
    [para setObject:@"1" forKey:@"page"];
}
-(void)showIndex:(NSIndexPath*)indexPath
{
    @WeakSelf;
    if (indexPath.section==0||indexPath.section==1)
    {
        if (indexPath.row==1)
        {
            TYAlertView *alertView = [TYAlertView alertViewWithTitle:indexPath.section==0?@"药品名称":@"药品价格" message:indexPath.section==0?@"请输入您的药品名称":@"请输入药品价格"];
            [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
                NSLog(@"%@",action.title);
            }]];
            
            // 弱引用alertView 否则 会循环引用
            __typeof (alertView) __weak weakAlertView = alertView;
            [alertView addAction:[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleDestructive handler:^(TYAlertAction *action) {
                for (UITextField *textField in weakAlertView.textFieldArray) {
                    NSLog(@"%@",textField.text);
                    if ([WFFunctions WFStrCheckEmpty:textField.text]) {
                        [FTIndicator showErrorWithMessage:indexPath.section==0?@"请填写药品名称":@"请填写药品价格"];
                    }else
                    {
                        if (indexPath.section==0)
                        {
                            selfp.viewModel.pubModel.title=textField.text;
                        }else
                        {
                            selfp.viewModel.pubModel.price=textField.text;
                        }
                        
                        [selfp.baseTable reloadData];
                    }
                }
            }]];
            
            [alertView addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                textField.text=indexPath.section==0?selfp.viewModel.pubModel.title:selfp.viewModel.pubModel.price;
                textField.placeholder =indexPath.section==0? @"请输入药品名称":@"请输入药品价格";
                textField.keyboardType=indexPath.section==0?UIKeyboardTypeDefault:UIKeyboardTypeNumbersAndPunctuation;
                [textField becomeFirstResponder];
                
            }];
            // first way to show
            TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleAlert];
            alertController.backgoundTapDismissEnable=YES;
            alertController.alertViewOriginY=[self topShelterHeight]+60;
            [self presentViewController:alertController animated:YES completion:nil];
        }
        
    }
    if (indexPath.section==3)
    {
        TYAlertView *alertView = [TYAlertView alertViewWithTitle:@"药品分类" message:nil];
        alertView.buttonDefaultBgColor=Main_Color_Gold;
        for (int i=0; i<_passTypeArr.count; i++)
        {
            YNDrugModel* model=_passTypeArr[i];
            [alertView addAction:[TYAlertAction actionWithTitle:model.cate_name style:TYAlertActionStyleDefault handler:^(TYAlertAction *action) {
                NSLog(@"%@",action.title);
                selfp.viewModel.pubModel.cate_name=model.cate_name;
                selfp.viewModel.pubModel.cate_id=model.cate_id;
                [selfp.baseTable reloadData];
            }]];
        }
        [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
            NSLog(@"%@",action.title);
        }]];
        
        TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleActionSheet];
        alertController.backgoundTapDismissEnable=YES;
        alertController.alertViewOriginY=[self topShelterHeight]+60;
        [self presentViewController:alertController animated:YES completion:nil];
    }
    if (indexPath.section==4||indexPath.section==6)
    {
        TYAlertView *alertView = [TYAlertView alertViewWithTitle:indexPath.section==4?@"发布人姓名":@"联系电话" message:indexPath.section==4?@"请输入您的姓名":@"请输入联系电话"];
        [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
            NSLog(@"%@",action.title);
        }]];
        
        // 弱引用alertView 否则 会循环引用
        __typeof (alertView) __weak weakAlertView = alertView;
        [alertView addAction:[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleDestructive handler:^(TYAlertAction *action) {
            for (UITextField *textField in weakAlertView.textFieldArray) {
                NSLog(@"%@",textField.text);
                if ([WFFunctions WFStrCheckEmpty:textField.text]) {
                    [FTIndicator showErrorWithMessage:indexPath.section==4?@"请填写您的姓名":@"请填写联系方式"];
                }else
                {
                    if (indexPath.section==4)
                    {
                        selfp.viewModel.pubModel.uname=textField.text;
                    }else
                    {
                        selfp.viewModel.pubModel.mobile=textField.text;
                    }
                    
                    [selfp.baseTable reloadData];
                }
            }
        }]];
        
        [alertView addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.text=indexPath.section==4?selfp.viewModel.pubModel.uname:selfp.viewModel.pubModel.mobile;
            textField.placeholder =indexPath.section==4? @"请输入您的姓名":@"请输入联系电话";
            textField.keyboardType=indexPath.section==4?UIKeyboardTypeDefault:UIKeyboardTypePhonePad;
            [textField becomeFirstResponder];
        }];
        // first way to show
        TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleAlert];
        alertController.backgoundTapDismissEnable=YES;
        alertController.alertViewOriginY=[self topShelterHeight]+60;
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
-(void)reloadData
{
    [self reloadListData];
}
-(void)reloadView
{
    
}
#pragma mark - life

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initilization];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
#pragma mark - delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 8;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0||section==1||section==7) {
        return 2;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    @WeakSelf;
    if (indexPath.section==0)
    {
        if (indexPath.row==1)
        {
            static NSString* identify=@"pp11Phonecell";
            YNHealthPubCell* cell=[tableView dequeueReusableCellWithIdentifier:identify];
            if (!cell) {
                cell=[[YNHealthPubCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
                cell.selectionStyle=UITableViewCellSelectionStyleDefault;
                cell.backgroundColor=[UIColor whiteColor];
            }
            cell.pubViewModel=self.viewModel;
            [cell setMarkTitle:@"药品名称" image:@"pub_title" detail:self.viewModel.pubModel.title cellType:1];
            return cell;
        }
        static NSString* identify=@"OnePhonecell";
        UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:identify];
        if (!cell) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor whiteColor];
        }
        [cell.contentView removeAllSubviews];
        UIImageView* headIV=[UIImageView new];
        headIV.x=WFCGFloatX(15);
        headIV.y=WFCGFloatY(10);
        headIV.width=WFCGFloatX(345);
        headIV.height=WFCGFloatY(104);
        headIV.image=[UIImage imageNamed:@"health_top_bg"];;
        [WFFunctions addCornerToView:headIV radius:5 corner:UIRectCornerTopLeft|UIRectCornerTopRight];
        [cell.contentView addSubview:headIV];
        
        return cell;
    }
    if (indexPath.section==1)
    {
        if (indexPath.row==1)
        {
            static NSString* identify=@"towwppPhonecell";
            YNHealthPubCell* cell=[tableView dequeueReusableCellWithIdentifier:identify];
            if (!cell) {
                cell=[[YNHealthPubCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
                cell.selectionStyle=UITableViewCellSelectionStyleDefault;
                cell.backgroundColor=[UIColor whiteColor];
            }

            cell.pubViewModel=self.viewModel;
            [cell setMarkTitle:@"药品价格" image:@"pub_price" detail:self.viewModel.pubModel.price cellType:1];
            return cell;
        }
        static NSString* identify=@"TwoPhonecell";
        UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:identify];
        if (!cell) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor whiteColor];
        }
        [cell.contentView removeAllSubviews];
        NSArray* titleArr=@[@"药品图片",@"病历图片",@"药品码"];
        float ww=(SCREEN_WIDTH-WFCGFloatY(63)*3-WFCGFloatX(80))/2;
        for (int i=0; i<3; i++)
        {
            UIImageView* headIV=[UIImageView new];
            headIV.x=WFCGFloatX(40)+(WFCGFloatY(63)+ww)*i;
            headIV.y=WFCGFloatY(19);
            headIV.width=WFCGFloatY(63);
            headIV.height=WFCGFloatY(63);
            headIV.image=[UIImage imageNamed:@"pub_add_image"];
            [cell.contentView addSubview:headIV];
            headIV.tag=900+i;
            __block UIImageView* myIV=headIV;
            [headIV addTapGestureRecognizerWithDelegate:self Block:^(NSInteger tag) {
                TZImagePickerController* image=[[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:selfp];
                [image setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                    myIV.image=photos[0];
                    
                }];
                [selfp presentViewController:image animated:YES completion:nil];
            
            }];
            
            
            UILabel* nameLab=[UILabel new];
            nameLab.x=WFCGFloatX(40)+(WFCGFloatY(63)+ww)*i;
            nameLab.y=WFCGFloatY(85);
            nameLab.width=WFCGFloatX(63);
            nameLab.height=WFCGFloatY(20);
            nameLab.font=SYSTEMFONT(15);
            nameLab.textColor=HEXCOLOR(@"#333333");
            nameLab.text=titleArr[i];
            [cell.contentView addSubview:nameLab];
            nameLab.textAlignment=NSTextAlignmentCenter;
        }
        return cell;
    }
    if (indexPath.section==7)
    {
        if (indexPath.row==1)
        {
            static NSString* identify=@"SevTwoPhonecell";
            UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:identify];
            if (!cell) {
                cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
                cell.selectionStyle=UITableViewCellSelectionStyleDefault;
                cell.backgroundColor=[UIColor whiteColor];
            }
            [cell.contentView removeAllSubviews];
            
            UITextView* tf=[[UITextView alloc] init];
            tf.x=WFCGFloatX(15);
            tf.delegate=self;
            tf.y=0;
            tf.width=WFCGFloatX(345);
            tf.height=WFCGFloatY(100);
            [cell.contentView addSubview:tf];
            [WFFunctions WFUIaddbordertoView:tf radius:0 width:0.5 color:HEXCOLOR(@"#CCCCCC")];
            tf.textColor=YN_Light_Black_Color;
            tf.placeholder=@"请输入您的留言";
            tf.font=SYSTEMFONT(15);
            tf.text=self.viewModel.pubModel.remark;
            
            return cell;
        }
        static NSString* identify=@"sevppPhonecell";
        YNHealthPubCell* cell=[tableView dequeueReusableCellWithIdentifier:identify];
        if (!cell) {
            cell=[[YNHealthPubCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
            cell.selectionStyle=UITableViewCellSelectionStyleDefault;
            cell.backgroundColor=[UIColor whiteColor];
        }
        cell.pubViewModel=self.viewModel;
        [cell setMarkTitle:@"留言" image:@"pub_memo" detail:self.viewModel.pubModel.remark cellType:3];

        return cell;
    }
    static NSString* identify=@"ppPhonecell";
    YNHealthPubCell* cell=[tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell=[[YNHealthPubCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.selectionStyle=UITableViewCellSelectionStyleDefault;
        cell.backgroundColor=[UIColor whiteColor];
    }
    
    NSArray* titleArr=@[@"药品数量",@"药品分类",@"发布人姓名",@"交易地址",@"联系电话",@"留言"];
    NSArray* imagArr=@[@"pub_count",@"pub_category",@"pub_name",@"pub_address",@"pub_tel",@"pub_memo"];
    NSString* deital;
    if (indexPath.section==2)
    {
        deital=self.viewModel.pubModel.nums;
        [cell.minbtn handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            if ([selfp.viewModel.pubModel.nums integerValue]==1)
            {
                [FTIndicator showErrorWithMessage:@"药品数量不能低于1"];
            }else
            {
                [selfp.viewModel.pubModel setNums:[NSString stringWithFormat:@"%ld",[selfp.viewModel.pubModel.nums integerValue]-1]];
                [selfp.baseTable reloadData];
            }
        }];
        
        [cell.addBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [selfp.viewModel.pubModel setNums:[NSString stringWithFormat:@"%ld",[selfp.viewModel.pubModel.nums integerValue]+1]];
            [selfp.baseTable reloadData];
        }];
    }
    if (indexPath.section==3)
    {
        deital=self.viewModel.pubModel.cate_name;
    }
    if (indexPath.section==4)
    {
        deital=self.viewModel.pubModel.uname;
    }
    if (indexPath.section==5)
    {
        deital=self.viewModel.pubModel.address;
    }
    if (indexPath.section==6)
    {
        deital=self.viewModel.pubModel.mobile;
    }
    cell.pubViewModel=self.viewModel;
    
    [cell setMarkTitle:titleArr[indexPath.section-2] image:imagArr[indexPath.section-2] detail:deital cellType:indexPath.section==2?2:1];

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0||indexPath.section==1) {
        if (indexPath.row==0) {
            return WFCGFloatY(118);
        }
        return WFCGFloatY(47);
    }
    if (indexPath.section==7) {
        if (indexPath.row==1) {
            return WFCGFloatY(100);
        }
        return WFCGFloatY(47);
    }
    return WFCGFloatY(47);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.00001f;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView* view=[UIView new];
    view.backgroundColor=[UIColor whiteColor];
    if (section==7)
    {
        UIButton* btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.x=WFCGFloatX(34);
        btn.y=WFCGFloatY(30);
        btn.width=WFCGFloatX(307);
        btn.height=WFCGFloatY(43);
        [WFFunctions WFUIaddbordertoView:btn radius:WFCGFloatY(43/2) width:0 color:[UIColor clearColor]];
        [btn setBackgroundColor:Main_Color_Gold forState:UIControlStateNormal];
        [btn setTitle:@"立即发布" forState:UIControlStateNormal];
        [btn setTitleColor:HEXCOLOR(@"#171717") forState:UIControlStateNormal];
        btn.titleLabel.font=SYSTEMFONT(18);
        [view addSubview:btn];
        
        UIButton* chooseBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        UIImage* myIV=[UIImage imageNamed:@"pub_protocal_choose_no"];
        UIImage* SelmyIV=[UIImage imageNamed:@"pub_protocal_choose"];
        [chooseBtn setBackgroundImage:myIV forState:UIControlStateNormal];
        [chooseBtn setBackgroundImage:SelmyIV forState:UIControlStateSelected];
        
        chooseBtn.x=WFCGFloatX(61);
        chooseBtn.y=WFCGFloatY(83);
        chooseBtn.width=myIV.size.width;
        chooseBtn.height=myIV.size.height;
        [view addSubview:chooseBtn];
        [chooseBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            chooseBtn.selected=!chooseBtn.selected;
        }];
        
        
        UILabel* nameLab=[UILabel new];
        nameLab.x=WFCGFloatX(85);
        nameLab.y=WFCGFloatY(84);
        nameLab.width=WFCGFloatX(280);
        nameLab.height=WFCGFloatY(12);
        nameLab.font=SYSTEMFONT(12);
        nameLab.textColor=Main_Font_Color_Gold;
        nameLab.text=@"同意《雅恩智健康共享小药箱服务协议》";
        [view addSubview:nameLab];
        
        
        
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:nameLab.text];
        [string addAttribute:NSForegroundColorAttributeName value:HEXCOLOR(@"#999999") range:NSMakeRange(0, 2)];

        nameLab.attributedText=string;
        
        
        
        [view addSubview:btn];
    }

    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==7) {
        return WFCGFloatY(200);
    }
    return .0001f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    @WeakSelf;
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self showIndex:indexPath];
    
}

@end


/*
 11111111111111111111111111111111111111001111111111111111111111111
 11111111111111111111111111111111111100011111111111111111111111111
 11111111111111111111111111111111100001111111111111111111111111111
 11111111111111111111111111111110000111111111111111111111111111111
 11111111111111111111111111111000000111111111111111111111111111111
 11111111111111111111111111100000011110001100000000000000011111111
 11111111111111111100000000000000000000000000000000011111111111111
 11111111111111110111000000000000000000000000000011111111111111111
 11111111111111111111111000000000000000000000000000000000111111111
 11111111111111111110000000000000000000000000000000111111111111111
 11111111111111111100011100000000000000000000000000000111111111111
 11111111111111100000110000000000011000000000000000000011111111111
 11111111111111000000000000000100111100000000000001100000111111111
 11111111110000000000000000001110111110000000000000111000011111111
 11111111000000000000000000011111111100000000000000011110001111111
 11111110000000011111111111111111111100000000000000001111100111111
 11111111000001111111111111111111110000000000000000001111111111111
 11111111110111111111111111111100000000000000000000000111111111111
 11111111111111110000000000000000000000000000000000000111111111111
 11111111111111111100000000000000000000000000001100000111111111111
 11111111111111000000000000000000000000000000111100000111111111111
 11111111111000000000000000000000000000000001111110000111111111111
 11111111100000000000000000000000000000001111111110000111111111111
 11111110000000000000000000000000000000111111111110000111111111111
 11111100000000000000000001110000001111111111111110001111111111111
 11111000000000000000011111111111111111111111111110011111111111111
 11110000000000000001111111111111111100111111111111111111111111111
 11100000000000000011111111111111111111100001111111111111111111111
 11100000000001000111111111111111111111111000001111111111111111111
 11000000000001100111111111111111111111111110000000111111111111111
 11000000000000111011111111111100011111000011100000001111111111111
 11000000000000011111111111111111000111110000000000000011111111111
 11000000000000000011111111111111000000000000000000000000111111111
 11001000000000000000001111111110000000000000000000000000001111111
 11100110000000000001111111110000000000000000111000000000000111111
 11110110000000000000000000000000000000000111111111110000000011111
 11111110000000000000000000000000000000001111111111111100000001111
 11111110000010000000000000000001100000000111011111111110000001111
 11111111000111110000000000000111110000000000111111111110110000111
 11111110001111111100010000000001111100000111111111111111110000111
 11111110001111111111111110000000111111100000000111111111111000111
 11111111001111111111111111111000000111111111111111111111111100011
 11111111101111111111111111111110000111111111111111111111111001111
 11111111111111111111111111111110001111111111111111111111100111111
 11111111111111111111111111111111001111111111111111111111001111111
 11111111111111111111111111111111100111111111111111111111111111111
 11111111111111111111111111111111110111111111111111111111111111111
 
 
 */
