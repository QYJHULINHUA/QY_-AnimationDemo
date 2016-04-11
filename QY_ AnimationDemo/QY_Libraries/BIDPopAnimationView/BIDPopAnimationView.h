//
//  BIDPopViewAnimation.h
//  BIDPopView
//
//  Created by shengchu on 16/3/30.
//  Copyright (c) 2015年 zhanghongwei. All rights reserved.
//

#import <UIKit/UIKit.h>
//页面弹出样式
#import "BIDPopStyle.h"


/*  使用方法参考如下：
 
 //for test
 - (void)popDemo
 {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.backgroundColor = [UIColor redColor];
 
    BIDPopStyle *pop = [[BIDPopStyle alloc] init];
    pop.animationType = PopAnimation_FromBottom;
    pop.alignmentType = PopAlignmentType_Center;
    [BIDPopAnimationView popAnimationView:view popStyle:pop];
 }
 
 */


@interface BIDPopAnimationView : UIView

+ (id)popAnimationView:(UIView*)view popStyle:(BIDPopStyle*)popStyle;

- (void)clickShow;
- (void)clickHidden;

@end













