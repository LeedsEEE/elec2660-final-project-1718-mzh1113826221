//
//  CourseCell.h
//  Project
//
//  Created by mac on 2017/11/30.
//  Copyright © 2017年 University of Leeds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseModel.h"

@interface CourseCell : UICollectionViewCell
@property(nonatomic,strong)UILabel*course;
@property(nonatomic,strong)CourseModel*model;
@end
