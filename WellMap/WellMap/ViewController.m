//
//  ViewController.m
//  WellMap
//
//  Created by 同筑科技 on 2017/6/23.
//  Copyright © 2017年 well. All rights reserved.
//

#import "ViewController.h"
#import "LocationViewController.h"
#import "RouteViewController.h"
#import "CodingViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"LOCATION";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"简单定位";
            break;
        case 1:
            cell.textLabel.text = @"反编码";
            break;
        case 2:
            cell.textLabel.text = @"路线规划";
            break;
            
        default:
            break;
    }
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:[LocationViewController new] animated:NO];
            break;
        case 1:
            [self.navigationController pushViewController:[CodingViewController new] animated:NO];
            break;
        case 2:
            [self.navigationController pushViewController:[RouteViewController new] animated:NO];
            break;
            
        default:
            break;
    }
}


-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}



@end
