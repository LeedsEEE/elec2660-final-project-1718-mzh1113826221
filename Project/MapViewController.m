//
//  MapViewController.m
//  SchoolApp
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 University of Leeds. All rights reserved.
//

#import "MapViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "KCAnnotation.h"
#import "KCCalloutAnimationView.h"
#import "KCMapModel.h"


@interface MapViewController ()<MKMapViewDelegate,CLLocationManagerDelegate>{
    CLLocationManager *_locationManager;
    MKMapView *_mapView;
    //    CLLocationCoordinate2D currentLocation;
    KCAnnotation *currentAnnotation;
    
}

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Map";
    self.view.backgroundColor = [UIColor redColor];
    
    NSMutableArray *dataArr = [NSMutableArray array];
    
    for (int i = 0; i<10; i++) {
        KCMapModel *model = [[KCMapModel alloc]init];
        model.title = [NSString stringWithFormat:@"我的%d",i];
        model.subTitle = [NSString stringWithFormat:@"CSX定位测试%d",i];
        model.latitudef = 30.25;
        model.longitudef = 120.15-0.1*i;
        model.iconName = @"dingwei1";
        model.picName = @"dingwei";
        model.detailStr = [NSString stringWithFormat:@"曹世鑫定位测试%d",i];
        model.rateStr = @"dingwei2";
        [dataArr addObject:model];
    }
    
    self.arr = dataArr;

}

#pragma mark 添加地图控件
-(void)initGUI{
    CGRect rect=[UIScreen mainScreen].bounds;
    _mapView=[[MKMapView alloc]initWithFrame:rect];
    [self.view addSubview:_mapView];
    //设置代理
    _mapView.delegate=self;
    
    CLLocationManager *locationManager = [[CLLocationManager alloc]init];
    locationManager.delegate = self;
    //请求定位服务
    _locationManager=[[CLLocationManager alloc]init];
    if(![CLLocationManager locationServicesEnabled]||[CLLocationManager authorizationStatus]!=kCLAuthorizationStatusAuthorizedWhenInUse){
        [_locationManager requestWhenInUseAuthorization];
    }
    
    
    //用户位置追踪(用户位置追踪用于标记用户当前位置，此时会调用定位服务)
    _mapView.userTrackingMode=MKUserTrackingModeFollow;
    
    //设置地图类型
    _mapView.mapType=MKMapTypeStandard;
    
    
    //添加大头针
    //    [self addAnnotation];
}
- (void)setArr:(NSMutableArray *)arr{
    if (_arr!=arr) {
        _arr=arr;
    }
    [self initGUI];
    [self nearbyPointWithArr:_arr];
}
- (void)nearbyPointWithArr:(NSMutableArray *)arr{
    if (arr.count>0) {
        for (int i = 0; i<arr.count; i++) {
            KCMapModel *model = arr[i];
            CLLocationCoordinate2D location1=CLLocationCoordinate2DMake(model.latitudef, model.longitudef);
            KCAnnotation *annotation1=[[KCAnnotation alloc]init];
            annotation1.title=model.title;
            annotation1.subtitle=model.subTitle;
            annotation1.coordinate=location1;
            annotation1.image = [UIImage imageNamed:model.picName];
            annotation1.icon=[UIImage imageNamed:model.iconName];
            annotation1.detail=model.detailStr;
            
            annotation1.rate=[UIImage imageNamed:model.rateStr];
            [_mapView addAnnotation:annotation1];
        }
    }
}

//- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
//    currentLocation = newLocation;
//}


