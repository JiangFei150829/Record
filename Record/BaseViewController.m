//
//  BaseViewController.m
//  Record
//
//  Created by tci100 on 2017/2/7.
//  Copyright © 2017年 JiangFei. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //隐藏主页导航栏
    self.navigationController.navigationBarHidden=YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)alertMessageWithTitle:(NSString*)title andMessage:(NSString*)message{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    //这个确定按钮中的文字在多语言的时候自己在调整就是了
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定"style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
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
