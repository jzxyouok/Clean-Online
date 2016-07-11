//
//  BuyViewController.m
//  Dry-CleanOnline
//
//  Created by 李康 on 16/6/14.
//  Copyright © 2016年 李康. All rights reserved.
//

#import "BuyViewController.h"

#import "AdressViewController.h"
#import "Btn_TableView.h"
#import "sqlite.h"

@interface BuyViewController ()<Btn_TableViewDelegate>
@property (strong,nonatomic)UIButton *todayButton;//今天按钮
@property (strong,nonatomic)UIButton *tomorrowButton;//明天按钮
@property (strong,nonatomic)UIButton *afterTommorrow;//后天按钮
@property (strong,nonatomic)UIButton *orderTimeButton;//预约时间按钮
@property (strong,nonatomic)UILabel *addressMessageLabel;//地址标签
@property (strong,nonatomic)UIButton *changeAddress;//更换地址
@property (strong,nonatomic)UIButton *addRemarks;//添加备注按钮
@property (strong,nonatomic)UITextView *remarkTextView;//备注信息
@property (strong,nonatomic)UIButton *order;//下单按钮
@property (strong,nonatomic)Btn_TableView *btnTableView;
@property(strong,nonatomic) UIImageView *remarks;

@property (copy,nonatomic)NSString *dateString;//订单时间

@property (copy,nonatomic)NSString *name;//姓名
@property (copy,nonatomic)NSString *phone;//电话
@property (copy,nonatomic)NSString *address;//地址
@property (assign,nonatomic)NSInteger state;//状态

@end

@implementation BuyViewController
{
    CGFloat heightView;
    CGFloat widthView;
    sqlite *sqliteData;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    sqliteData=[sqlite sharedManager];
    heightView=self.view.frame.size.height;
    widthView=self.view.frame.size.width;
    self.navigationItem.title = @"立即下单";
    [self.view setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"bgfirst.png"]]];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backbt.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backView)];
    
    [self.navigationItem setLeftBarButtonItem:back];
    self.state = 0;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getNum:) name:@"getNumgggg" object:nil];
    
    [self addView];
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    NSString *dateString = [formatter stringFromDate:date];
    _dateString=dateString;
}

