//
//  TagResuableView.m
//  Project
//
//  Created by mac on 2017/11/30.
//  Copyright © 2017年 University of Leeds. All rights reserved.
//

#import "TagResuableView.h"
#import "Utils.h"

@implementation TagResuableView
-(instancetype)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
        self.num = [[UILabel alloc] initWithFrame:self.bounds];
        _num.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_num];
        self.layer.borderWidth = 0.24;
        self.layer.borderColor = [Utils colorWithHexString:@"#6f6c69"].CGColor;
        
    }
    return self;
}
@end
