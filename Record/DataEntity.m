//
//  DataEntity.m
//  Record
//
//  Created by tci100 on 2017/2/8.
//  Copyright © 2017年 JiangFei. All rights reserved.
//

#import "DataEntity.h"

@interface DataEntity ()
@property (nonatomic, strong) NSString * myID;
//在Cell中的排序
@property (nonatomic, strong) NSString * number;
//记录的名字
@property (nonatomic, strong) NSString * name;
//记录开始的时间
@property (nonatomic, strong) NSString * starTime;
//记录刷新的时间
@property (nonatomic, strong) NSArray * updateTime;
@end
@implementation DataEntity

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.number = dic[@"number"];
        self.name = dic[@"name"];
        self.starTime = [NSString stringWithFormat:@"%@", [[NSDate alloc]init]];
        self.myID = self.starTime;
        self.updateTime = [[[NSArray alloc]init] arrayByAddingObject:self.starTime];
    }
    return self;
}
-(instancetype)initWithName:(NSString *)name andNumber:(NSString *)number{
    self = [super init];
    if (self) {
        self.number = number;
        self.name = name;
        self.starTime = [NSString stringWithFormat:@"%@", [[NSDate alloc]init]];
        self.myID = self.starTime;
        self.updateTime = [[[NSArray alloc]init] arrayByAddingObject:self.starTime];
    }
    return self;
}
-(NSString *)getMyID{
    return self.myID;
}
-(NSDictionary *)getInfoDic{
    NSMutableDictionary * mdic = [[NSMutableDictionary alloc]initWithCapacity:1];
    [mdic setObject:self.myID forKey:@"myID"];
    [mdic setObject:self.number forKey:@"number"];
    [mdic setObject:self.name forKey:@"name"];
    [mdic setObject:self.starTime forKey:@"starTime"];
    [mdic setObject:self.updateTime forKey:@"updateTime"];
    return [NSDictionary dictionaryWithDictionary:mdic];
}
@end
