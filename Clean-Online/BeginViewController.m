//
//  BeginViewController.m
//  Dry-CleanOnline
//
//  Created by 李康 on 16/6/23.
//  Copyright © 2016年 李康. All rights reserved.
//

#import "BeginViewController.h"
#import "registerViewController.h"



@interface BeginViewController ()
@property ( strong, nonatomic)  UIScrollView *scrollView;

@property (strong, nonatomic)  UIPageControl *pageControl;
@property(strong,nonatomic)UIView *p1;
@property(strong,nonatomic)UIView *p2;
@property(strong,nonatomic)UIView *p3;


@end

@implementation BeginViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addView];
}


-(void)addView{
    
    self.scrollView = [[UIScrollView alloc]init];
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width*3,self.scrollView.frame.size.height);
    self.scrollView.frame = CGRectMake(0, 0,self.view.frame.size.width , self.view.frame.size.height-50);
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width, 50)];
    self.scrollView.delegate =self;
    [self.pageControl addTarget:self action:@selector(changePage) forControlEvents:UIControlEventValueChanged];
    [self.pageControl setNumberOfPages:3];
    self.pageControl.currentPage = 0;
    self.pageControl.backgroundColor = [UIColor redColor];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    self.p1 = [[UIView alloc]init];
    self.p2 = [[UIView alloc]init];
    self.p3 = [[UIView alloc]init];
    
    self.p1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    self.p2.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];

    self.p3.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];

    UIButton *but = [[UIButton alloc]initWithFrame:CGRectMake(200, 200, 100, 50)];
    
    [but setTitle:@"Skip Now" forState:UIControlStateNormal];
    [but addTarget:self action:@selector(regist) forControlEvents:UIControlEventAllEvents];
    
    [self.p3 addSubview:but];
    
    
    
    self.p1.frame=CGRectMake(0.0, 0.0, self.view.frame.size.width, self.scrollView.frame.size.height);
    self.p2.frame=CGRectMake(self.view.frame.size.width, 0.0, self.view.frame.size.width, self.scrollView.frame.size.height);
    self.p3.frame=CGRectMake(self.view.frame.size.width*2, 0.0, self.view.frame.size.width, self.scrollView.frame.size.height);
    
    [self.scrollView addSubview:self.p1];
    [self.scrollView addSubview:self.p2];
    [self.scrollView addSubview:self.p3];

    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.pageControl];
    
    
    
    
    
    
    
    
}

-(void)regist{
    
    registerViewController *regisView = [[registerViewController alloc]init];
    
    [self presentViewController:regisView animated:YES completion:nil];

    
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //滚动的偏移量
    CGPoint offset = scrollView.contentOffset;
    //设定页面控件的当前页
    self.pageControl.currentPage = offset.x/(self.view.frame.size.width);
    
    
}

- (void)changePage {
    [UIView animateWithDuration:0.5 animations:^{
        NSInteger page = self.pageControl.currentPage;
        self.scrollView.contentOffset = CGPointMake(self.view.frame.size.width*page, 0.0);
    }];
    
    
    
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
