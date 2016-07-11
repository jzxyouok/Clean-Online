//
//  registerViewController.m
//  Dry-CleanOnline
//
//  Created by 李康 on 16/6/12.
//  Copyright © 2016年 李康. All rights reserved.
//

#import "registerViewController.h"
#import "HomepageViewController.h"
#import "OrderViewController.h"
#import "MyViewController.h"
#import "sqlite.h"





#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface registerViewController ()

@property(nonatomic,strong) UIImageView *logo;
@property(nonatomic,strong) UITextField *registerName;
@property(nonatomic,strong) UITextField *registerpassword;




@end

@implementation registerViewController{
    
    sqlite *sqliteData;
    sqlite3 * sqliteUser;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    sqliteData=[sqlite sharedManager];
    
    UIImageView *backgroundImage = [[UIImageView alloc]initWithFrame:self.view.bounds];
    
    backgroundImage.image = [UIImage imageNamed:@"bgLogin.png"];
    
    [self.view addSubview:backgroundImage];
    
    //logo
    self.logo = [[UIImageView alloc]initWithFrame:CGRectMake(0.3*SCREEN_WIDTH, 0.15*SCREEN_HEIGHT, 150, 150)];
    self.logo.image = [UIImage imageNamed:@"LOGO.png"];
    [self.view addSubview:self.logo];
    self.logo.userInteractionEnabled = YES;
    self.logo.layer.cornerRadius = 75;
    
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                               action:@selector(alterHeadPortrait:)];
    
    //给imageView添加手势
    [self.logo addGestureRecognizer:singleTap];
    //手机号码输入框
    self.registerName = [[UITextField alloc]initWithFrame:CGRectMake(20, 0.42*SCREEN_HEIGHT, 230, 50)];
    self.registerName.background = [UIImage imageNamed:@"nm.png"];
    self.registerName.placeholder = @"请输入手机号码";
    [self.view addSubview: self.registerName];
    
    //验证码
    self.registerpassword = [[UITextField alloc]initWithFrame:CGRectMake(20, 0.55*SCREEN_HEIGHT, SCREEN_WIDTH-40, 50)];
    self.registerpassword.background = [UIImage imageNamed:@"yzinput.png"];
    self.registerpassword.placeholder = @"请输入验证码";
    [self.view addSubview: self.registerpassword];
    
    self.registerName.delegate = self;
    self.registerpassword.delegate = self;
    
    
    
    //验证码按钮
    UIButton *sendCode= [[UIButton alloc]initWithFrame:CGRectMake(270, 0.42*SCREEN_HEIGHT, SCREEN_WIDTH-290, 50)];
    
    [sendCode setBackgroundImage:[UIImage imageNamed:@"yzbt1.png"] forState:UIControlStateNormal];
    [sendCode setTitle:@"发送验证码" forState:UIControlStateNormal];
     sendCode.titleLabel.font = [UIFont systemFontOfSize:15];//title字体大小
    [sendCode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//设置title在一般情况下为白色字体
   [sendCode setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];//设置title在button被选中情况下为灰色字体
    
   
    
    [self.view addSubview:sendCode];
    
    
    //注册按钮
    UIButton *registerbtn= [[UIButton alloc]initWithFrame:CGRectMake(20, 0.7*SCREEN_HEIGHT, SCREEN_WIDTH-40, 50)];
    [registerbtn setBackgroundImage:[UIImage imageNamed:@"zcbt1.png"] forState:UIControlStateNormal];
    [registerbtn setTitle:@"注册" forState:UIControlStateNormal];
    registerbtn.titleLabel.font = [UIFont systemFontOfSize:15];//title字体大小
    [registerbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//设置title在一般情况下为白色字体
    [registerbtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];//设置title在button被选中情况下为灰色字体
    [self.view addSubview:registerbtn];
    
    
    [sendCode addTarget:self action:@selector(SendMessage) forControlEvents:UIControlEventTouchUpInside];
    [registerbtn addTarget:self action:@selector(mainView) forControlEvents:UIControlEventTouchUpInside];
  
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}
-(void)alterHeadPortrait:(UITapGestureRecognizer *)gesture{
    /**
     *  弹出提示框
     */
    //初始化提示框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //按钮：从相册选择，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //初始化UIImagePickerController
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        //获取方式1：通过相册（呈现全部相册），UIImagePickerControllerSourceTypePhotoLibrary
        //获取方式2，通过相机，UIImagePickerControllerSourceTypeCamera
        //获取方法3，通过相册（呈现全部图片），UIImagePickerControllerSourceTypeSavedPhotosAlbum
        PickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //允许编辑，即放大裁剪
        
        PickerImage.allowsEditing = YES;
        //自代理
        PickerImage.delegate = self;
        //页面跳转
        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];
    //按钮：拍照，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        /**
         其实和从相册选择一样，只是获取方式不同，前面是通过相册，而现在，我们要通过相机的方式
         */
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        //获取方式:通过相机
        PickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
        PickerImage.allowsEditing = YES;
        PickerImage.delegate = self;
        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];
    //按钮：取消，类型：UIAlertActionStyleCancel
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}
//PickerImage完成后的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //定义一个newPhoto，用来存放我们选择的图片。
    
    UIImageView *newlogo = [[UIImageView alloc]init];
    newlogo.image =[info objectForKey:@"UIImagePickerControllerEditedImage"];

   // UIImage *newPhoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    newlogo.layer.cornerRadius = 75;
    
    self.logo.image = newlogo.image;
    NSLog(@"图片更换完成");
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)SendMessage{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"您的验证码为" message:@"123" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];

    //显示弹框
    [alertView show];
    

    
}


-(void)mainView{//注册跳转主页面
    
    NSLog(@" zhuceming wei %@",self.registerName.text);
    
    if ([self.registerName.text isEqualToString:@""]) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"您的用户名不正确" message:@"请先注册登陆" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        
        //显示弹框
        [alertView show];
        
    }else{

    
    HomepageViewController *homepage = [[HomepageViewController alloc]initWithNibName:nil bundle:nil];
    
    UINavigationController *homepageNav = [[UINavigationController alloc] initWithRootViewController:homepage];
    
    
    
    OrderViewController *order = [[OrderViewController alloc]initWithNibName:nil bundle:nil];
    UINavigationController *orderNav = [[UINavigationController alloc] initWithRootViewController:order];
    
    MyViewController *my = [[MyViewController alloc]init];
    UINavigationController *myNav = [[UINavigationController alloc] initWithRootViewController:my];
    
    //创建UITabBarController
    UITabBarController *tabBarController = [[UITabBarController alloc]init];
    //设置viewControllers
    tabBarController.viewControllers = @[homepageNav,orderNav,myNav];
    //tabBarController.tabBar.translucent = NO;
    
    tabBarController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    homepageNav.tabBarItem.title =@"首页";
    homepageNav.tabBarItem.image = [UIImage imageNamed:@"indexbt2.png"];
    orderNav.tabBarItem.title = @"订单";
    orderNav.tabBarItem.image = [UIImage imageNamed:@"ddbt2.png"];
    myNav.tabBarItem.title = @"我的";
    myNav.tabBarItem.image = [UIImage imageNamed:@"my2.png"];
    
    UIView * mView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];//整个tabbar的颜色
    [mView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bottombg.png"]]];
    [tabBarController.tabBar insertSubview:mView atIndex:0];
    tabBarController.tabBar.tintColor = [UIColor whiteColor];//选中之后的颜色
    
    //添加数据库
    
    [sqliteData sqliteAddUser:self.registerName.text];
    
    
    [self presentViewController:tabBarController animated:YES completion:nil];
    }

    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
