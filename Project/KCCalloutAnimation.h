//
//  KCCallOutAnimation.h
//  OrientationMap
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 University of Leeds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface KCCalloutAnnotation : NSObject<MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy,readonly) NSString *title;
@property (nonatomic, copy,readonly) NSString *subtitle;

#pragma mark 左侧图标
@property (nonatomic,strong) UIImage *icon;
#pragma mark 详情描述
@property (nonatomic,copy) NSString *detail;
#pragma mark 星级评价
@property (nonatomic,strong) UIImage *rate;

@end
