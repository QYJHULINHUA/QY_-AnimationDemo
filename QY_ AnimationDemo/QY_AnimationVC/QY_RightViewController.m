//
//  QY_RightViewController.m
//  QY_ AnimationDemo
//
//  Created by ihefe－hulinhua on 16/4/8.
//  Copyright © 2016年 ihefe_hlh. All rights reserved.
//

#import "QY_RightViewController.h"

@interface QY_RightViewController ()

@end

@implementation QY_RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:getQY_TopBarViewInstancetype(@"")];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc
{
    NSLog(@"rigthVC ___dealloc");
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
