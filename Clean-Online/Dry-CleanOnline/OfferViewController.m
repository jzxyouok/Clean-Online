//
//  OfferViewController.m
//  Dry-CleanOnline
//
//  Created by 李康 on 16/6/13.
//  Copyright © 2016年 李康. All rights reserved.
//

#import "OfferViewController.h"

@interface OfferViewController ()
@property(nonatomic,strong) UITextField *textField ;

@end

@implementation OfferViewController{
    
    BOOL keyboardVisible;
    float y;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.view setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"bgfirst.png"]]];
    
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"意见反馈";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backbt.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backView)];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bottombg.png"]];
    [self.navigationItem setLeftBarButtonItem:back];

    
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0.2*self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height*0.25)];
    view1.backgroundColor = [UIColor whiteColor];
    
    
    
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0.5*self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height*0.25)];
    view2.backgroundColor = [UIColor whiteColor];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 0.8*view1.frame.size.width, 20)];
    label1.text = @"洗e洗给您的服务体验:";
    
    [view1 addSubview:label1];
    
    UIButton *happyBt = [[UIButton alloc]initWithFrame:CGRectMake(0.35*view1.frame.size.width, 0.25*view1.frame.size.height, 100, 45)];
    happyBt.imageView.image = [UIImage imageNamed:@"feedbackbut1.png"];
    happyBt.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"feedbackbut1.png"]];
    [happyBt setTitle:@"爽" forState:UIControlStateNormal];
    happyBt.layer.cornerRadius = 10.0;
    [view1 addSubview:happyBt];
    
    UIButton *sadBt = [[UIButton alloc]initWithFrame:CGRectMake(0.35*view1.frame.size.width, 0.6*view1.frame.size.height, 100, 45)];
    sadBt.backgroundColor = [UIColor grayColor];
    [sadBt setTitle:@"不爽" forState:UIControlStateNormal];
    sadBt.layer.cornerRadius = 10.0;
    [view1 addSubview:sadBt];
    
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 0.8*view1.frame.size.width, 20)];
    label2.text = @"请留下对我们提示服务的意见和建议:";
    [view2 addSubview:label2];
    
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(0.1*view2.frame.size.width, 0.25*view2.frame.size.height, view2.frame.size.width*0.8, view2.frame.size.height*0.65)];
    self.textField.backgroundColor = [UIColor grayColor];
    self.textField.layer.borderColor = [UIColor blackColor].CGColor;
    [view2 addSubview:self.textField];
    
    
    
    
    
     [self.view addSubview:view1];
    [self.view addSubview:view2];
    
    
    
    
    
    
}

-(void)backView{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //添加观察者
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    
    
}

-(void)keyboardDidHide:(NSNotification *)notif
{
//    NSDictionary * info = [notif userInfo];
//    NSValue * aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
//    //CGSize keyboardSize = [aValue CGRectValue].size;
    
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    

    
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.textField resignFirstResponder];
    return YES;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.textField resignFirstResponder];
    
}





-(void)keyboardDidShow:(NSNotification *)notif
{
       //得到键盘尺寸
    NSDictionary * info = [notif userInfo];
    NSValue * aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [aValue CGRectValue].size;
    
    self.view.frame = CGRectMake(0, -keyboardSize.height, self.view.frame.size.width, self.view.frame.size.height);
    
    
    
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
