//
//  DataEntity.h
//  Record
//
//  Created by tci100 on 2017/2/8.
//  Copyright © 2017年 JiangFei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataEntity : NSObject
@property (nonatomic, strong) NSString * myID;
//在Cell中的排序
@property (nonatomic, strong) NSString * number;
//记录的名字
@property (nonatomic, strong) NSString * name;
//记录开始的时间
@property (nonatomic, strong) NSDate * starTime;
//记录刷新的时间
@property (nonatomic, strong) NSArray * updateTimes;

-(instancetype)initWithDic:(NSDictionary *)dic;
-(instancetype)initWithName:(NSString *)name;
-(NSDictionary *)getInfoDic;
@end
