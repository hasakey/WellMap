//
//  BaseMapView.h
//  WellMap
//
//  Created by 同筑科技 on 2017/6/26.
//  Copyright © 2017年 well. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

@interface BaseMapView : UIViewController<BMKMapViewDelegate,BMKLocationServiceDelegate>

@property (nonatomic, strong)BMKMapView *mapView;                           //百度地图视图
@property (nonatomic, strong)BMKLocationService*locService;
@property(nonatomic,assign)BOOL isNotFirstInit;

@end
