//
//  SQLManager.h
//  Record
//
//  Created by tci100 on 2017/2/6.
//  Copyright © 2017年 JiangFei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQLManager : NSObject
// 声明单例的类方法
+ (instancetype)sharedManager;
-(void)createSQL:(void(^)(BOOL isSuccess))theBlock;
-(void)insertIntoTableName:(NSDictionary *)dic;
-(NSArray *)getAllInfo;
-(void)updateInfo:(NSDictionary *)dic;
-(void)deleteInfoWithID:(NSString *)myID;
@end
