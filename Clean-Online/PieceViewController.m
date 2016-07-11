//
//  PieceViewController.m
//  Dry-CleanOnline
//
//  Created by 李康 on 16/6/12.
//  Copyright © 2016年 李康. All rights reserved.
//

#import "PieceViewController.h"
#import "BuyViewController.h"
#import "PieceTableViewCell.h"
@interface PieceViewController ()
@property (strong, nonatomic) UIScrollView *screenView;
@property (strong, nonatomic) UIScrollView *statusScr;//状态栏的两个蓝条

@property(strong,nonatomic)UITableView *pieceTable1;//上装的tb
@property(strong,nonatomic)UITableView *pieceTable2;//下装的tb

@property (strong,nonatomic) NSMutableArray *array;
@property(strong,nonatomic)  PieceTableViewCell *cell;
@property (weak, nonatomic) IBOutlet UILabel *PickNum;//用于计算总价

@property(strong,nonatomic) UIView *statusView1;
@property(strong,nonatomic) UIView *statusView2;


@property(strong,nonatomic) NSMutableArray *clothes;
@property(strong,nonatomic) NSMutableArray *trousers;
@property(assign,nonatomic) int times;


@property(assign,nonatomic) int tmpNum;

@end

@implementation PieceViewController

static NSString *CellTableIdentifier = @"PieceCell";


- (IBAction)closeBtn:(id)sender {
    self.screenView.contentOffset = CGPointMake(self.pieceTable1.frame.origin.x, 0);
    
    self.statusScr.contentOffset = CGPointMake(0, 0);
}
- (IBAction)trouserBtn:(id)sender {
    
    
    self.screenView.contentOffset = CGPointMake(self.pieceTable2.frame.origin.x, 0);
    
    self.statusScr.contentOffset = CGPointMake(self.statusScr.contentSize.width/2, 0);

    
    
   
}


#pragma mark - scrollview delegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{//关联两个scr
    
    if (scrollView.tag == 101) {
        
        CGPoint offset = scrollView.contentOffset;
        
        self.statusScr.contentOffset = offset;
        
    }else{
        
        return;
    }
    
    
    
}





- (void)viewDidLoad {
    [super viewDidLoad];
    self.times = 100;
    [self.view setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"bgfirst.png"]]];

    self.navigationItem.title = @"按件计费";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backbt.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backView)];
    
    [self.navigationItem setLeftBarButtonItem:back];
   
    self.array = [[NSMutableArray alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"piece" ofType:@"plist"]];
    
    [self createMainScrollView];
   
    
    
    
    
   
    
}
-(void)backView{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
    
}

