//
//  LocationViewController.m
//  WellMap
//
//  Created by 同筑科技 on 2017/6/26.
//  Copyright © 2017年 well. All rights reserved.
//

#import "LocationViewController.h"

@interface LocationViewController ()

@end

@implementation LocationViewController

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
    
    if ((userLocation.location.coordinate.latitude != 0 || userLocation.location.coordinate.longitude != 0))
    {
        [self.mapView updateLocationData:userLocation];
        
//        static dispatch_once_t onceToken;
//        dispatch_once(&onceToken, ^{
            // 设置屏幕中心点
//            BMKCoordinateRegion region;
//            region.center.latitude = userLocation.location.coordinate.latitude;
//            region.center.longitude = userLocation.location.coordinate.longitude;
//            self.mapView.region = region;
//        });
        
        //如果不是第一次初始化视图, 那么定位点置中
        if (self.isNotFirstInit == NO)
        {
            self.mapView.centerCoordinate = self.locService.userLocation.location.coordinate;
            self.isNotFirstInit = YES;
        }
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




@end
