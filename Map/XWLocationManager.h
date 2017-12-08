//
//  XWLocationManger.h
//  Project
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 University of Leeds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "Singleton.h"
#import <UIKit/UIKit.h>

/**
 *  Location block block
 *
 *  @param location  Current location object
 *  @param placeMark Anti geographically coded object
 *  @param error     error message
 */
typedef void(^ResultLocationInfoBlock)(CLLocation *location, CLPlacemark *placeMark, NSString *error);

/**
 *  Locate the block block (only the latitude and longitude coordinates)
 *
 *  @param location  current location object
 *  @param error     error message
 */
typedef void(^ResultLocationBlock)(CLLocation *location);



@interface XWLocationManager : NSObject
//Single object
single_interface(XWLocationManager)


/**
 *  Obtaining user location information directly through a block of code
 *
 *  @param block Locate the block code block
 */
-(void)getCurrentLocation:(ResultLocationInfoBlock)block onViewController:(UIViewController *)viewController;

/**
 *  Obtaining user location information directly through a block of code
 *
 *  @param block Locate the block code block
 */
//-(void)getCurrentLocationOnly:(ResultLocationBlock)block onViewController:(UIViewController *)viewController;

@end
