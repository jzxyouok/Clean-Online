//
//  AboutViewController.m
//  Dry-CleanOnline
//
//  Created by 李康 on 16/6/13.
//  Copyright © 2016年 李康. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@property(strong,nonatomic) UITableView *tableview;
@property(strong,nonatomic) NSArray * list;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"bgfirst.png"]]];

    // Do any additional setup after loading the view.
    self.navigationItem.title = @"关于洗e洗";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backbt.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backView)];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bottombg.png"]];
    [self.navigationItem setLeftBarButtonItem:back];
    
    
    UIImageView *logo = [[UIImageView alloc]initWithFrame:CGRectMake(0.4*self.view.frame.size.width, 0.2*self.view.frame.size.height, 70, 70)];
    logo.image = [UIImage imageNamed:@"LOGO"];
    
    [self.view addSubview:logo];
    
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.41*self.view.frame.size.width, 0.33*self.view.frame.size.height, 70, 20)];
    nameLabel.text = @"洗e洗";
    nameLabel.font = [UIFont systemFontOfSize:25];
    [self.view addSubview:nameLabel];
    
    UILabel *nameLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0.443*self.view.frame.size.width, 0.38*self.view.frame.size.height, 70, 20)];
    nameLabel2.text = @"2.0版";
    nameLabel2.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:nameLabel2];
    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0.5*self.view.frame.size.height, self.view.frame.size.width, 150) style:UITableViewStylePlain];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    //把tabView添加到视图之上
    [self.view addSubview:self.tableview];
    
    
    
    self.list = @[@"喜欢我们，打分鼓励",@"分享给朋友",@"合作商户"];
    
    
    UIView *info = [[UIView alloc]initWithFrame:CGRectMake(0.25*self.view.frame.size.width, 0.8*self.view.frame.size.height, 0.5*self.view.frame.size.width, 0.1*self.view.frame.size.height)];
    
    
    UILabel *urlLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.15*info.frame.size.width, 0, 0.8*info.frame.size.width, 0.42*info.frame.size.height)];
    urlLabel.text = @"www.123456.com";
    [info addSubview:urlLabel];
    UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(info.frame.size.width/3,0.5*info.frame.size.height,info.frame.size.width/3, 0.4*info.frame.size.height)];
    [btn1 setTitle:@"服务条款｜" forState:UIControlStateNormal];
    btn1.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIButton *btn2=[[UIButton alloc]initWithFrame:CGRectMake(0,0.5*info.frame.size.height,info.frame.size.width/3, 0.42*info.frame.size.height)];
    [btn2 setTitle:@"免责声明｜" forState:UIControlStateNormal];
    UIButton *btn3=[[UIButton alloc]initWithFrame:CGRectMake(info.frame.size.width*2/3,0.5*info.frame.size.height,info.frame.size.width/3, 0.42*info.frame.size.height)];
    [btn3 setTitle:@"联系我们" forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont systemFontOfSize:12];
    btn3.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [info addSubview:btn1];
     [info addSubview:btn2];
     [info addSubview:btn3];
  
    [self.view addSubview:info];
    
    
    

}



-(void)backView{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.list count];
    
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
    cell.textLabel.text = self.list[indexPath.row];
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        NSURL * url = [NSURL URLWithString:@"https://itunes.apple.com/app/id"];
        [[UIApplication sharedApplication]openURL:url];
        
    }
    if (indexPath.row == 1) {
        
        NSString *textToShare = @"洗e洗 - 请在 App Store 中搜索「在线洗衣」";
        UIImage *imageToShare = [UIImage imageNamed:@"LOGO.png"];
        NSURL *urlToShare = [NSURL URLWithString:@"https://itunes.apple.com/app/id"];
        NSArray *activityItems = @[textToShare,imageToShare,urlToShare];
        //创建UIActivityViewController对象，并将数值放进去
        UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
        //定义不出现在活动的项目
        activityVC.excludedActivityTypes = @[UIActivityTypePrint,UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
        if ( [activityVC respondsToSelector:@selector(popoverPresentationController)] ) {
            activityVC.popoverPresentationController.sourceView = self.view;
        }
        //执行
        [self presentViewController:activityVC animated:true completion:nil];
    }
    
    if (indexPath.row == 2) {
        
        UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"邮件联系" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancle2=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil];
        
        UIAlertAction *cancle1=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"mailto://515867764@qq.com"]];
        }];
        [controller addAction:cancle1];
        [controller addAction:cancle2];
        [self presentViewController:controller animated:YES completion:nil];
       
        
    }
    
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
