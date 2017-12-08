//
//  CourseModel.h
//  Project
//
//  Created by mac on 2017/11/30.
//  Copyright © 2017年 University of Leeds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CourseModel : NSObject
@property(nonatomic,copy)NSString*courseName;
@property(nonatomic,strong)NSString*colors;
@property(nonatomic,assign)NSInteger weekDay;
@property(nonatomic,assign)NSInteger end;
@property(nonatomic,assign)NSInteger start;
@end
