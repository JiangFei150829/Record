//
//  MainViewController.m
//  Record
//
//  Created by tci100 on 2017/2/7.
//  Copyright © 2017年 JiangFei. All rights reserved.
//

#import "MainViewController.h"
#import "Main2ViewController.h"
#import "TempData.h"
#import "SideTableViewCell.h"
#import "RTDragCellTableView.h"
#import "SQLManager.h"
#import "DataEntity.h"
#define HH [UIScreen mainScreen].bounds.size.height
#define WW [UIScreen mainScreen].bounds.size.width
@interface MainViewController ()<RTDragCellTableViewDataSource,RTDragCellTableViewDelegate>
@property (nonatomic, strong)SQLManager * sqlManager;
@property (nonatomic, strong) RTDragCellTableView *  dragCellTableView;
@property (nonatomic, strong) Main2ViewController *  main2ViewController;
@property (nonatomic, strong) UIView * viewForMain2View;
@property (nonatomic, strong) TempData * tempDataManager;
@property (nonatomic, strong) NSArray * allData;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    
    self.tempDataManager = [TempData sharedManager];
    [self.tempDataManager getAllData:^(NSArray *allData) {
        self.allData = allData;
    }];
    
    [self initDragCellTableView];
    [self initMTableViewController];
    
     [self SQLMedthod];
}
-(void)SQLMedthod{
    //创建表
    self.sqlManager = [SQLManager sharedManager];
    [self.sqlManager createSQL:^(BOOL isSuccess) {
        
    }];
    
    NSArray * arrData = [self.sqlManager getAllInfo];
    NSMutableArray * arrEntity = [NSMutableArray arrayWithCapacity:1];
    for (NSDictionary * dicData in arrData) {
      DataEntity * entity   = [[DataEntity alloc]initWithDic:dicData];
     [arrEntity addObject:entity];
    }
    NSLog(@"%@",arrEntity);
    
    
    
    //插入数据
    //[self.sqlManager insertIntoTableName:entity_1.getInfoDic];
 
    //删除数据
    //[self.sqlManager deleteInfoWithID:entity_1.getMyID];
    
    //修改数据
    //NSDictionary * dic = @{@"myID":@"0002",@"starTime":@"4s4"};
    //[self.sqlManager updateInfo:dic];
    
  
    
}
-(void)initDragCellTableView{
 
    self.dragCellTableView = [[RTDragCellTableView alloc]init];
    self.dragCellTableView.frame = CGRectMake(20, 0,WW*2/3,HH);
    self.dragCellTableView.allowsSelection = YES;
    [self.view addSubview:self.dragCellTableView];
    self.dragCellTableView.dataSource = self;
    self.dragCellTableView.delegate = self;
}

-(void)initMTableViewController{
    self.viewForMain2View = [[UIView alloc]initWithFrame:CGRectMake(0, 0,WW,HH)];
    [self.view addSubview:self.viewForMain2View];
    self.main2ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Main2ViewController"];
    
    [self addChildViewController:self.main2ViewController];
    [self.viewForMain2View addSubview:self.main2ViewController.view];
    [self dragGesture];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark--手势
-(void)dragGesture{
    //拖动手势
    UIPanGestureRecognizer * panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dragGestureAction:)];
    [self.viewForMain2View addGestureRecognizer:panGesture];
}
- (void)dragGestureAction:(UIPanGestureRecognizer *)dragG
{
    //NSLog(@"拖动");
    UIView * view = dragG.view;
    CGPoint p = [dragG translationInView:view.superview];//这里的 p 就是相对偏移量（*重点*）
    if (dragG.state == UIGestureRecognizerStateBegan || dragG.state == UIGestureRecognizerStateChanged) {
        //用p记录view在其父视图上移动的距离  translation平移
        //NSLog(@"%f",p.x);
        if (self.viewForMain2View.frame.origin.x<=0 && p.x<0) {
            p.x=0;
        }
        //是view在新的位置上显示
        [view setCenter:CGPointMake(view.center.x + p.x, view.center.y)];
        //将偏移量设置为0（因为在上一步中已经根据偏移量进行过移动了）
        [dragG setTranslation:CGPointZero inView:view.superview];
        
    }
    if (dragG.state == UIGestureRecognizerStateEnded) {
        if (self.viewForMain2View.frame.origin.x<=WW/4) {
            self.viewForMain2View.center = self.view.center;
        }
        if (self.viewForMain2View.frame.origin.x>WW/4&&self.viewForMain2View.frame.origin.x<WW*2/3) {
            CGPoint  center = CGPointMake(WW*2/3+WW/2, self.view.center.y);
            self.viewForMain2View.center = center;
        }
        if (self.viewForMain2View.frame.origin.x>WW*2/3) {
            CGPoint  center = CGPointMake(WW*2/3+WW/2, self.view.center.y);
            self.viewForMain2View.center = center;
            
        }
    }
    
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return self.allData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SideTableViewCell * cell = [[SideTableViewCell alloc]initCellWithTableView:tableView];
    [cell crateWith:self.allData[indexPath.row] andImage:[UIImage imageNamed:@"11.png"]];
    
    return cell;
}
- (NSArray *)originalArrayDataForTableView:(RTDragCellTableView *)tableView{
    return self.allData;
}

- (void)tableView:(RTDragCellTableView *)tableView newArrayDataForDataSource:(NSArray *)newArray{
    self.allData = newArray;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *arrayM=[[NSBundle mainBundle]loadNibNamed:@"SideTableViewCell" owner:nil options:nil];
    SideTableViewCell *cell=[arrayM firstObject];
    return cell.bounds.size.height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"CCC___%ld",(long)indexPath.row);
    self.viewForMain2View.center = self.view.center;
    UIViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
