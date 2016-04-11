//
//  ViewController.m
//  QY_ AnimationDemo
//
//  Created by ihefe－hulinhua on 16/4/8.
//  Copyright © 2016年 ihefe_hlh. All rights reserved.
//

#import "ViewController.h"
#import "BIDPopAnimationView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(200, 200, 50, 50)];
    btn.backgroundColor = [UIColor greenColor];
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}


-(void)clickBtn:(UIButton *)btn
{
    [self popDemo];
}

- (void)popDemo
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
