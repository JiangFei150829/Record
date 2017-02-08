//
//  TempData.m
//  Record
//
//  Created by tci100 on 2017/2/7.
//  Copyright © 2017年 JiangFei. All rights reserved.
//

#import "TempData.h"

@implementation TempData
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
-(void)getAllData:(void(^)(NSArray * allData))theblock{
    NSArray * array = @[@"第一条记录",@"第二条记录",@"第三条记录",@"第四条记录",@"第五条记录"];
    theblock(array);
}
@end
