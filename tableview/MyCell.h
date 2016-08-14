//
//  MyCell.h
//  tableview
//
//  Created by 王瑜 on 16/8/9.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyItemInfo.h"

@interface MyCell : UITableViewCell

@property(retain,nonatomic) UIImageView *iconView;
@property(retain,nonatomic) UILabel *introLabel;
@property(retain,nonatomic) UIButton *detailButton;

+(instancetype)CellWithTableView:(UITableView *)tableView AndData:(MyItemInfo *)myItemInfo;

@end
