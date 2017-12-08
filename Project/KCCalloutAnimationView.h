//
//  KCCalloutAnimationView.h
//  OrientationMap
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 University of Leeds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "KCCalloutAnimation.h"

typedef void (^ReturnMark)(NSString *mark);

@interface KCCalloutAnnotationView : MKAnnotationView

@property (nonatomic ,strong) KCCalloutAnnotation  *annotation;

@property(copy,nonatomic)ReturnMark markAble;

#pragma mark 从缓存取出标注视图
+(instancetype)calloutViewWithMapView:(MKMapView *)mapView;


- (void)getReturnMark:(ReturnMark)mark;

@end
