//
//  PieceTableViewCell.m
//  Dry-CleanOnline
//
//  Created by 李康 on 16/6/12.
//  Copyright © 2016年 李康. All rights reserved.
//

#import "PieceTableViewCell.h"

@implementation PieceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)addNum:(id)sender {
    
    
    
    self.num+=1;
    
    self.chooseNum.text = [NSString stringWithFormat:@"%d",self.num];
    NSDictionary * dataDict = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%d",self.num] forKey:@"addnum"];
    //将通知贴到通知中心
    [[NSNotificationCenter defaultCenter]postNotificationName:@"Notification1" object:nil userInfo:dataDict];
    
    
    
}
- (IBAction)reduceNum:(id)sender {
    self.num -=1;
    if (self.num<0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"⚠️提示⚠️" message:@"物品数量不能少于0个"delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
          [alert show];
    }else{
    self.chooseNum.text = [NSString stringWithFormat:@"%d",self.num];

    NSDictionary * dataDict = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%d",self.num] forKey:@"reducenum"];
    //将通知贴到通知中心
    [[NSNotificationCenter defaultCenter]postNotificationName:@"Notification2" object:nil userInfo:dataDict];
    }
    
}





@end
