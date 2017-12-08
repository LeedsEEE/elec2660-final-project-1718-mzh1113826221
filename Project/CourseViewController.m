//
//  CourseViewController.m
//  SchoolApp
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 University of Leeds. All rights reserved.
//

#import "CourseViewController.h"
#import "CourseViewCell.h"


// 屏幕尺寸相关
#define kScreenBounds [[UIScreen mainScreen] bounds]
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

NSString *const kBBCourseViewCellID   = @"kBBCourseViewCellID";

@interface CourseViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *m_TableView;

@end

@implementation CourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Course";
    self.view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.m_TableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark --
#pragma mark -- 表代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CourseViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kBBCourseViewCellID forIndexPath:indexPath];
    return cell;
}


#pragma mark --
#pragma mark --
- (UITableView *)m_TableView{
    if(!_m_TableView){
        _m_TableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _m_TableView.delegate = self;
        _m_TableView.dataSource = self;
        _m_TableView.rowHeight = 150;
        //        _m_TableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_m_TableView registerNib:[UINib nibWithNibName:@"CourseViewCell" bundle:nil] forCellReuseIdentifier:kBBCourseViewCellID];
        
    }
    return _m_TableView;
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
