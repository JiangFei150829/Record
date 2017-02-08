//
//  TempData.h
//  Record
//
//  Created by tci100 on 2017/2/7.
//  Copyright © 2017年 JiangFei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TempData : NSObject
// 声明单例的类方法
+ (instancetype)sharedManager;
-(void)getAllData:(void(^)(NSArray * allData))theblock;
@end