- (void)createMainScrollView {
    
    //screenView的位置摆放
    self.screenView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0.09*self.view.frame.size.height+40, self.view.frame.size.width, 0.9*self.view.frame.size.height-5)];
    NSLog(@"%f",0.09*self.view.frame.size.height);
    self.screenView.contentSize= CGSizeMake(self.view.frame.size.width * 2, self.screenView.frame.size.height);
    self.screenView.pagingEnabled = YES;
    self.screenView.tag = 101;
    
    
    self.screenView.showsHorizontalScrollIndicator = NO;
    self.screenView.delegate = self;
    
     self.statusScr = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0.09*self.view.frame.size.height+35, self.view.frame.size.width, 5)];
    
    self.statusScr.contentSize= CGSizeMake(self.view.frame.size.width * 2, 5);
   
    self.statusScr.showsHorizontalScrollIndicator = NO;
    self.statusScr.pagingEnabled = YES;
    
    
    self.statusView1 = [[UIView alloc]initWithFrame:CGRectMake(50, self.statusScr.bounds.origin.y, 100, 5)];
    self.statusView1.backgroundColor = [UIColor blueColor];
    [self.statusScr addSubview:self.statusView1];
    
    self.statusView2 = [[UIView alloc]initWithFrame:CGRectMake(230+self.view.frame.size.width, self.statusScr.bounds.origin.y, 100, 5)];
    self.statusView2.backgroundColor = [UIColor blueColor];
    [self.statusScr addSubview:self.statusView2];

    

    self.pieceTable1 = [[UITableView alloc]initWithFrame:CGRectMake(0, self.screenView.bounds.origin.y, [UIScreen mainScreen].bounds.size.width, self.screenView.frame.size.height-30) style:UITableViewStylePlain];
    self.pieceTable1.tag = 101;//用于分辨代理方法
    
    UINib * nib = [UINib nibWithNibName:@"PieceTableViewCell" bundle:nil];
    [self.pieceTable1 registerNib:nib forCellReuseIdentifier:CellTableIdentifier];

    
    
    self.pieceTable2 = [[UITableView alloc]initWithFrame:CGRectMake(self.view.frame.size.width, self.screenView.bounds.origin.y, [UIScreen mainScreen].bounds.size.width, self.screenView.frame.size.height-30) style:UITableViewStylePlain];
    
    self.pieceTable2.tag = 202;
     nib = [UINib nibWithNibName:@"PieceTableViewCell" bundle:nil];
    [self.pieceTable2 registerNib:nib forCellReuseIdentifier:CellTableIdentifier];

    // 设置代理
    
    self.pieceTable1.delegate=self;
    
    self.pieceTable2.delegate = self;
    self.pieceTable2.dataSource = self;
    self.pieceTable1.dataSource = self;
    
    [self.screenView addSubview:self.pieceTable1];
    [self.screenView addSubview:self.pieceTable2];
    [self.view addSubview: self.screenView];
    
    self.clothes = [[NSMutableArray alloc]init];
     self.trousers = [[NSMutableArray alloc]init];
    
    [self.view addSubview: self.statusScr];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView.tag == 101) {
        return [self.array[0] count];
    }if (tableView.tag == 202) {
    
        return [self.array[1] count];
    }else
        return 0;
    
 
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    self.cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier forIndexPath:indexPath];
    
    if (self.cell == nil) {
        
        self.cell= [[[NSBundle mainBundle]loadNibNamed:@"PieceTableViewCell" owner:nil options:nil] firstObject];
        
        //self.cell = [[PieceTableViewCell alloc]init];
    }
    if (tableView.tag == 101) {
       
        
        self.cell.ImageName.image = [UIImage imageNamed:[self.array[0][indexPath.row] objectForKey:@"image"]];
        
        self.cell.Name.text = [self.array[0][indexPath.row] objectForKey:@"name"];
        self.cell.chooseNum.text = @"0";
       
        self.cell.time = (int)indexPath.row;
    
        self.tmpNum +=self.cell.chooseNum.text.intValue;
        
        
        // 放入数组，方便点击时调用
        [self.clothes addObject:self.cell];
    }
    else{
        
        
        self.cell.ImageName.image = [UIImage imageNamed:[self.array[1][indexPath.row] objectForKey:@"image"]];
        
        self.cell.Name.text = [self.array[1][indexPath.row] objectForKey:@"name"];
        self.cell.chooseNum.text = @"0";
       
         self.cell.time = (int)indexPath.row;

         self.tmpNum +=self.cell.chooseNum.text.intValue;
       
        [self.trousers addObject:self.cell];

    }
    
    
    return self.cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == 101){
        
    
        self.times = (int)indexPath.row;
        
        self.cell =self.clothes[indexPath.row];
        
        if (self.times ==self.cell.time&&self.cell.num == 0 ) {
            
        
            self.cell.num = 1;
            
            self.cell.chooseNum.text = @"1";
            
            self.tmpNum+=10;
            
            NSString *tmp = @"总价:¥";
            self.PickNum.text =[tmp stringByAppendingString:[NSString stringWithFormat:@"%d",self.tmpNum]];
            
            
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            
            self.cell.time = 100;

        }
    }
    
    if (tableView.tag == 202){
        
        
        self.times = (int)indexPath.row;
        
        self.cell =self.trousers[indexPath.row];
        
        if (self.times ==self.cell.time&&self.cell.num == 0 ) {
            
            
            self.cell.num = 1;
            
            self.cell.chooseNum.text = @"1";
            
            self.tmpNum+=10;
            
            NSString *tmp = @"总价:¥";
            self.PickNum.text =[tmp stringByAppendingString:[NSString stringWithFormat:@"%d",self.tmpNum]];
            
            
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            
            self.cell.time = 100;
            
        }
    }


}

-(void)viewDidAppear:(BOOL)animated{//接受通知
    
    
    [super viewDidAppear:animated];
    
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addchange:) name:@"Notification1" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reducechange:) name:@"Notification2" object:nil];
    
}

-(void)addchange:(NSNotification *)notification{//数量增加
    
    self.tmpNum+=10;
    
      NSString *tmp = @"总价:¥";
    self.PickNum.text =[tmp stringByAppendingString:[NSString stringWithFormat:@"%d",self.tmpNum]];
    
}
- (IBAction)OrderBtn:(id)sender {
    //提交订单
//    if (self.tmpNum == 0) {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"⚠️提示⚠️" message:@"您未选取商品，无法提交"delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
//        [alert show];
//        
//    }else{
    
    BuyViewController *buyView = [[BuyViewController alloc]init];
    UINavigationController *buyNV = [[UINavigationController alloc]initWithRootViewController:buyView];
    buyNV.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
     
//    NSDictionary * dataDict = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%d",self.tmpNum] forKey:@"picknum"];
//        NSLog(@"选中的商品为%d",self.tmpNum);
//        //将通知贴到通知中心
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"getNumgggg" object:nil userInfo:dataDict];

    

    buyView.price=self.tmpNum;
    [self presentViewController:buyNV animated:YES completion:nil];
//    }

}


-(void)reducechange:(NSNotification *)notification{//数量减少
    
    self.tmpNum-=10;
    
    NSString *tmp = @"总价:¥";
    self.PickNum.text =[tmp stringByAppendingString:[NSString stringWithFormat:@"%d",self.tmpNum]];
    
    
}
@end
