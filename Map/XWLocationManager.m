//
//  XWLocationManger.m
//  Project
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 University of Leeds. All rights reserved.
//  

#import "XWLocationManager.h"


#define isIOS(version) ([[UIDevice currentDevice].systemVersion floatValue] >= version)

@interface XWLocationManager ()<CLLocationManagerDelegate>{
    UIAlertController *AV;
}

/** Locating block objects */
@property (nonatomic, copy) ResultLocationInfoBlock locationBlock;

/** Locating block objects */
@property (nonatomic, copy) ResultLocationBlock locationOnlyBlock;

/** Location manager */
@property (nonatomic, strong) CLLocationManager *locationManager;

/** Reverse geographically coded Manager */
@property (nonatomic, strong) CLGeocoder *geocoder;

@end

@implementation XWLocationManager
//Single object
single_implementation(XWLocationManager)

#pragma mark - Delayed loading
-(CLLocationManager *)locationManager{
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
        [_locationManager setDelegate:self];
        if (isIOS(8)) {
            //Request authorization here
            //1. get the project configuration ->plist file
            NSDictionary *infoPlistDict = [[NSBundle mainBundle] infoDictionary];
            //2. get the location permission set in the current project
            NSString *always = [infoPlistDict objectForKey:@"NSLocationAlwaysUsageDescription"];
            NSString *whenInUse = [infoPlistDict objectForKey:@"NSLocationWhenInUseUsageDescription"];
            //If the developer sets the background location mode->
            if (always.length > 0) {
                [_locationManager requestAlwaysAuthorization];
            }else if (whenInUse.length > 0){
                [_locationManager requestWhenInUseAuthorization];
                // In the foreground location authorization state, the background mode location udpates must be selected to obtain user location information
                NSArray *services = [infoPlistDict objectForKey:@"UIBackgroundModes"];
                if (![services containsObject:@"location"]) {
                    NSLog(@"Friendship hint: the current status is the front desk position authorization state, if you want to get the user location information in the background, you must check the background mode. location updates");
                }else{
                    if (isIOS(9.0)) {
                        _locationManager.allowsBackgroundLocationUpdates = YES;
                    }
                }
            }else{
                NSLog(@"Error - if you are positioned after iOS8.0, you must be in info.plist, configure NSLocationWhenInUseUsageDescription or NSLocationAlwaysUsageDescription");
            }
        }
    }
    return _locationManager;
}
-(CLGeocoder *)geocoder{
    if (_geocoder == nil) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}

/**
 *  Obtaining user location information directly through a block of code
 *
 *  @param block Locate the block code block
 */
-(void)getCurrentLocation:(ResultLocationInfoBlock)block onViewController:(UIViewController *)viewController{
    //Record code block
    self.locationBlock = block;
    //Location update frequency->
    [self.locationManager setDistanceFilter:100];
    //Determine the current location permissions and start - > location
    [self startLocationOnViewController:viewController];
}

/**
 *  Obtaining user location information directly through a block of code
 *
 *  @param block Locate the block code block
 */
//-(void)getCurrentLocationOnly:(ResultLocationBlock)block onViewController:(UIViewController *)viewController{
//    //record code block
//    self.locationOnlyBlock = block;
//    //location update frequency->
//    [self.locationManager setDistanceFilter:100];
//    //Determine the current location permissions and start - > location
//    [self startLocationOnViewController:viewController];
//}

//location
-(void)startLocationOnViewController:(UIViewController *)viewController{
    
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"The location service may not be open at the moment, please set it open!");
        dispatch_async(dispatch_get_main_queue(), ^{
            AV = [UIAlertController alertControllerWithTitle:@"Hint" message:@"The location service may not be open at the moment, please set it open!" preferredStyle:UIAlertControllerStyleAlert];
            [AV addAction:[UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil]];
            [AV addAction:[UIAlertAction actionWithTitle:@"open" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([[UIApplication sharedApplication] canOpenURL:url]) {
                    [[UIApplication sharedApplication] openURL: url];
                }
                [_locationManager startUpdatingLocation];
            }]];
            [viewController presentViewController:AV animated:YES completion:nil];
        });
        return;
    }
    //User authorization is requested if no authorization is available
    if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined){
        [_locationManager requestWhenInUseAuthorization];
        //Start up tracking
        [_locationManager startUpdatingLocation];
    }else if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedAlways ){
        //Start up tracking
        [_locationManager startUpdatingLocation];
    }else{
        // Skip core code
        dispatch_async(dispatch_get_main_queue(), ^{
            AV = [UIAlertController alertControllerWithTitle:@"Hint" message:@"The location service may not be open at the moment, please set it open!" preferredStyle:UIAlertControllerStyleAlert];
            [AV addAction:[UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil]];
            [AV addAction:[UIAlertAction actionWithTitle:@"open" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([[UIApplication sharedApplication] canOpenURL:url]) {
                    [[UIApplication sharedApplication] openURL: url];
                }
                [_locationManager startUpdatingLocation];
            }]];
            [viewController presentViewController:AV animated:YES completion:nil];
        });
    }
}

#pragma mark - CLLocationManagerDelegate 
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *location = [locations lastObject];
    //It means that the horizontal accuracy. understood that it is the radius of the center of coordinate, and the smaller the return value, the better the accuracy of the proof. If it is a negative number, it means corelocation location failure.
    if (location.horizontalAccuracy < 0) {
        NSLog(@"location.horizontalAccuracy:%f,定位失败!!!!",location.horizontalAccuracy);
        return;
    }else{
        //Direct afferent coordinates
//        self.locationOnlyBlock(location);
        // Here, there is no geographical location to get to the landmark object, so here, it is necessary to further carry out anti geo coding.
        [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
            if (error == nil) {
                // Acquisition of landmark objects
                CLPlacemark *placemark = [placemarks firstObject];
                // Here, it is best to execute the stored code block
                self.locationBlock(location, placemark, nil);
            }else{
                self.locationBlock(location, nil, error.localizedDescription);
            }
        }];
    }
    //Stop positioning->
    [_locationManager stopUpdatingLocation];
}

@end
