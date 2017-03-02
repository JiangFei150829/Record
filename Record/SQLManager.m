//
//  SQLManager.m
//  Record
//
//  Created by tci100 on 2017/2/6.
//  Copyright © 2017年 JiangFei. All rights reserved.
//

#import "SQLManager.h"
#import "BGFMDB.h"
#import "DataEntity.h"
#define TableName @"TableName_2"

@implementation SQLManager
+ (instancetype)sharedManager{
    // 创建静态单例类对象
    static id instance = nil;
    // 执行且在整个程序的声明周期中，仅执行一次某一个 block 对象
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 初始化单例类对象
        instance = [[self alloc] init];
    });
    return instance;
}
-(void)createSQL:(void(^)(BOOL isSuccess))theBlock{
    NSMutableArray* keys = [NSMutableArray array];
    [keys addObject:@"myID"];
    [keys addObject:@"number"];
    [keys addObject:@"name"];
    [keys addObject:@"starTime"];
    [keys addObject:@"updateTime"];
    //默认建立主键id
    //keys 数据存放要求@[字段名称1,字段名称2]
    BOOL result = [[BGFMDB intance] createTableWithTableName:TableName keys:keys];//建表语句
    if (result) {
        NSLog(@"创表成功");
    } else {
        NSLog(@"创表失败");
    }
    
}
-(void)insertIntoTableName:(NSDictionary *)dic{
    BOOL result = [[BGFMDB intance] insertIntoTableName:TableName Dict:dic];//插入语句
    if (result) {
        NSLog(@"插入成功");
    } else {
        NSLog(@"插入失败");
    }
}
-(NSArray *)getAllInfo{
    NSArray* arr = [[BGFMDB intance] queryWithTableName:TableName];
    NSMutableArray * marr = [NSMutableArray arrayWithCapacity:1];
    for (NSDictionary * dic in arr) {
        DataEntity * empty = [[DataEntity alloc]initWithDic:dic];
        [marr addObject:empty];
    }
    //排序的描述
    NSSortDescriptor * des = [NSSortDescriptor sortDescriptorWithKey:@"number" ascending:YES];
    NSArray * arrData = [NSArray new];//这一个数组应该存得是一个类 name 和 grade只是他的属性
    
    //按照描述进行排序
    arrData=[marr sortedArrayUsingDescriptors:@[des]];
    //查询语句
    return arrData;
}
-(void)updateInfo:(NSDictionary *)dic{
    NSMutableArray* where = [NSMutableArray array];
    [where addObject: @"myID"];
    [where addObject:@"="];
    [where addObject: dic[@"myID"]];
    NSMutableDictionary * mdic = [[NSMutableDictionary alloc]initWithDictionary:dic];
    [mdic removeObjectForKey:@"myID"];
    BOOL result = [[BGFMDB intance] updateWithTableName:TableName valueDict:mdic where:where];
    //更新语句
    if (result) {
        NSLog(@"更新成功");
        
    } else {
        NSLog(@"更新失败");
    }
    
}
-(void)deleteInfoWithID:(NSString *)myID{
    NSMutableArray* where = [NSMutableArray array];
    [where addObject: @"myID"];
    [where addObject:@"="];
    [where addObject: myID];
    BOOL result = [[BGFMDB intance] deleteWithTableName:TableName where:where];//删除语句
    if (result) {
        NSLog(@"删除成功");
    } else {
        NSLog(@"删除失败");
    }
}
@end
