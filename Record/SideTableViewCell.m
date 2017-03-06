//
//  SideTableViewCell.m
//  Record
//
//  Created by tci100 on 2017/2/8.
//  Copyright © 2017年 JiangFei. All rights reserved.
//

#import "SideTableViewCell.h"

@interface SideTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *myLabel;
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UIButton *updataButton;
@property (weak, nonatomic) IBOutlet UILabel *lableForNumber;

@end
@implementation SideTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //读取xib中的数据
    
}
-(instancetype)initCellWithTableView:(UITableView *)tableView{
    static NSString *identifier=@"SideCell";
    SideTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SideTableViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}
-(void)crateWith:(NSString *)label andImage:(UIImage *)image andNumber:(NSString *)number{
    [self.myImageView setImage:image];
    self.myLabel.text = label;
    self.lableForNumber.text = number;   
}
- (IBAction)updateButtonClick:(UIButton *)sender {
    NSLog(@"%@",self.myLabel.text);
    NSLog(@"%@",self.lableForNumber.text);
    if( [self.delegate respondsToSelector:@selector(updateButtonClickDelegate:)]){
        
        [self.delegate updateButtonClickDelegate:self.lableForNumber.text.intValue];
        NSLog(@"%d",self.lableForNumber.text.intValue);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
