//
//  AdressViewController.m
//  Dry-CleanOnline
//
//  Created by 李康 on 16/6/14.
//  Copyright © 2016年 李康. All rights reserved.
//

#import "AdressViewController.h"
#import "AdressTableViewCell.h"
#import "AddAdressViewController.h"
#import "sqlite.h"

@interface AdressViewController ()
@property (nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)AdressTableViewCell *cell;
@property(nonatomic,strong)UIButton *addDress;
@property(strong,nonatomic) NSMutableArray *adressList;
@property(strong,nonatomic) NSString *passAddress;


@end

@implementation AdressViewController{
    
     sqlite *sqliteData;
    
}

static NSString *CellTableIdentifier = @"AdressCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    sqliteData=[sqlite sharedManager];
    self.navigationItem.title = @"地址管理";
    [self.view setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"bgfirst.png"]]];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backbt.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backView)];
    
    [self.navigationItem setLeftBarButtonItem:back];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-114) style:UITableViewStylePlain];
    //self.tableview.backgroundColor = [UIColor redColor];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    self.addDress = [[UIButton alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width, 50)];
    [self.addDress setTitle:@"新增地址" forState:0];
    self.addDress.backgroundColor = [UIColor orangeColor];
    
    [self.addDress addTarget:self action:@selector(address) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.addDress];
    [self.view addSubview:self.tableview];
    self.adressList = [sqliteData readDataFromAdress];
    
    
    
  
}



-(void)address{
    
    AddAdressViewController *addView = [[AddAdressViewController alloc]init];
    UINavigationController *addNV = [[UINavigationController alloc]initWithRootViewController:addView];
    addNV.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController:addNV animated:YES completion:nil];

    
    
    
}
-(void)backView{
    
    NSDictionary * dataDict =[NSDictionary dictionaryWithObject:self.passAddress forKey:@"address"];
    //将通知贴到通知中心
    [[NSNotificationCenter defaultCenter]postNotificationName:@"passAddress" object:nil userInfo:dataDict];

    
    
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    
    [super viewWillAppear:animated];
    
     self.adressList = [sqliteData readDataFromAdress];
    
    
    for (int i = 0; i<[self.adressList count]; i++) {
        
       
        if ((int)self.adressList[i][@"defaultnum"]==785) {
        
            [self.adressList exchangeObjectAtIndex:i withObjectAtIndex:0];
            
                    }
        
        
    }

    
    
    
    [self.tableview reloadData];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableview delegate&datasource


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.adressList count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier
                 ];
    
    if (self.cell == nil) {
        
        self.cell= [[[NSBundle mainBundle]loadNibNamed:@"AdressTableViewCell" owner:nil options:nil] firstObject];
        
        //self.cell = [[AdressTableViewCell alloc]init];
    }
    if (indexPath.row == 0) {
        
        self.cell.backgroundColor = [UIColor grayColor];
    }
 
    self.cell.nameLabel.text = self.adressList[indexPath.row][@"name"];
    self.cell.telLabel.text =self.adressList[indexPath.row][@"phone"];
    self.cell.addressLabel.text = [NSString stringWithFormat:@"%@%@",self.adressList[indexPath.row][@"city"],self.adressList[indexPath.row][@"address"]];
    self.passAddress =[NSString stringWithFormat:@"%@%@",self.adressList[0][@"city"],self.adressList[0][@"address"]];
    self.cell.defaultnum = (int)self.adressList[indexPath.row][@"defaultnum"];
    
    
    
    return self.cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    [sqliteData deleteDataFromAdress:self.cell.name];
        if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.adressList removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source.
        [self.tableview deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        self.cell = [tableView cellForRowAtIndexPath:indexPath];

    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary * dataDict =[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row] forKey:@"index"];
    NSLog(@"即将传出的数据为 %@",[NSString stringWithFormat:@"%ld",(long)indexPath.row]);
    //将通知贴到通知中心
    [[NSNotificationCenter defaultCenter]postNotificationName:@"passIndex" object:nil userInfo:dataDict];
    
    
    
}


@end
