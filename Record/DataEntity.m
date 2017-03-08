//
//  DataEntity.m
//  Record
//
//  Created by tci100 on 2017/2/8.
//  Copyright © 2017年 JiangFei. All rights reserved.
//

#import "DataEntity.h"

@interface DataEntity ()

@end
@implementation DataEntity

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.myID = dic[@"myID"];
        self.number = dic[@"number"];
        self.name = dic[@"name"];
        self.starTime = dic[@"starTime"];
        self.updateTimes = dic[@"updateTimes"];
    }
    return self;
}
-(instancetype)initWithName:(NSString *)name{
    self = [super init];
    if (self) {
        self.number = @"0";
        self.name = name;
        self.starTime = [[NSDate alloc]init];
        NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
        NSString * strDate = [formatter stringFromDate:self.starTime];
        self.myID = strDate;
        self.updateTimes = [[[NSArray alloc]init] arrayByAddingObject:self.starTime];
    }
    return self;
}

-(NSDictionary *)getInfoDic{
    NSMutableDictionary * mdic = [[NSMutableDictionary alloc]initWithCapacity:1];
    [mdic setObject:self.myID forKey:@"myID"];
    [mdic setObject:self.number forKey:@"number"];
    [mdic setObject:self.name forKey:@"name"];
    [mdic setObject:self.starTime forKey:@"starTime"];
    [mdic setObject:self.updateTimes forKey:@"updateTimes"];
    return [NSDictionary dictionaryWithDictionary:mdic];
}

-(NSString *)description{
    return  [NSString stringWithFormat:@"%@ %@ %@ %@ %@",_myID,_name,_number,_starTime,_updateTimes];
}
@end
