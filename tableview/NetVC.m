//
//  NetVC.m
//  tableview
//
//  Created by 王瑜 on 16/8/13.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "NetVC.h"

@interface NetVC ()

@end

@implementation NetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.3 green:0.6 blue:0.2 alpha:0.5];
    _netData = [[NSMutableData alloc] init];
    
    NSString *str = @"http://baidu.cn";
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLConnection *con = [NSURLConnection connectionWithRequest:req delegate:self];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"failwitherror");
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_netData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSHTTPURLResponse *res = (NSHTTPURLResponse*)response;
    if(res.statusCode == 200){
        NSLog(@"statusCode:200");
    }
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSString *result = [[NSString alloc] initWithData:_netData encoding:NSUTF8StringEncoding];
    NSLog(@"finishloading,result:%@",result);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
