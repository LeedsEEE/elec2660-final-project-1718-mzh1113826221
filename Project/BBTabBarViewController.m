//
//  BBTabBarViewController.m
//  Project
//
//  Created by mac on 2017/11/22.
//  Copyright © 2017年 University of Leeds. All rights reserved.
//

#import "BBTabBarViewController.h"
#import "MapViewController.h"
#import "MajorViewController.h"
#import "CourseViewController.h"


@interface BBTabBarViewController ()

@end

@implementation BBTabBarViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set item properties
    [self setupItem];
    
    // add all subcontrollers
    [self setupChildVcs];
}

/**
 * add all subcontrollers
 */
- (void)setupChildVcs
{
    [self setupChildVc:[[MajorViewController alloc] init] title:@"Major Information" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    [self setupChildVc:[[CourseViewController alloc] init] title:@"Timetable" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    [self setupChildVc:[[MapViewController alloc] init] title:@"Map" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
}

/**
 * add one subcontroller
 * @param title message
 * @param image image
 * @param selectedImage selected image
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // add a mapcontroller
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
    
    // set the subcontroller of tabBarItem
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:image];
    nav.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
}


/**
 * set item properties
 */
- (void)setupItem
{
    // UIControlStateNormalmessage properties
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    // message colour
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    // message size
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    
    // UIControlStateSelectedmessage properties
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    // message colour
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    // Set literal properties for all UITabBarItem
    // Only the following attributes or methods with UI_APPEARANCE_SELECTOR can be set up by the appearance object
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
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
