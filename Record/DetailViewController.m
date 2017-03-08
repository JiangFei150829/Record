//
//  DetailViewController.m
//  Record
//
//  Created by tci100 on 2017/2/7.
//  Copyright © 2017年 JiangFei. All rights reserved.
//

#import "DetailViewController.h"
#import "SQLManager.h"
#import "FyCalendarView.h"

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *firstTime;
@property (weak, nonatomic) IBOutlet UILabel *lastTime;
@property (nonatomic, strong) SQLManager * sqlManager;

@property (strong, nonatomic) FyCalendarView *calendarView;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSDictionary * updateTimesDic;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.sqlManager = [SQLManager sharedManager];
    DataEntity * entity =  [self.sqlManager getInfoWithName:self.entityDetail];
    self.name.text = entity.name;
    self.firstTime.text = [self dateToNSString:entity.starTime];
    self.lastTime.text =[self dateToNSString:entity.updateTimes.lastObject];
    self.updateTimesDic = [self jsonUpdateTimes:entity.updateTimes];
    
    self.date = entity.updateTimes.lastObject;
    [self setupCalendarView];
}
- (IBAction)backButtonClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)deleteButtonClick:(UIButton *)sender {
}
- (void)setupCalendarView {
    self.calendarView.date = self.date;
    NSString * key = [self getKEYWithDate:self.date];
    NSArray * partDaysArr = [self.updateTimesDic objectForKey:key];
    self.calendarView = [[FyCalendarView alloc] initWithFrame:CGRectMake(10, 30, self.view.frame.size.width - 20, self.view.frame.size.width - 20)];
    //日期状态
    //self.calendarView.allDaysArr = [NSArray arrayWithObjects:@"1", @"2", @"26", @"12",@"15", @"19",nil];
    self.calendarView.partDaysArr = partDaysArr;
    [self.view addSubview:self.calendarView];
    // self.calendarView.isShowOnlyMonthDays = NO;
    self.calendarView.date = self.date;
    self.calendarView.calendarBlock =  ^(NSInteger day, NSInteger month, NSInteger year){
        NSLog(@"%li-%li-%li", (long)year,(long)month,(long)day);
    };
    WS(weakSelf)
    self.calendarView.nextMonthBlock = ^(){
        [weakSelf setupNextMonth];
    };
    self.calendarView.lastMonthBlock = ^(){
        [weakSelf setupLastMonth];
    };
}
- (void)setupNextMonth {
    self.date = [self.calendarView nextMonth:self.date];
    NSString * key = [self getKEYWithDate:self.date];
     NSArray * partDaysArr = [self.updateTimesDic objectForKey:key];
    
    [self.calendarView removeFromSuperview];
    self.calendarView = [[FyCalendarView alloc] initWithFrame:CGRectMake(10, 30, self.view.frame.size.width - 20, self.view.frame.size.width - 20)];
    [self.view addSubview:self.calendarView];
    //self.calendarView.allDaysArr = [NSArray arrayWithObjects:  @"17",  @"21", @"25",  @"30", nil];
    self.calendarView.partDaysArr = partDaysArr;
    
    [self.calendarView createCalendarViewWith:self.date];
    self.calendarView.calendarBlock =  ^(NSInteger day, NSInteger month, NSInteger year){
        NSLog(@"%li-%li-%li", (long)year,(long)month,(long)day);
    };
    WS(weakSelf)
    self.calendarView.nextMonthBlock = ^(){
        [weakSelf setupNextMonth];
    };
    self.calendarView.lastMonthBlock = ^(){
        [weakSelf setupLastMonth];
    };
}

- (void)setupLastMonth {
    self.date = [self.calendarView lastMonth:self.date];
    NSString * key = [self getKEYWithDate:self.date];
    NSArray * partDaysArr = [self.updateTimesDic objectForKey:key];
    [self.calendarView removeFromSuperview];
    self.calendarView = [[FyCalendarView alloc] initWithFrame:CGRectMake(10, 30, self.view.frame.size.width - 20, self.view.frame.size.width - 20)];
    [self.view addSubview:self.calendarView];
   //self.calendarView.allDaysArr = [NSArray arrayWithObjects: @"5", @"6", @"8", @"9", @"11", @"16", @"17", @"21", @"25",  @"30", nil];
    self.calendarView.partDaysArr = partDaysArr;
    
    [self.calendarView createCalendarViewWith:self.date];
    self.calendarView.calendarBlock =  ^(NSInteger day, NSInteger month, NSInteger year){
        NSLog(@"%li-%li-%li", (long)year,(long)month,(long)day);
    };
    WS(weakSelf)
    self.calendarView.lastMonthBlock = ^(){
        [weakSelf setupLastMonth];
    };
    self.calendarView.nextMonthBlock = ^(){
        [weakSelf setupNextMonth];
    };
}
-(NSDictionary *)jsonUpdateTimes:(NSArray *)updateTimes{
    NSMutableDictionary * mdic = [[NSMutableDictionary alloc]initWithCapacity:1];
    for (NSDate * updateTime in updateTimes) {
        NSString * updateTimeStr = [self dateToNSString:updateTime];
        NSArray * updateTimeArr = [updateTimeStr componentsSeparatedByString:@"-"];
        NSString * objStr = updateTimeArr[2];
        int  objInt = objStr.intValue;
        NSString * objStrDelete0 = [NSString stringWithFormat:@"%d",objInt];
        NSArray * objArr = [NSArray arrayWithObjects:objStrDelete0,nil];
        NSString * KEY = [NSString stringWithFormat:@"KEY%@-%@",updateTimeArr[0],updateTimeArr[1]];
        if ([[mdic objectForKey:KEY] class]) {
            NSMutableArray * arrayObjs = [NSMutableArray arrayWithArray:[mdic objectForKey:KEY]];
            [arrayObjs addObject:objArr[0]];
            [mdic setObject:arrayObjs forKey:KEY];
            
        }else{
            [mdic setObject:objArr forKey:KEY];
        }
    }
    return mdic;
}
-(NSString *)getKEYWithDate:(NSDate *)date{
    NSString *  str = [self dateToNSString:date];
    NSArray * arr = [str componentsSeparatedByString:@"-"];
    NSString * KEY = [NSString stringWithFormat:@"KEY%@-%@",arr[0],arr[1]];
    return KEY;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
