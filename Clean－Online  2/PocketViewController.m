//
//  PocketViewController.m
//  Dry-CleanOnline
//
//  Created by 李康 on 16/6/16.
//  Copyright © 2016年 李康. All rights reserved.
//

#import "PocketViewController.h"
#import "BuyViewController.h"

@interface PocketViewController ()
@property(strong,nonatomic) UIButton *submitBtn;

@end

@implementation PocketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"bgfirst.png"]]];
    
    self.navigationItem.title = @"按袋计费";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backbt.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backView)];
    
    [self.navigationItem setLeftBarButtonItem:back];
    
    self.submitBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width, 50)];
    [self.submitBtn setTitle:@"一键下单" forState:0];
    self.submitBtn.backgroundColor = [UIColor orangeColor];
    
    [self.submitBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.submitBtn];
    
    
    
    UIImageView *backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0,64, self.view.frame.size.width, self.view.frame.size.height-50)];
    backImg.image = [UIImage imageNamed:@"背景"];
    
    [self.view addSubview:backImg];


}

-(void)submit{
    
    BuyViewController *buyView = [[BuyViewController alloc]init];
    UINavigationController *buyNV = [[UINavigationController alloc]initWithRootViewController:buyView];
    buyNV.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController:buyNV animated:YES completion:nil];
    
    
}


-(void)backView{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
    
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

@end
