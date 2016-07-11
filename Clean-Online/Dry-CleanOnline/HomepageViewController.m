//
//  HomepageViewController.m
//  Dry-CleanOnline
//
//  Created by 李康 on 16/6/12.
//  Copyright © 2016年 李康. All rights reserved.
//

#import "HomepageViewController.h"
#import "XRCarouselView.h"
#import "PieceViewController.h"
#import "PocketViewController.h"
#import "WaterPushViewController.h"


@interface HomepageViewController ()

@property(nonatomic,strong)XRCarouselView *AdView;

@end

@implementation HomepageViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"bgfirst.png"]]];
   // self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"bgfirst.png"]];

    self.navigationItem.title = @"洗 e 洗";//title
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bottombg.png"]];
    
    self.AdView = [self loadSelfXRCarouselView];
    [self.view addSubview:self.AdView];
   
    //瀑布流视图
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_nav_collection"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(changeList)];

    //NSLog(@"%f",self.view.frame.size.width);


   
    
    
    
    // Do any additional setup after loading the view from its nib.
}

-(void)changeList{
    
    //瀑布流展示
    WaterPushViewController *waterView = [[WaterPushViewController alloc]init];
    UINavigationController *waterNV = [[UINavigationController alloc]initWithRootViewController:waterView];
    
    [self presentViewController:waterNV animated:YES completion:nil];
    
    
    
}


-(XRCarouselView *)loadSelfXRCarouselView{//图片轮播
    
    NSArray *ADimage = @[[UIImage imageNamed:@"1.jpg"],[UIImage imageNamed:@"2.jpg"],[UIImage imageNamed:@"3.jpg"],[UIImage imageNamed:@"4.jpg"],[UIImage imageNamed:@"5.jpg"]];
    
    XRCarouselView *carouselView = [[XRCarouselView alloc]init];
    carouselView.imageArray = ADimage;
    [carouselView setPageColor:[UIColor whiteColor] andCurrentPageColor:[UIColor blueColor]];
    carouselView.frame = CGRectMake(0, 50, 400, 300);
    return carouselView;
  
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)Piecebtn:(id)sender {//按件洗
    
    PieceViewController *pieceView = [[PieceViewController alloc]init];
    UINavigationController *pieceNV = [[UINavigationController alloc]initWithRootViewController:pieceView];
    
    [self presentViewController:pieceNV animated:YES completion:nil];
    
    
    
}
- (IBAction)Pocketbtn:(id)sender {
    
    PocketViewController *pocketView = [[PocketViewController alloc]init];
    UINavigationController *pocketNV = [[UINavigationController alloc]initWithRootViewController:pocketView];
    
    [self presentViewController:pocketNV animated:YES completion:nil];
    
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
