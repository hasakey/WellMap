//
//  ViewController.m
//  WellMap
//
//  Created by 同筑科技 on 2017/6/23.
//  Copyright © 2017年 well. All rights reserved.
//

#import "ViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
@interface ViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate>
//百度地图
@property (nonatomic, strong)BMKMapView *mapView;                           //百度地图视图
@property (nonatomic, strong)BMKLocationService*locService;
@property (nonatomic, strong)NSTimer *timer;

@end

@implementation ViewController




- (void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
- (void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}

-(void)dealloc
{
    [self.timer invalidate];
    if (self.timer) {
        self.timer = nil;
    }
}

#pragma mark ----加载视图
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view = self.mapView;
    [self.locService startUserLocationService];  //开启定位
    //添加定时器
    self.timer = [NSTimer timerWithTimeInterval:3.0f target:self selector:@selector(startUserLocationService) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

#pragma mark ----BMK_LocationDelegate
/**
 *定位失败后，会调用此函数
 *@param error 错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"地图定位失败======%@",error);
}
//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    NSLog(@"heading = %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    //更新一次地图的位置 (只执行一次)
    if ((userLocation.location.coordinate.latitude != 0 || userLocation.location.coordinate.longitude != 0))
    {
        [self.mapView updateLocationData:userLocation];
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            // 设置屏幕中心点
            BMKCoordinateRegion region;
            region.center.latitude = userLocation.location.coordinate.latitude;
            region.center.longitude = userLocation.location.coordinate.longitude;
            self.mapView.region = region;
        });
    }
    [self.locService stopUserLocationService];//关闭坐标更新
}

#pragma mark ----BMKMapViewDelegate
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        //添加大头针标注
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
}

#pragma mark ----METHODS
-(void)startUserLocationService
{
    
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
