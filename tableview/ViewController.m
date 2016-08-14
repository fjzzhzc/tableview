//
//  ViewController.m
//  tableview
//
//  Created by 王瑜 on 16/8/9.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "ViewController.h"
#import "MyItemInfo.h"
#import "MyCell.h"
#import "MySectionInfo.h"

@interface ViewController ()
{
    
    // 存储类型为section别的rowdata数组
    NSMutableArray *allDataArray;
    
    // 保存section层叠/展开状态的数组
    NSMutableArray *statusArray;
    
    // 保存tableview的引用
    UITableView *myTableView;
    
    // 保存拖拽对象的原本所在section位置
    NSInteger sourceIndex;
    
    // 保存拖拽对象移动到的section位置
    NSInteger destinationIndex;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingTableDataAndStatusArray];
    
    CGPoint pt= self.view.center;
    pt.y+=20;
    
    CGRect rect = self.view.bounds;
    rect.size.height-=120;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    tableView.center=pt;
    tableView.dataSource=self;
    tableView.delegate=self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.separatorColor = [UIColor blueColor];
    myTableView = tableView;
    [self.view addSubview:tableView];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyItemInfo *info = [[allDataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    MyCell *cell = [MyCell CellWithTableView:tableView AndData:info];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UITableViewHeaderFooterView *header = [[UITableViewHeaderFooterView alloc] init];
    header.tag = 555 + section;
    
    UIView *bgColor = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 25)];
    bgColor.backgroundColor=[UIColor colorWithRed:0.10 green:0.68 blue:0.94 alpha:0.3];
    [header addSubview:bgColor];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 25)];
    lbl.textAlignment = NSTextAlignmentLeft;
    lbl.font = [UIFont fontWithName:@"Helvetica" size:20];
    lbl.text=[NSString stringWithFormat:@"header%ld",section+1];
    [header addSubview:lbl];
    
    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [editButton setTitle:@"编辑" forState:UIControlStateNormal];
    editButton.frame = CGRectMake(250, 0, 50, 25);
    [editButton addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    
    header.tintColor = [UIColor cyanColor];
    [header addSubview:editButton];

    return header;
}

-(void)clickButton{
    [myTableView setEditing:!myTableView.isEditing animated:YES];
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleNone;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
    sourceIndex = sourceIndexPath.section;
    destinationIndex = destinationIndexPath.section;
    
    NSMutableArray *sourceSectionArray = [allDataArray objectAtIndex:sourceIndex];
    NSMutableArray *destinationSectionArray = [allDataArray objectAtIndex:destinationIndex];
    MyItemInfo *fromItemInfo = [sourceSectionArray objectAtIndex:sourceIndex];
    [sourceSectionArray removeObjectAtIndex:sourceIndex];
    [destinationSectionArray insertObject:fromItemInfo atIndex:destinationIndex];
    
    MySectionInfo *sourceInfo = (MySectionInfo*)[statusArray objectAtIndex:sourceIndex];
    sourceInfo.rows-=1;
    MySectionInfo *destinationInfo = [statusArray objectAtIndex:destinationIndex];
    destinationInfo.rows+=1;
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return true;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

//    UITableViewHeaderFooterView *footer = [myTableView footerViewForSection:section];
//    
//    if(footer != nil){
//        UILabel *content = (UILabel*)[myTableView viewWithTag:888+section];
//        MySectionInfo *info = [statusArray objectAtIndex:section];
//        content.text = info.status;
//    } else {
        UITableViewHeaderFooterView *footer = [[UITableViewHeaderFooterView alloc] initWithFrame:CGRectMake(0, 0, 150, 25)];
        
        UIView *bgColor = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 25)];
        bgColor.backgroundColor=[UIColor colorWithRed:0.50 green:0.9 blue:0.4 alpha:0.3];
        [footer addSubview:bgColor];
        
        UILabel *footLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 25)];
        footLabel.textAlignment = NSTextAlignmentLeft;
        footLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
        footLabel.text = [NSString stringWithFormat:@"Footer%ld",section+1];
        [footer addSubview:footLabel];
        
        footer.contentMode=UIViewContentModeRight;
        MySectionInfo *sectionInfo = [statusArray objectAtIndex:section];
        UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(250, 0, 50, 25)];
        content.font = [UIFont fontWithName:@"Helvetica" size:20];
        content.text = sectionInfo.status;
        content.textAlignment = NSTextAlignmentCenter;
        content.tag = 888 + section;
        [footer addSubview:content];
        
        footer.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeSection:)];
        tap.numberOfTapsRequired = 2;
        tap.numberOfTouchesRequired = 1;
        
        [footer addGestureRecognizer:tap];

        footer.tag = 666 + section;
//    }
    
    return footer;
}

-(void)changeSection:(UITapGestureRecognizer*)tap{
    
    UITableViewHeaderFooterView *footer = (UITableViewHeaderFooterView*)tap.view;
    NSInteger secNum = footer.tag - 666;
    MySectionInfo *info = [statusArray objectAtIndex:secNum];
    NSString *status = info.status;
    
    if([@"+" isEqualToString:status]){
        info.status=@"-";
    } else if([@"-" isEqualToString:status]){
        info.status=@"+";
    }
    
    UILabel *content = (UILabel*)[myTableView viewWithTag:888+secNum];
    content.text=info.status;
    
    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] initWithIndex:secNum];
    if(sourceIndex != -1 || destinationIndex != -1) {
        [indexSet addIndex:sourceIndex];
        [indexSet addIndex:destinationIndex];
        sourceIndex = -1;
        destinationIndex = -1;
    }
    
    if([@"+" isEqualToString:status]){
        [myTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationBottom];
    } else {
        [myTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationTop];
    }
//    [myTableView reloadData];

}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 25;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    MySectionInfo *sectionInfo = [statusArray objectAtIndex:section];
    NSString *status = sectionInfo.status;
    NSInteger rows = sectionInfo.rows;
    NSInteger three = 3;
    
    if(rows > three && [@"+" isEqualToString:status]){
        return 3;
    }
    else{
        return [[allDataArray objectAtIndex:section] count];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [allDataArray count];
}

// 从properties file里取数据
-(void) settingTableDataAndStatusArray{
    NSString *fullpath=[[NSBundle mainBundle]pathForResource:@"MyInfo.plist" ofType:nil];
    NSDictionary *tempDic=[NSDictionary dictionaryWithContentsOfFile:fullpath];
    allDataArray = [[NSMutableArray alloc] initWithCapacity:5];
    statusArray = [[NSMutableArray alloc] initWithCapacity:5];
    
    for(NSArray *sec in tempDic.allValues){
        
        NSMutableArray *rowsDataArray = [[NSMutableArray alloc] initWithCapacity:3];
        MySectionInfo *sectionInfo = [[MySectionInfo alloc] init];
        
        for(NSDictionary *dic in sec){
            MyItemInfo *info = [[MyItemInfo alloc] init];
            info.icon = [dic valueForKey:@"icon"];
            info.intro = [dic valueForKey:@"intro"];
            info.btn = [dic valueForKey:@"btn"];
            [rowsDataArray addObject:info];
        }
        [allDataArray addObject:rowsDataArray];
        sectionInfo.rows=rowsDataArray.count;
        sectionInfo.status=rowsDataArray.count > 3 ? @"+":nil;
        [statusArray addObject:sectionInfo];
        
    }
    
    sourceIndex = -1;
    destinationIndex = -1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
