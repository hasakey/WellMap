//
//  BaseMapView.m
//  WellMap
//
//  Created by 同筑科技 on 2017/6/26.
//  Copyright © 2017年 well. All rights reserved.
//

#import "BaseMapView.h"

@interface BaseMapView ()

@end

@implementation BaseMapView

#pragma mark ----视图将要出现,将要消失方法
- (void)viewWillAppear:(BOOL)animated
{
    [self.mapView viewWillAppear];
    self.mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
- (void)viewWillDisappear:(BOOL)animated
{
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil; // 不用时，置nil
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"简单定位";
    self.view.backgroundColor = [UIColor whiteColor];
    self.view = self.mapView;
    [self.locService startUserLocationService];  //开启定位
}

#pragma mark ----懒加载
//地图
- (BMKMapView *)mapView
{
    if (!_mapView) {
        _mapView = [[BMKMapView alloc] initWithFrame:self.view.frame];
        [_mapView setZoomEnabled:YES];
        [_mapView setZoomLevel:18];//放大级别，3-19
        _mapView.showMapScaleBar = YES;//比例尺
        _mapView.mapScaleBarPosition = CGPointMake(10,_mapView.frame.size.height-45);//比例尺的位置
        _mapView.showsUserLocation=YES;//显示当前设备的位置
        //        _mapView.userTrackingMode = BMKUserTrackingModeFollow;//定位跟随模式
        [_mapView setMapType:BMKMapTypeStandard];//地图的样式(标准地图)
    }
    return _mapView;
}

//地图定位
- (BMKLocationService *)locService
{
    if (!_locService)
    {
        _locService = [[BMKLocationService alloc] init];
        _locService.delegate = self;
    }
    return _locService;
}


@end
