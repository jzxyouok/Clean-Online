//
//  AddAdressViewController.m
//  Dry-CleanOnline
//
//  Created by 李康 on 16/6/14.
//  Copyright © 2016年 李康. All rights reserved.
//

#import "AddAdressViewController.h"
#import "STPickerArea.h"
#import "sqlite.h"

@interface AddAdressViewController ()< STPickerAreaDelegate>

@property(strong,nonatomic) NSArray *list;//需要编辑的
@property(strong,nonatomic) UITableView *tableview;
@property (strong,nonatomic) NSMutableArray *array;

@property(strong,nonatomic) UITableViewCell *cell;
@property(strong,nonatomic) UITableViewCell *areaCell;


@property (nonatomic, strong) NSArray *Parray;
@property (nonatomic, strong) NSArray *CArray;
@property (nonatomic, strong) NSArray *Aarray;

@property(nonatomic,strong)UIButton *submitBtn;
@property(assign ,nonatomic)int signTag;

@property(strong,nonatomic)NSString *name;
@property(strong,nonatomic)NSString *city;
@property(strong,nonatomic)NSString *phone;
@property(strong,nonatomic)NSString *address;
@property(assign,nonatomic) int defaultnum;


@end

@implementation AddAdressViewController{
    
     sqlite *sqliteData;
}

//   声明静态字符串型对象，用来标记重用单元格
static NSString *TableSampleIdentifier = @"TableSampleIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    sqliteData=[sqlite sharedManager];
    self.defaultnum = 0;
    self.signTag = 0;

    
    self.navigationItem.title = @"添加地址";
    [self.view setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"bgfirst.png"]]];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backbt.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backView)];
    
    [self.navigationItem setLeftBarButtonItem:back];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 250) style:UITableViewStylePlain];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    self.submitBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width, 50)];
    [self.submitBtn setTitle:@"提交" forState:0];
    self.submitBtn.backgroundColor = [UIColor orangeColor];
    
    [self.submitBtn addTarget:self action:@selector(backView) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.submitBtn];
    
    

    [self.view addSubview:self.tableview];
    
    

    self.list = @[@"联系人姓名",@"手机号码",@"省、市、区",@"详细地址",@"是否设为默认地址"];
}


-(void)backView{
    
    //数据库的写入
    if (self.name!=nil&&self.phone !=nil && self.city !=nil && self.address != nil) {
        
    [sqliteData insertDataFromAdress:self.name withPhone:self.phone withCity:self.city withAddress:self.address withDefaultNum:self.defaultnum];
    }
    
    //NSLog(@"%@,%@,%@,%@",self.name,self.phone,self.city,self.address);
    
    NSDictionary * dataDict = [NSDictionary dictionaryWithObjectsAndKeys:self.name,@"name",
                               self.phone,@"phone",
                               [self.city stringByAppendingString:self.address],@"address",
                               [NSString stringWithFormat:@"%d",self.defaultnum],@"defaultnum",
                               nil];
   
   
    
    //将通知贴到通知中心
    [[NSNotificationCenter defaultCenter]postNotificationName:@"getAddress" object:nil userInfo:dataDict];
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.list count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    int time = 0;
    
    self.cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    
    if (self.cell == nil) {
        self.cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TableSampleIdentifier];
    }
    
    self.cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //设置标题
    
    if (indexPath.row == 2) {
        
        
        self.areaCell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
        
        if (self.areaCell == nil) {
            self.areaCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TableSampleIdentifier];
        }
        self.areaCell.textLabel.text = self.list[indexPath.row];
//        self.cell.textLabel.text = self.list[indexPath.row];
        //self.areaCell = self.cell;
        //[self.array addObject:self.cell];
        return self.areaCell;
        
    }
    if (indexPath.row == 4) {
        
        
        
        self.cell.textLabel.text = self.list[indexPath.row];
        
    
        [self.array addObject:self.cell];
        return self.cell;
        
    }else{
        //其余行 放入文本框 方便编辑
        UITextField *messageField = [[UITextField alloc]initWithFrame:CGRectMake(10, self.cell.frame.size.height*0.2, self.cell.frame.size.width*0.8, self.cell.frame.size.height*0.6)];
        
        messageField.placeholder =self.list[indexPath.row];
        messageField.tag = self.signTag;
        messageField.delegate = self;
    
        [self.cell addSubview:messageField];
        [self.array addObject:self.cell];
        
        
        
    }
    self.signTag++;
    
    
    
    
    return self.cell;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    if (textField.tag == 0) {
                self.name = textField.text;
        [textField resignFirstResponder];
            }if (textField.tag == 1) {
                self.phone = textField.text;
                [textField resignFirstResponder];
            }if (textField.tag == 2) {
                self.address = textField.text;
                [textField resignFirstResponder];
            }
          

    return YES;
    
}

//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    if (textField.tag == 0) {
//        self.name = string;
//    }if (textField.tag == 1) {
//        self.phone = string;
//    }if (textField.tag == 2) {
//        self.address = string;
//    }
//  
//    return YES;
//}

//用阴影效果代替选中和不选中的效果‘
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 4) {
        
        self.cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (self.cell.backgroundColor == [UIColor grayColor]) {
            
            self.defaultnum = 0;
            self.cell.backgroundColor = [UIColor whiteColor];
            
        }else{
            
        self.cell.backgroundColor = [UIColor grayColor];
            self.defaultnum = 1;
            
        }
    
        //[self.cell setHighlighted:YES animated:YES];
 
    }
    
    if (indexPath.row == 2) {
        
        STPickerArea *pickerArea = [[STPickerArea alloc]init];
        pickerArea.delegate = self;
        [pickerArea setContentMode:STPickerContentModeCenter];
        [pickerArea show];
  
    }
    
    
   
    
}
//改变地址时，cell的文字变为改变后的地址
- (void)pickerArea:(STPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area
{
    NSString *text = [NSString stringWithFormat:@"%@省 %@市 %@", province, city, area];
    NSLog(@"地址为%@",text);
    
    self.city = text;
    
    self.areaCell.textLabel.text = text;
}


@end
