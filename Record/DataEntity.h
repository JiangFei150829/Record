//
//  DataEntity.h
//  Record
//
//  Created by tci100 on 2017/2/8.
//  Copyright © 2017年 JiangFei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataEntity : NSObject
-(instancetype)initWithDic:(NSDictionary *)dic;
-(instancetype)initWithName:(NSString *)name andNumber:(NSString *)number;
-(NSDictionary *)getInfoDic;
-(NSString *)getMyID;
@end
