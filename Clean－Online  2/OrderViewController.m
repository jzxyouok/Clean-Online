//
//  OrderViewController.m
//  Dry-CleanOnline
//
//  Created by 李康 on 16/6/16.
//  Copyright © 2016年 李康. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderTableViewCell.h"
#import "OrderDetailViewController.h"
#import "sqlite.h"

@interface OrderViewController ()
@property(strong,nonatomic)UITableView *orderTable;

@property(strong,nonatomic) OrderTableViewCell *cell;

@property(strong,nonatomic) UISegmentedControl *segment;

@property(strong,nonatomic) NSMutableArray *list;
@end

@implementation OrderViewController{
    
    sqlite *sqliteData;
}
static NSString *CellTableIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    sqliteData=[sqlite sharedManager];
    self.navigationItem.title = @"订单概况";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bottombg.png"]];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
//    self.segment = [[UISegmentedControl alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    self.segment = [[UISegmentedControl alloc]initWithItems:@[@"处理中",@"已完成"]];
    self.segment.frame =CGRectMake(0, 64, self.view.frame.size.width, 50);
    
    self.segment.selectedSegmentIndex = 0;
    
    [self.view addSubview:self.segment];
    
    self.orderTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 114, self.view.frame.size.width, self.view.frame.size.height-114)];
    
    
    UINib * nib = [UINib nibWithNibName:@"OrderTableViewCell" bundle:nil];
    [self.orderTable registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
    
    
    self.orderTable.delegate = self;
    self.orderTable.dataSource=self;
    [self.view addSubview:self.orderTable];
    self.list = [sqliteData readDataFromOrder];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.list = [sqliteData readDataFromOrder];
    
    [self.orderTable reloadData];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableview delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.list count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier forIndexPath:indexPath];
    
    if (self.cell == nil) {
        
        self.cell= [[[NSBundle mainBundle]loadNibNamed:@"OrderTableViewCell" owner:nil options:nil] firstObject];
        
        
    }
    
    self.cell.orderNum.text = self.list[indexPath.row][@"time"];
    self.cell.orderMoney.text = self.list[indexPath.row][@"price"];
    self.cell.orderTime.text =self.list[indexPath.row][@"time"];
    self.cell.num =(int)indexPath.row;
    

    [self.cell.lookdetail addTarget:self action:@selector(presentDetail) forControlEvents:UIControlEventTouchUpInside];
    
    self.cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"listtxt.png"]];
    
    [self.cell.cancleBtn setTitle:@"取消订单" forState:UIControlStateNormal];
    
    
    
    
    return self.cell;
    
}

//订单详情跳转
-(void)presentDetail{
    
   
    
    OrderDetailViewController *detailview = [[OrderDetailViewController alloc]init];
    
    detailview.orderNu = self.list[self.cell.num][@"time"];
    detailview.orderTe = self.list[self.cell.num][@"phone"];
    detailview.orderNam = self.list[self.cell.num][@"name"];
    detailview.orderPric = self.list[self.cell.num][@"price"];
    detailview.OrderTim = self.list[self.cell.num][@"time"];
    detailview.orderAddres = self.list[self.cell.num][@"address"];
    
    NSLog(@"细节中的名字为%@",self.list[self.cell.num][@"name"]);

        UINavigationController *detailNV = [[UINavigationController alloc]initWithRootViewController:detailview];
        detailNV.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
        [self presentViewController:detailNV animated:YES completion:nil];
        

    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 200;
}
@end
