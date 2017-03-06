//
//  DetailViewController.m
//  Record
//
//  Created by tci100 on 2017/2/7.
//  Copyright © 2017年 JiangFei. All rights reserved.
//

#import "DetailViewController.h"
#import "SQLManager.h"
#import "DataEntity.h"
@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *firstTime;
@property (weak, nonatomic) IBOutlet UILabel *lastTime;
@property (nonatomic, strong) SQLManager * sqlManager;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.sqlManager = [SQLManager sharedManager];
    NSArray * arr = [self.sqlManager getAllInfo];
    DataEntity * entity = arr[self.number.intValue];
    self.name.text = entity.name;
    self.firstTime.text = [self dateToNSString:entity.starTime];
    self.lastTime.text =[self dateToNSString:entity.updateTimes.lastObject];
}
- (IBAction)backButtonClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)deleteButtonClick:(UIButton *)sender {
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