#pragma mark - 地图控件代理方法
#pragma mark 显示大头针时调用，注意方法中的annotation参数是即将显示的大头针对象
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    //由于当前位置的标注也是一个大头针，所以此时需要判断，此代理方法返回nil使用默认大头针视图
    if ([annotation isKindOfClass:[KCAnnotation class]]) {
        static NSString *key1=@"AnnotationKey1";
        MKAnnotationView *annotationView=[_mapView dequeueReusableAnnotationViewWithIdentifier:key1];
        //如果缓存池中不存在则新建
        if (!annotationView) {
            annotationView=[[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:key1];
            //            annotationView.canShowCallout=true;//允许交互点击
            annotationView.calloutOffset=CGPointMake(0, 1);//定义详情视图偏移量
            annotationView.leftCalloutAccessoryView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dingwei"]];//定义详情左侧视图
        }
        
        //修改大头针视图
        //重新设置此类大头针视图的大头针模型(因为有可能是从缓存池中取出来的，位置是放到缓存池时的位置)
        annotationView.annotation=annotation;
        annotationView.image=((KCAnnotation *)annotation).image;//设置大头针视图的图片
        
        return annotationView;
    }else if([annotation isKindOfClass:[KCCalloutAnnotation class]]){
        //对于作为弹出详情视图的自定义大头针视图无弹出交互功能（canShowCallout=false，这是默认值），在其中可以自由添加其他视图（因为它本身继承于UIView）
        KCCalloutAnnotationView *calloutView=[KCCalloutAnnotationView calloutViewWithMapView:mapView];
        calloutView.annotation=annotation;
        
        [calloutView getReturnMark:^(NSString *mark) {
            NSLog(@"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!%@",mark);
            
            //            [[XWLocationManager sharedXWLocationManager] getCurrentLocation:^(CLLocation *location, CLPlacemark *placeMark, NSString *error) {
            //                if (error) {
            //                    NSLog(@"定位出错,错误信息:%@",error);
            //                }else{
            //                    NSLog(@"定位成功:经度:%f 纬度:%lf 当前地址:%@  \n location详细信息:%@ \n ",location.coordinate.latitude, location.coordinate.longitude, placeMark.name, location);
            //                    [self.userLocationInfo setText:[NSString stringWithFormat:@"定位成功:经度:%f 纬度:%lf 当前地址:%@  \n location详细信息:%@ \n ",location.coordinate.latitude, location.coordinate.longitude, placeMark.name, location]];
            
            NSDictionary *options=@{MKLaunchOptionsMapTypeKey:@(MKMapTypeStandard),MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving};
            CLLocationCoordinate2D location1=_mapView.userLocation.location.coordinate;
            MKPlacemark *mapMark1 = [[MKPlacemark alloc]initWithCoordinate:location1];
            
            //                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"我的位置" message:[NSString stringWithFormat:@"位置经度：%f,位置纬度：%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude] preferredStyle:UIAlertControllerStyleActionSheet];
            //                    UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil];
            //                    [alert addAction:action];
            
            MKMapItem *myPosition = [[MKMapItem alloc]initWithPlacemark:mapMark1];
            
            myPosition.name = @"我的位置";
            
            CLLocationCoordinate2D location2=currentAnnotation.coordinate;
            MKPlacemark *mapMark = [[MKPlacemark alloc]initWithCoordinate:location2];
            MKMapItem *targetPosition = [[MKMapItem alloc]initWithPlacemark:mapMark];
            targetPosition.name = currentAnnotation.title;
            [MKMapItem openMapsWithItems:@[myPosition,targetPosition] launchOptions:options];
            
            //                }
            //            } onViewController:self];
            //
            //
        }];
        
        return calloutView;
        
    } else {
        return nil;
    }
}

#pragma mark 选中大头针时触发
//点击一般的大头针KCAnnotation时添加一个大头针作为所点大头针的弹出详情视图
-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    //获取当前点击的大头针的全部信息
    currentAnnotation=view.annotation;
    //    currentLocation = annotation.coordinate;
    if ([view.annotation isKindOfClass:[KCAnnotation class]]) {
        //点击一个大头针时移除其他弹出详情视图
        //        [self removeCustomAnnotation];
        //添加详情大头针，渲染此大头针视图时将此模型对象赋值给自定义大头针视图完成自动布局
        KCCalloutAnnotation *annotation1=[[KCCalloutAnnotation alloc]init];
        annotation1.icon=currentAnnotation.icon;
        annotation1.detail=currentAnnotation.detail;
        annotation1.rate=currentAnnotation.rate;
        annotation1.coordinate=view.annotation.coordinate;
        [mapView addAnnotation:annotation1];
    }
}

#pragma mark 取消选中时触发
-(void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view{
    [self removeCustomAnnotation];
}

#pragma mark 移除所用自定义大头针
-(void)removeCustomAnnotation{
    [_mapView.annotations enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[KCCalloutAnnotation class]]) {
            [_mapView removeAnnotation:obj];
        }
    }];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
