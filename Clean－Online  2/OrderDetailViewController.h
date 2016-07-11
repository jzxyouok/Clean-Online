//
//  OrderDetailViewController.h
//  washingOnline
//
//  Created by 李康 on 16/6/17.
//  Copyright © 2016年 李康. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *orderNum;
@property (weak, nonatomic) IBOutlet UILabel *orderPrice;
@property (weak, nonatomic) IBOutlet UILabel *OrderTime;

@property (weak, nonatomic) IBOutlet UILabel *orderName;

@property (weak, nonatomic) IBOutlet UILabel *orderAddress;
@property (weak, nonatomic) IBOutlet UILabel *orderTel;
//上面的是label  下面的是上一页传过来的值

@property (strong, nonatomic) NSString *orderNu;
@property (strong, nonatomic) NSString *orderPric;
@property (strong, nonatomic) NSString *OrderTim;
@property (strong, nonatomic) NSString *orderNam;
@property (strong, nonatomic) NSString *orderAddres;
@property (strong, nonatomic) NSString *orderTe;





@end
