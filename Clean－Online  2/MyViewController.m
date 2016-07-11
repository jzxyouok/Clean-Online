//
//  MyViewController.m
//  Dry-CleanOnline
//
//  Created by 李康 on 16/6/13.
//  Copyright © 2016年 李康. All rights reserved.
//

#import "MyViewController.h"
#import "SDImageCache.h"
#import "AboutViewController.h"
#import "OfferViewController.h"
#import "AdressViewController.h"

@interface MyViewController ()

@property(strong,nonatomic) NSArray *userList;
@property(strong,nonatomic) UITableView *tableview;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"bgfirst.png"]]];

    // Do any additional setup after loading the view.
    self.navigationItem.title = @"个人中心";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bottombg.png"]];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width
, 410) style:UITableViewStylePlain];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    //把tabView添加到视图之上
    [self.view addSubview:self.tableview];
    
    
    
    self.userList = @[@"地址管理",@"消息中心",@"常见问题",@"意见反馈",@"用户协议",@"关于洗e洗",@"退出账号",@"清除缓存"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.userList count];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //   声明静态字符串型对象，用来标记重用单元格
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
   
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
  
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TableSampleIdentifier];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //设置标题
    cell.textLabel.text = self.userList[indexPath.row];
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        AdressViewController *addressView = [[AdressViewController alloc]init];
        UINavigationController *addressNV = [[UINavigationController alloc]initWithRootViewController:addressView];
        addressNV.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        
        [self presentViewController:addressNV animated:YES completion:nil];
        

    }
    if (indexPath.row == 3) {
        
        [self gotoOpinionView];
    }
    if (indexPath.row == 5) {
        [self gotoInfoView];
    }
    if (indexPath.row ==7) {
        
        [self clear];
        
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

-(void)gotoOpinionView{
    
    OfferViewController *offerView = [[OfferViewController alloc]init];
    UINavigationController *offerNV = [[UINavigationController alloc]initWithRootViewController:offerView];
    
    [self presentViewController:offerNV animated:YES completion:nil];

    
    
    
}

-(void)gotoInfoView{
    
    AboutViewController *aboutView = [[AboutViewController alloc]init];
    UINavigationController *aboutNV = [[UINavigationController alloc]initWithRootViewController:aboutView];
    
    [self presentViewController:aboutNV animated:YES completion:nil];

    
    
}

-(void)clear{
    

    //计算缓存大小
    NSUInteger size = [[SDImageCache sharedImageCache] getSize];
    CGFloat cache = size / 1024.0 / 1024.0;
    //字符串
    NSString *str = [NSString stringWithFormat:@"%.2fM",cache];
    //初始化弹窗
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"清除缓存" message:str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alertView.tag = 102;
    //显示弹框
    [alertView show];
        

}


@end
