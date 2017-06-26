//
//  CodingViewController.m
//  WellMap
//
//  Created by 同筑科技 on 2017/6/26.
//  Copyright © 2017年 well. All rights reserved.
//

#import "CodingViewController.h"
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件

@interface CodingViewController ()<BMKGeoCodeSearchDelegate>

@property (nonatomic, strong)  BMKGeoCodeSearch *geocodesearch;

@end

@implementation CodingViewController


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
        
//        static dispatch_once_t onceToken;
//        dispatch_once(&onceToken, ^{
            // 设置屏幕中心点
            BMKCoordinateRegion region;
            region.center.latitude = userLocation.location.coordinate.latitude;
            region.center.longitude = userLocation.location.coordinate.longitude;
            self.mapView.region = region;
            
            //反向地理编码
            NSString *latitude = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude];
            NSString *longitude = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude];
            [self reverseGeoCodeWithLatitude:latitude withLongitude:longitude];
//        });
    }
    [self.locService stopUserLocationService];//关闭坐标更新
}

#pragma mark ----反向地理编码
- (void)reverseGeoCodeWithLatitude:(NSString *)latitude withLongitude:(NSString *)longitude
{
    CLLocationCoordinate2D coor;
    coor.latitude = [latitude doubleValue];
    coor.longitude = [longitude doubleValue];
    
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc] init];
    reverseGeocodeSearchOption.reverseGeoPoint = coor;
    BOOL flag = [self.geocodesearch reverseGeoCode:reverseGeocodeSearchOption];;
    if (flag)
    {
        NSLog(@"反地理编码成功");//可注释
    }
    else
    {
        NSLog(@"反地理编码失败");//可注释
    }
}

#pragma mark -BMKGeoCodeSearchDelegate
//根据 经纬度 获取 地区信息
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR)
    {
        NSString *address = result.address;
        //        result.addressDetail ///层次化地址信息
        NSLog(@"我的位置在 %@",address);
    }
    else
    {
        NSLog(@"未找到结果 %u",error);
    }
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ----懒加载

//检索对象
- (BMKGeoCodeSearch *)geocodesearch
{
    if (!_geocodesearch)
    {
        _geocodesearch = [[BMKGeoCodeSearch alloc] init];
        _geocodesearch.delegate = self;
    }
    return _geocodesearch;
}

@end
