//
//  SideTableViewCell.h
//  Record
//
//  Created by tci100 on 2017/2/8.
//  Copyright © 2017年 JiangFei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideTableViewCell : UITableViewCell

-(instancetype)initCellWithTableView:(UITableView *)tableView;
-(void)crateWith:(NSString *)label andImage:(UIImage *)image;
@end
