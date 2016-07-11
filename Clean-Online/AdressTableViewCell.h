//
//  AdressTableViewCell.h
//  Dry-CleanOnline
//
//  Created by 李康 on 16/6/14.
//  Copyright © 2016年 李康. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdressTableViewCell : UITableViewCell


@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSString *telnum;
@property(strong,nonatomic) NSString *address;
@property(assign,nonatomic) int defaultnum;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *telLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end
