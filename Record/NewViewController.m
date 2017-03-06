//
//  NewViewController.m
//  Record
//
//  Created by tci100 on 2017/3/4.
//  Copyright © 2017年 JiangFei. All rights reserved.
//

#import "NewViewController.h"
#import "SQLManager.h"
#import "DataEntity.h"
@interface NewViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (nonatomic, strong) SQLManager * sqlManager;
@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.sqlManager = [SQLManager sharedManager];
}
- (IBAction)saveButtonClick:(UIButton *)sender {
    if (![self.nameTextField.text  isEqual: @" "]) {
        DataEntity * entity = [[DataEntity alloc]initWithName:self.nameTextField.text];
        [self.sqlManager insertIntoTableName:entity];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self alertMessageWithTitle:@"提示" andMessage:@"事件不能为空"];
    }
    
}
- (IBAction)backButtonClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
