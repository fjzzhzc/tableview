//
//  MyCell.m
//  tableview
//
//  Created by 王瑜 on 16/8/9.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell


+(instancetype)CellWithTableView:(UITableView *)tableView AndData:(MyItemInfo *)myItemInfo{
    
    static NSString *identifier=@"myCell";
    
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(cell == nil){
        cell = [[MyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    [cell settingData:myItemInfo];
    
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        
        UIImageView *icon = [[UIImageView alloc] init];
        [self.contentView addSubview:icon];
        self.iconView=icon;
        
        UILabel *intro = [[UILabel alloc] init];
        [intro setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:intro];
        self.introLabel=intro;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.contentView addSubview:btn];
        self.detailButton = btn;
        
    }
    
    return self;
}

-(void)settingData:(MyItemInfo *) myItemInfo{
    
    UIImage *img = [UIImage imageNamed:myItemInfo.icon];
    self.iconView.image=img;
    self.iconView.frame = CGRectMake(0, 0, 40, 40);
    self.iconView.contentMode = UIViewContentModeScaleToFill;
    
    self.introLabel.text= myItemInfo.intro;
    self.introLabel.font=[UIFont fontWithName:@"Helvetica" size:18];
    self.introLabel.frame= CGRectMake(51, 0, 100, 40);
    
    [self.detailButton setTitle:myItemInfo.btn forState:UIControlStateNormal];
    [self.detailButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.detailButton.frame= CGRectMake(self.frame.size.width-130, 0, 55, 40);
}

@end
