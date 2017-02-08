//
//  SQLManager.m
//  Record
//
//  Created by tci100 on 2017/2/6.
//  Copyright © 2017年 JiangFei. All rights reserved.
//

#import "SQLManager.h"
#import "BGFMDB.h"
#define TableName @"TableName"

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
    [keys addObject:@"key_1"];
    [keys addObject:@"key_2"];
    [keys addObject:@"key_3"];
    [keys addObject:@"key_4"];
    //默认建立主键id
    //keys 数据存放要求@[字段名称1,字段名称2]
    BOOL result = [[BGFMDB intance] createTableWithTableName:TableName keys:keys];//建表语句
    if (result) {
        NSLog(@"创表成功");
    } else {
        NSLog(@"创表失败");
    }

}
@end
