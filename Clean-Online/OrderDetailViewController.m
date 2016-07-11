//
//  OrderDetailViewController.m
//  washingOnline
//
//  Created by 李康 on 16/6/17.
//  Copyright © 2016年 李康. All rights reserved.
//

#import "OrderDetailViewController.h"

@interface OrderDetailViewController ()



@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backbt.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backView)];
    [self.navigationItem setLeftBarButtonItem:back];
    
    
    
    // 用上一级传下来的值 写页面 
    self.orderNum.text = self.orderNu;
    
    self.orderPrice.text = self.orderPric;
    
    self.OrderTime.text = self.OrderTim;
    
    self.orderName.text = self.orderNam;
    
    self.orderAddress.text = self.orderAddres;
    
    self.orderTel.text = self.orderTe;
    
    
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