-(void)backView{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
    
}
-(void)addView
{
    
    UILabel *appointment =[[UILabel alloc]initWithFrame:CGRectMake(widthView/20, heightView/11, widthView/5, heightView/11)];
    appointment.text=@"预约日期:";
    
    _todayButton =[[UIButton alloc]initWithFrame:CGRectMake(widthView/4,heightView/8.25, widthView/20, heightView/33)];
    [_todayButton setBackgroundImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
    [_todayButton addTarget:self action:@selector(chooseToday:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *todayLabel =[[UILabel alloc]initWithFrame:CGRectMake(widthView/20*6, heightView/11, widthView/10, heightView/11)];//今天按钮后的文字提示
    todayLabel.text=@"今天";
    
    _tomorrowButton =[[UIButton alloc]initWithFrame:CGRectMake(widthView/20*8,heightView/8.25, widthView/20, heightView/33)];
    [_tomorrowButton setBackgroundImage:[UIImage imageNamed:@"checkboxN.png"] forState:UIControlStateNormal];
    [_tomorrowButton addTarget:self action:@selector(chooseTomorrow:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *tomorrowLabel=[[UILabel alloc]initWithFrame:CGRectMake(widthView/20*9, heightView/11, widthView/10, heightView/11)];//今天按钮后的文字提示
    tomorrowLabel.text=@"明天";
    
    _afterTommorrow =[[UIButton alloc]initWithFrame:CGRectMake(widthView/20*11,heightView/8.25, widthView/20, heightView/33)];
    [_afterTommorrow setBackgroundImage:[UIImage imageNamed:@"checkboxN.png"] forState:UIControlStateNormal];
    [_afterTommorrow addTarget:self action:@selector(chooseAfterTomorrow:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *afterTomorrowLabel=[[UILabel alloc]initWithFrame:CGRectMake(widthView/20*12, heightView/11, widthView/10, heightView/11)];//今天按钮后的文字提示
    afterTomorrowLabel.text=@"后天";
    
    UILabel *orderTime =[[UILabel alloc]initWithFrame:CGRectMake(widthView/20, heightView/11*2, widthView/5, heightView/11)];
    orderTime.text=@"预约时间:";
    
    
    _btnTableView=[[Btn_TableView alloc]initWithFrame:CGRectMake(widthView/4, heightView/11*2.2, widthView/20*12, heightView/20)];
    
    _btnTableView.delegate_Btn_TableView = self;
    //按钮名字
    _btnTableView.m_Btn_Name = @"10:00-12:00";
    //数据内容
    _btnTableView.m_TableViewData = @[@"10:00-12:00",@"12:00-14:00",@"14:00-16:00",@"16:00-18:00",@"18:00-20:00",@"20:00-22:00"];
    [_btnTableView addViewData];
    
    
    [_btnTableView.m_btn setBackgroundImage:[UIImage imageNamed:@"xlbt.png"] forState:UIControlStateNormal];
    
    
    UILabel *addressLabel=[[UILabel alloc]initWithFrame:CGRectMake(widthView/20, heightView/11*3, widthView/5, heightView/11)];
    addressLabel.text=@"地址:   ";
    
    _addressMessageLabel=[[UILabel alloc]initWithFrame:CGRectMake(widthView/4, heightView/11*3.3, widthView/20*12, heightView/11*2)];
    _addressMessageLabel.layer.borderColor=[UIColor greenColor].CGColor;
    _addressMessageLabel.layer.borderWidth=1;
    
    
    //更换地址
    _changeAddress =[[UIButton alloc]initWithFrame:CGRectMake(widthView/20*14, heightView/11*5.4, widthView/20*3, heightView/22)];
    [_changeAddress setTitle:@"更换地址" forState:UIControlStateNormal];
    [_changeAddress setBackgroundImage:[UIImage imageNamed:@"changebt.png"] forState:UIControlStateNormal];
    _changeAddress.titleLabel.font=[UIFont boldSystemFontOfSize:12];
    [_changeAddress addTarget:self action:@selector(changeaddress) forControlEvents:UIControlEventTouchUpInside];
    
    //备注栏
    self.remarks=[[UIImageView alloc]initWithFrame:CGRectMake(0, heightView/11*6, widthView, heightView/22*1.2)];
    self.remarks.image=[UIImage imageNamed:@"bzbg1.png"];
    self.remarks.userInteractionEnabled=YES;
    UILabel *remarksLabel=[[UILabel alloc]initWithFrame:CGRectMake(widthView/20, 5, widthView/5, heightView/22*1.2-10)];
    remarksLabel.text=@"备注:";
    
    _addRemarks=[[UIButton alloc]initWithFrame:CGRectMake(widthView/4, 0, widthView/4*3, heightView/22*1.2)];
    [_addRemarks addTarget:self action:@selector(addRemark:) forControlEvents:UIControlEventTouchUpInside];
    
    _remarkTextView=[[UITextView alloc]initWithFrame:CGRectMake(widthView/10, heightView/22*13.5, widthView/20*15, heightView/22*5.5)];
    _remarkTextView.font=[UIFont boldSystemFontOfSize:12];
    _remarkTextView.layer.borderColor=[UIColor greenColor].CGColor;
    _remarkTextView.layer.borderWidth=1;
    _remarkTextView.delegate=self;
    _remarkTextView.hidden=YES;
    _remarkTextView.tag = 10;
    
    _order =[[UIButton alloc]initWithFrame:CGRectMake(0, heightView/22*20, widthView, heightView/11)];
    _order.backgroundColor=[UIColor orangeColor];
    [_order setTitle:@"立即下单" forState:UIControlStateNormal];
    _order.titleLabel.font=[UIFont boldSystemFontOfSize:20];
    [_order addTarget:self action:@selector(order:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    [self.view addSubview:appointment];
    [self.view addSubview:_todayButton];
    [self.view addSubview:todayLabel];
    [self.view addSubview:_tomorrowButton];
    [self.view addSubview:tomorrowLabel];
    [self.view addSubview:_afterTommorrow];
    [self.view addSubview:afterTomorrowLabel];
    [self.view addSubview:orderTime];
    [self.view addSubview:_btnTableView];
    [self.view addSubview:addressLabel];
    [self.view addSubview:_addressMessageLabel];
    [self.view addSubview:_changeAddress];
    [self.view addSubview:self.remarks];
    [self.remarks addSubview:remarksLabel];
    [self.remarks addSubview:_addRemarks];
    [self.view addSubview:_remarkTextView];
    [self.view addSubview:_order];
    
    
    
}

-(void)changeaddress{
    
    AdressViewController *addressView = [[AdressViewController alloc]init];
    UINavigationController *addressNV = [[UINavigationController alloc]initWithRootViewController:addressView];
    addressNV.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController:addressNV animated:YES completion:nil];
    
    
    
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    //我的天，我也不想这么玩的，为时已晚，下次注意........
    
    //接受各种传过来的值
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hidden:) name:@"hidden" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(overhidden:) name:@"over" object:nil];
    
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(passAdress:) name:@"passAddress" object:nil];
    

    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getAdress:) name:@"getAddress" object:nil];
    
    
//    
    
}


-(void)getIndex:(NSNotification *)notification{
    
    NSDictionary *tmpDic = [notification userInfo];
    int index = [tmpDic[@"index"] intValue];
    NSLog(@"index = %d",index);
    NSArray *tmpAddress = [sqliteData readDataFromAdress];
    
    self.name = tmpAddress[index][@"name"];
    self.phone =tmpAddress[index][@"phone"];
    self.address =[tmpAddress[index][@"city"] stringByAppendingString:tmpAddress[index][@"address"]];
 
    NSLog(@"这边调用了 %@,%@,%@",self.name,self.phone,self.address);
    
}

-(void)getAdress:(NSNotification *)notification{
    
    NSDictionary *tmpDic = [notification userInfo];
    self.addressMessageLabel.text = tmpDic[@"address"];
    self.name = tmpDic[@"name"];
    self.phone = tmpDic[@"phone"];
    self.address = tmpDic[@"address"];
    NSLog(@"地址成功了");
    
}
-(void)passAdress:(NSNotification *)notification{
    
    NSDictionary *tmpDic = [notification userInfo];
    self.addressMessageLabel.text = tmpDic[@"address"];
    
}

//-(void)getNum:(NSNotification *)notification{
//    
//    NSDictionary *tmpDic = [notification userInfo];
//    self.price = [tmpDic[@"picknum"] intValue];
//    NSLog(@"这里的price为%d",self.price);
//    
//    
//}


-(void)overhidden:(NSNotification *)notification{
    if (_remarkTextView.tag == 100) {
        
        self.remarkTextView.hidden = NO;
    }
    
    self.remarks.hidden = NO;
    self.changeAddress.hidden = NO;
    self.addressMessageLabel.hidden = NO;
    
}
-(void)hidden:(NSNotification *)notification{
    
    self.addressMessageLabel.hidden = YES;
    self.remarkTextView.hidden = YES;
    
    self.remarks.hidden = YES;
    self.changeAddress.hidden = YES;
    
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)performBack
//{
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

-(void)addRemark:(UIButton *)sender
{
    
    _remarkTextView.hidden=NO;
    _remarkTextView.tag = 100;
    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if ([text isEqualToString:@"\n"]) {
        [_remarkTextView resignFirstResponder];
        return NO;
    }
    return YES;
}

//下单按钮，数据写入数据库
-(void)order:(UIButton *)sender
{
    
    if (self.name!= nil && self.phone != nil && self.price != 0 &&self.dateString !=nil) {
        
        [sqliteData insertDataFromOrder:self.price  withNum:self.price/10 withTime:self.dateString withName:self.name withPhone:self.phone withAddress:self.address withState:(integer_t)self.state];
        
        
        NSLog(@"立即下单");
        
    }
    
    
}
//订单日期
-(void)chooseToday:(UIButton *)sender
{
    [_todayButton setBackgroundImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
    [_tomorrowButton setBackgroundImage:[UIImage imageNamed:@"checkboxN.png"] forState:UIControlStateNormal];
    [_afterTommorrow setBackgroundImage:[UIImage imageNamed:@"checkboxN.png"] forState:UIControlStateNormal];
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    NSString *dateString = [formatter stringFromDate:date];
    _dateString=dateString;
    NSLog(@"%@",dateString);

}
-(void)chooseTomorrow:(UIButton *)sender
{
    [_todayButton setBackgroundImage:[UIImage imageNamed:@"checkboxN.png"] forState:UIControlStateNormal];
    [_tomorrowButton setBackgroundImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
    [_afterTommorrow setBackgroundImage:[UIImage imageNamed:@"checkboxN.png"] forState:UIControlStateNormal];
    NSTimeInterval  interval = 24*60*60*1;
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:+interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    NSString *dateString = [formatter stringFromDate:date];
    _dateString=dateString;
    NSLog(@"%@",dateString);
}
-(void)chooseAfterTomorrow:(UIButton *)sender
{
    [_todayButton setBackgroundImage:[UIImage imageNamed:@"checkboxN.png"] forState:UIControlStateNormal];
    [_tomorrowButton setBackgroundImage:[UIImage imageNamed:@"checkboxN.png"] forState:UIControlStateNormal];
    [_afterTommorrow setBackgroundImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
    NSTimeInterval  interval = 24*60*60*2;
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:+interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    NSString *dateString = [formatter stringFromDate:date];
    _dateString=dateString;
    NSLog(@"%@",dateString);
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [_btnTableView.m_btn setTitle:_btnTableView.m_TableViewData[indexPath.row] forState:UIControlStateNormal];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}
@end
