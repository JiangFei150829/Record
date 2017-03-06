//
//  SideTableViewCell.h
//  Record
//
//  Created by tci100 on 2017/2/8.
//  Copyright © 2017年 JiangFei. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SideTableViewCellDelegate;
@interface SideTableViewCell : UITableViewCell
@property (nonatomic, strong) NSString * row;
@property (nonatomic, strong) id<SideTableViewCellDelegate> delegate;
-(instancetype)initCellWithTableView:(UITableView *)tableView;
-(void)crateWith:(NSString *)label andImage:(UIImage *)image andNumber:(NSString *)number;


@end
@protocol SideTableViewCellDelegate <NSObject>

-(void)updateButtonClickDelegate:(int)row;

@end
