//
//  PieceTableViewCell.h
//  Dry-CleanOnline
//
//  Created by 李康 on 16/6/12.
//  Copyright © 2016年 李康. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Piece.h"

@interface PieceTableViewCell : UITableViewCell



@property (weak, nonatomic) IBOutlet UIImageView *ImageName;
@property (weak, nonatomic) IBOutlet UILabel *Name;
@property (weak, nonatomic) IBOutlet UILabel *chooseNum;

@property (assign, nonatomic) int time;//用于标记是否点击过
@property(assign,nonatomic) int num;

@end
