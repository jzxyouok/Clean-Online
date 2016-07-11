//
//  sqlite.h
//  ios洗衣
//
//  Created by 李康 on 16/6/20.
//  Copyright © 2016年 李康. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface sqlite : NSObject
{
    sqlite3 *db;
    
}
+(sqlite *)sharedManager;
-(void)sqliteAddUser:(NSString *)PhoneName;
- (NSMutableArray *)readDataFromAdress;
-(NSMutableArray *)readDataFromOrder;
-(void)insertDataFromAdress:(NSString *)name withPhone:(NSString *)phone withCity:(NSString *)city withAddress:(NSString *)address withDefaultNum:(int)defaultnum;
-(void)insertDataFromOrder:(int)price withNum:(int)num withTime:(NSString *)time withName:(NSString *)name withPhone:(NSString *)phone withAddress:(NSString *)address withState:(int)state;
-(void)deleteDataFromAdress:(NSString *)name;
@end
