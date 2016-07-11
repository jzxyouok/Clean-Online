//
//  sqlite.m
//  ios洗衣
//
//  Created by 李康 on 16/6/20.
//  Copyright © 2016年 李康. All rights reserved.
//

#import "sqlite.h"

@implementation sqlite

+(sqlite *)sharedManager
{
    static sqlite *sqlite=nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sqlite = [[self alloc] init];
        [sqlite createSqlite3];
        
    });
    return sqlite;
}
-(void)createSqlite3
{
    if (sqlite3_open([[self dataFilePathUser]UTF8String], &db) != SQLITE_OK) {
        
        sqlite3_close(db);
        NSAssert(0, @"Failed to open sqliteUser");
        
    }
    
    //创建表的sql语句，表名称为fields，字段row，整数，主键。field_data，文本类型
    NSString * createSQLUser = @"CREATE TABLE IF NOT EXISTS USERFIELDS(ID INTEGER PRIMARY KEY, NAME TEXT,PASSWORD TEXT)";
    NSString * createSQLAddress = @"CREATE TABLE IF NOT EXISTS ADDRESSFIELDS(ID INTEGER PRIMARY KEY, NAME TEXT,PHONE TEXT,CITY TEXT,ADDRESS TEXT,DEFAULTNUM INTEGER)";
    NSString * createSQLOrder = @"CREATE TABLE IF NOT EXISTS ORDERR(ID INTEGER PRIMARY KEY, PRICE INTEGER,NUM INTEGER,TIME TEXT,NAME TEXT,PHONE TEXT,ADDRESS TEXT,STATE INTEGER)";
    char * errorMsg;
    
    
    
    
    //执行创建表的sql语句
    if (sqlite3_exec(db, [createSQLUser UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK ) {
        
        sqlite3_close(db);
        NSAssert(0, @"error creating table sqliteUser: %s ",errorMsg);
        
        
    }
    if (sqlite3_exec(db, [createSQLAddress UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK ) {
        
        sqlite3_close(db);
        NSAssert(0, @"error creating table sqliteUser: %s ",errorMsg);
        
        
    }
    

    
    if (sqlite3_exec(db, [createSQLOrder UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK ) {
        
        sqlite3_close(db);
        
        
        
        
        NSAssert(0, @"error creating table sqliteOrder: %s ",errorMsg);
        
        
    }

}

-(void)sqliteAddUser:(NSString *)PhoneName
{
    if (sqlite3_open([[self dataFilePathUser]UTF8String], &db) != SQLITE_OK ) {
        sqlite3_close(db);
        NSAssert(0, @"failed to open database");
    }
    
    NSString * query = @"SELECT * FROM USERFIELDS";
    sqlite3_stmt * statement;
    
    
    if (sqlite3_prepare_v2(db, [query UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        if(sqlite3_step(statement) == SQLITE_ROW) {
            
            char * name = (char *)sqlite3_column_text(statement, 1);
            NSLog(@"%s",name);
            if([PhoneName isEqualToString:[NSString stringWithFormat:@"%s",name]])
            {
                NSLog(@"aaa");
                
            }
            else
            {
                char * update = "INSERT OR REPLACE INTO USERFIELDS(NAME,PASSWORD) VALUES(?,?)";
                
                
                //char * errorMsg ;
                
                sqlite3_stmt * stmt;
                if (sqlite3_prepare_v2(db, update, -1, &stmt, NULL) == SQLITE_OK) {
                    
                    
                    
                    sqlite3_bind_text(stmt, 1, [PhoneName UTF8String], -1, NULL);
                    sqlite3_bind_text(stmt, 2, [@"123" UTF8String], -1, NULL);
                    
                    
                }
                
                //执行更新
                if (sqlite3_step(stmt)!=SQLITE_DONE) {
                    
                    NSAssert(0, @"error updating table");
                    
                    
                }
                
                
                sqlite3_finalize(stmt);
                
            }
            
            
        }
        else{
            char * update = "INSERT OR REPLACE INTO USERFIELDS(NAME,PASSWORD) VALUES(?,?)";
            
            
            //char * errorMsg ;
            
            sqlite3_stmt * stmt;
            if (sqlite3_prepare_v2(db, update, -1, &stmt, NULL) == SQLITE_OK) {
                
                
                
                sqlite3_bind_text(stmt, 1, [PhoneName UTF8String], -1, NULL);
                sqlite3_bind_text(stmt, 2, [@"123" UTF8String], -1, NULL);
                
                
            }
            
            //执行更新
            if (sqlite3_step(stmt)!=SQLITE_DONE) {
                
                NSAssert(0, @"error updating table");
                
                
            }
            
            
            sqlite3_finalize(stmt);
            
        }
        sqlite3_finalize(statement);
    }
    

    
    sqlite3_close(db);

}

-(NSString *)dataFilePathUser
{//返回数据库文件路径
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString * documentDir = paths[0];
    
    NSLog(@"%@",documentDir);
    
    return [documentDir stringByAppendingPathComponent:@"table.sqlite"];
    
    
    
}

- (NSMutableArray *)readDataFromAdress {
    
    if (sqlite3_open([[self dataFilePathUser]UTF8String], &db) != SQLITE_OK ) {
        sqlite3_close(db);
        NSAssert(0, @"failed to open database");
    }

    NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:1000];
    char *sql = "select NAME,PHONE,CITY ,ADDRESS,DEFAULTNUM from ADDRESSFIELDS;";
    sqlite3_stmt *stmt;
    NSInteger result = sqlite3_prepare_v2(db, sql, -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        //ID INTEGER PRIMARY KEY, NAME TEXT,PHONE TEXT,CITY TEXT,ADDRESS TEXT,DEFAULTNUM INTEGER)";
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            char *name = (char *)sqlite3_column_text(stmt, 0);
            char * phone =(char *) sqlite3_column_text(stmt, 1);
            char *city = (char *)sqlite3_column_text(stmt, 2);
            char *adress= (char *)sqlite3_column_text(stmt, 3);
            NSInteger defaultNum = sqlite3_column_int(stmt, 4);
            
            //创建对象
            
            NSDictionary *tmpdic = [NSDictionary dictionaryWithObjectsAndKeys:
                                     [NSString stringWithUTF8String:name],@"name",
                                     [NSString stringWithUTF8String:phone],@"phone",
                                     [NSString stringWithUTF8String:city],@"city",
                                     [NSString stringWithUTF8String:adress],@"address",
                                     [NSString stringWithFormat:@"%ld",(long)defaultNum],@"defaultnum",
                                     nil];
            
        [mArray addObject:tmpdic];
        }
    
    }
    sqlite3_finalize(stmt);
    
    return mArray;
}


-(NSMutableArray *)readDataFromOrder {
    
    if (sqlite3_open([[self dataFilePathUser]UTF8String], &db) != SQLITE_OK ) {
        sqlite3_close(db);
        NSAssert(0, @"failed to open database");
    }
    
    NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:1000];
    char *sql = "select PRICE,NUM,TIME,NAME ,PHONE,ADDRESS,STATE from ORDERR;";
    sqlite3_stmt *stmt;
    NSInteger result = sqlite3_prepare_v2(db, sql, -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        //ID INTEGER PRIMARY KEY, NAME TEXT,PHONE TEXT,CITY TEXT,ADDRESS TEXT,DEFAULTNUM INTEGER)";
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            NSInteger price = sqlite3_column_int(stmt, 0);
            NSInteger num = sqlite3_column_int(stmt, 1);
            char *time = (char *)sqlite3_column_text(stmt, 2);
            char *name= (char *)sqlite3_column_text(stmt, 3);
            char *phone= (char *)sqlite3_column_text(stmt, 4);
            char *address= (char *)sqlite3_column_text(stmt, 5);
            NSInteger state = sqlite3_column_int(stmt, 6);
            
            //创建对象
            
            NSDictionary *tmpdic = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [NSString stringWithFormat:@"%ld",(long)price],@"price",
                                    [NSString stringWithFormat:@"%ld",(long)num],@"num",
                                    [NSString stringWithUTF8String:time],@"time",
                                    [NSString stringWithUTF8String:name],@"name",
                                    [NSString stringWithUTF8String:phone],@"phone",
                                    [NSString stringWithUTF8String:address],@"address",
                                    [NSString stringWithFormat:@"%ld",(long)state],@"state",
                                    nil];
            
            [mArray addObject:tmpdic];
        }
        
    }
    sqlite3_finalize(stmt);
    
    return mArray;
}


-(void)insertDataFromAdress:(NSString *)name withPhone:(NSString *)phone withCity:(NSString *)city withAddress:(NSString *)address withDefaultNum:(int)defaultnum{
    
    
    
    if (sqlite3_open([[self dataFilePathUser]UTF8String], &db) != SQLITE_OK ) {
        sqlite3_close(db);
        NSAssert(0, @"failed to open database");
    }

    
    char *update = "INSERT OR REPLACE INTO ADDRESSFIELDS(name,phone,city,address,defaultnum) VALUES(?,?,?,?,?);";
    
   // char *errorMsg = NULL;
    sqlite3_stmt *stmt;
    
    if (sqlite3_prepare_v2(db, update, -1, &stmt, nil) == SQLITE_OK){
        
        sqlite3_bind_text(stmt, 1, [name UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 2, [phone UTF8String], -1, NULL);
         sqlite3_bind_text(stmt, 3, [city UTF8String], -1, NULL);
         sqlite3_bind_text(stmt, 4, [address UTF8String], -1, NULL);
        sqlite3_bind_int(stmt, 5, defaultnum);
    
    
        if (sqlite3_step(stmt) != SQLITE_DONE){
            NSAssert(NO, @"插入数据失败");
        }
    }

    
    sqlite3_finalize(stmt);
    
    sqlite3_close(db);
   
}


-(void)insertDataFromOrder:(int)price withNum:(int)num withTime:(NSString *)time withName:(NSString *)name withPhone:(NSString *)phone withAddress:(NSString *)address withState:(int)state{
    
    
    
    if (sqlite3_open([[self dataFilePathUser]UTF8String], &db) != SQLITE_OK ) {
        sqlite3_close(db);
        NSAssert(0, @"failed to open database");
    }
    
    
    char *update = "INSERT OR REPLACE INTO ORDERR(PRICE,NUM,TIME,NAME ,PHONE,ADDRESS,STATE) VALUES(?,?,?,?,?,?,?);";
    
   // char *errorMsg = NULL;
    sqlite3_stmt *stmt;
    
    if (sqlite3_prepare_v2(db, update, -1, &stmt, nil) == SQLITE_OK){
        
        
        sqlite3_bind_int(stmt, 1, price);
        sqlite3_bind_int(stmt, 2, num);
        sqlite3_bind_text(stmt, 3, [time UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 4, [name UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 5, [phone UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 6, [address UTF8String], -1, NULL);
        sqlite3_bind_int(stmt, 7, state);
        
        
        if (sqlite3_step(stmt) != SQLITE_DONE){
            NSAssert(NO, @"插入数据失败");
        }
    }
    
    
    sqlite3_finalize(stmt);
    
    sqlite3_close(db);
    
}


-(void)deleteDataFromAdress:(NSString *)name{
    
    if (sqlite3_open([[self dataFilePathUser]UTF8String], &db) != SQLITE_OK ) {
        sqlite3_close(db);
        NSAssert(0, @"failed to open database");
    }
    
    sqlite3_stmt *stmt;
    
    static char *sql = "delete from ADDRESSFIELDS  where name = ?";
   
    int success = sqlite3_prepare_v2(db, sql, -1, &stmt, NULL);
    if (success != SQLITE_OK) {
        NSLog(@"Error: failed to delete:testTable");
        sqlite3_close(db);
        
        
    }
    
     sqlite3_bind_text(stmt, 1, [name UTF8String], -1, SQLITE_TRANSIENT);
    //执行SQL语句。这里是更新数据库
    success = sqlite3_step(stmt);
    //释放statement
    sqlite3_finalize(stmt);
    
//     int result = sqlite3_prepare_v2(db, [sqlStr UTF8String], -1, &stmt, NULL);
//    NSLog(@"删掉了删掉了");
//    if (result == SQLITE_OK) {
//        if (sqlite3_step(stmt) == SQLITE_ROW) {//觉的应加一个判断, 若有这一行则删除
//            if (sqlite3_step(stmt) == SQLITE_DONE) {
//                sqlite3_finalize(stmt);
//                sqlite3_close(db);               
//            }
//        }
//    }
    
    if (success == SQLITE_ERROR) {
        NSLog(@"Error: failed to delete the database with message.");
        //关闭数据库
        sqlite3_close(db);
        
    }
    //执行成功后依然要关闭数据库
    sqlite3_close(db);
    
    
}




@end
