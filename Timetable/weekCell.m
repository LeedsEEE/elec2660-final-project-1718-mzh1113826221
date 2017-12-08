//
//  weekCell.m
//  Project
//
//  Created by mac on 2017/11/30.
//  Copyright © 2017年 University of Leeds. All rights reserved.
//

#import "weekCell.h"
#import "Utils.h"

@implementation weekCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.label = [[UILabel alloc] init];
        _label.textAlignment =NSTextAlignmentCenter;
        _label.textColor = [Utils colorWithHexString:@"#44acf3"];
        _label.layer.cornerRadius = 5;
        _label.layer.masksToBounds = true;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:_label];
    }
    return self;
}

-(void)layoutSubviews{
    NSLog(@"%f %f",CGRectGetWidth(self.contentView.bounds),CGRectGetHeight(self.contentView.bounds));
    _label.frame = CGRectMake(6, 0, CGRectGetWidth(self.contentView.bounds)-12, CGRectGetHeight(self.contentView.bounds));
}

@end
