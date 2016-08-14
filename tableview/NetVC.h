//
//  NetVC.h
//  tableview
//
//  Created by 王瑜 on 16/8/13.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NetVC : UIViewController<NSURLConnectionDelegate,NSURLConnectionDataDelegate>

@property(retain,nonatomic) NSMutableData *netData;

@end
