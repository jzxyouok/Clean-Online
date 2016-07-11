//
//  OrderTableViewCell.h
//  Dry-CleanOnline
//
//  Created by 李康 on 16/6/16.
//  Copyright © 2016年 李康. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderNum;
@property (weak, nonatomic) IBOutlet UILabel *orderMoney;
@property (weak, nonatomic) IBOutlet UILabel *orderTime;
@property (weak, nonatomic) IBOutlet UILabel *orderStatus;
@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;
@property (weak, nonatomic) IBOutlet UIButton *lookdetail;
@property(assign,nonatomic)int num;//存储单元格中的index

@end
