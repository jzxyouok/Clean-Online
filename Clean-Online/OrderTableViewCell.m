//
//  OrderTableViewCell.m
//  Dry-CleanOnline
//
//  Created by 李康 on 16/6/16.
//  Copyright © 2016年 李康. All rights reserved.
//

#import "OrderTableViewCell.h"
#import "OrderDetailViewController.h"

@implementation OrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//- (IBAction)detailPress:(id)sender {
//    
//    OrderDetailViewController *detailview = [[OrderDetailViewController alloc]init];
//   
//    UINavigationController *detailNV = [[UINavigationController alloc]initWithRootViewController:detailview];
//    detailNV.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    
//    [self presentViewController:detailNV animated:YES completion:nil];
//    
//    
//    
//    
//    NSLog(@"按了");
//}
//- (IBAction)canclePress:(id)sender {
//     NSLog(@"按了");
//}

@end
