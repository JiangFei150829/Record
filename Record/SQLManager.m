//
//  SQLManager.m
//  Record
//
//  Created by tci100 on 2017/2/6.
//  Copyright © 2017年 JiangFei. All rights reserved.
//

#import "SQLManager.h"
#import "BGFMDB.h"

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
    [keys addObject:@"updateTimes"];
    //默认建立主键id
    //keys 数据存放要求@[字段名称1,字段名称2]
    BOOL result = [[BGFMDB intance] createTableWithTableName:TableName keys:keys];//建表语句
    if (result) {
        NSLog(@"创表成功");
    } else {
        NSLog(@"创表失败");
    }
    
}
-(void)insertIntoTableName:(DataEntity *)entity{
    NSMutableDictionary * newDic = [[NSMutableDictionary alloc]initWithCapacity:1];
    [newDic setValue:entity.myID forKey:@"myID"];
    [newDic setValue:entity.number forKey:@"number"];
    [newDic setValue:entity.name forKey:@"name"];
    [newDic setValue:[self dateToNSString:entity.starTime] forKey:@"starTime"];
    
    NSMutableString * mstr = [[NSMutableString alloc]initWithCapacity:1];
    for (int i = 0; i < entity.updateTimes.count; i++) {
        NSDate * date = entity.updateTimes[i];
        [mstr appendFormat: @"%@", [self dateToNSString:date]];
        if (i<entity.updateTimes.count-1) {
           [mstr appendFormat:@"&&"];
        }
    }
    [newDic setValue:mstr forKey:@"updateTimes"];
    
    
    BOOL result = [[BGFMDB intance] insertIntoTableName:TableName Dict:newDic];//插入语句
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
        NSString * strr = dic[@"updateTimes"];
        NSArray * strUpdateTimes = [strr componentsSeparatedByString:@"&&"];
        NSMutableDictionary * newDic = [[NSMutableDictionary alloc]initWithCapacity:1];
        [newDic setValue:dic[@"myID"] forKey:@"myID"];
        [newDic setValue:dic[@"number"] forKey:@"number"];
        [newDic setValue:dic[@"name"] forKey:@"name"];
        NSDate * starTime = [self stringToNSdate:dic[@"starTime"]];
        [newDic setValue: starTime forKey:@"starTime"];
        
        NSMutableArray * marrUpdateTimes = [NSMutableArray arrayWithCapacity:1];
        for (NSString *  strUpdateTime in strUpdateTimes) {
            NSDate * updateTime = [self stringToNSdate:strUpdateTime];
            [marrUpdateTimes addObject:updateTime];
        }
        [newDic setValue:marrUpdateTimes forKey:@"updateTimes"];
        DataEntity * empty = [[DataEntity alloc]initWithDic:[NSDictionary dictionaryWithDictionary:newDic]];
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
-(void)updateInfo:(DataEntity *)entity{
    NSMutableArray* where = [NSMutableArray array];
    [where addObject: @"myID"];
    [where addObject:@"="];
    [where addObject: entity.myID];
    
    NSMutableDictionary * newDic = [[NSMutableDictionary alloc]initWithCapacity:1];
    [newDic setValue:entity.number forKey:@"number"];
    [newDic setValue:entity.name forKey:@"name"];
    [newDic setValue:[self dateToNSString:entity.starTime] forKey:@"starTime"];
    NSMutableString * mstr = [[NSMutableString alloc]init];
    for (int i = 0; i<entity.updateTimes.count; i++) {
        NSString * str  = [self dateToNSString:entity.updateTimes[i]];
        [mstr appendString:str];
        if (i<entity.updateTimes.count-1) {
            [mstr appendString:@"&&"];
        }
    }
    [newDic setValue:mstr forKey:@"updateTimes"]; 
    BOOL result = [[BGFMDB intance] updateWithTableName:TableName valueDict:newDic where:where];
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
-(NSDate *)stringToNSdate:(NSString *)stringDate{
    NSArray * dateArr = [stringDate componentsSeparatedByString:@"-"];
    //日期的 分开输入
    NSCalendar * calendar = [NSCalendar currentCalendar];//创建一个日历用来接收时间
    //输入时区
    NSTimeZone * timezone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    //创建时间组件
    NSDateComponents * components = [[NSDateComponents alloc]init];
    [components setTimeZone:timezone];
    NSString * str0 = dateArr[0];
    NSString * str1 = dateArr[1];
    NSString * str2 = dateArr[2];
    NSString * str3 = dateArr[3];
    NSString * str4 = dateArr[4];
    NSString * str5 = dateArr[5];
    [components setYear:str0.intValue];
    [components setMonth:str1.intValue];
    [components setDay:str2.intValue];
    [components setHour:str3.intValue];
    [components setMinute:str4.intValue];
    [components setSecond:str5.intValue];
    NSDate * myTime = [calendar dateFromComponents:components];
    return myTime;
}
-(NSString *)dateToNSString:(NSDate *)date{
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
    NSString * strDate = [formatter stringFromDate:date];
    return strDate;
}
@end
