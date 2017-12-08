//
//  KCMapModel.h
//  OrientationMap
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 University of Leeds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KCMapModel : NSObject

//主标题
@property(nonatomic,copy)NSString *title;
//副标题
@property(nonatomic,copy)NSString *subTitle;
//纬度
@property(nonatomic,assign)float latitudef;
//经度
@property(nonatomic,assign)float longitudef;
//大头针左侧的详情图片名称
@property(nonatomic,copy)NSString *picName;
//大头针详情左侧图标
@property(nonatomic,copy)NSString *iconName;
//详情信息
@property(nonatomic,copy)NSString *detailStr;
//星级显示
@property(nonatomic,copy)NSString *rateStr;

@end
