//
//  BIDPopStyle.h
//  CommunityHD
//
//  Created by ihefelocal001 on 16/3/30.
//  Copyright © 2016年 ihefe. All rights reserved.
//

#import <Foundation/Foundation.h>


//弹出动画
typedef NS_ENUM(NSInteger, PopAnimationType)
{
    PopAnimation_Transform = 0, //带有 震动 缩放 效果 ***default
    PopAnimation_FromBottom,    //从屏幕 下方弹出
    PopAnimation_FromTop,       //从屏幕 上方弹出
    PopAnimation_FromLeft,      //从屏幕 左侧弹出
    PopAnimation_FromRight,     //从屏幕 右侧弹出
    PopAnimation_CurveEaseInOut,    //淡入淡出
    PopAnimation_ExpandFromLeft,    //从左向右  展开
    PopAnimation_ExpandFromRight,   //从右向左  展开
    PopAnimation_ExpandFromBottom,  //从下向上  展开
    PopAnimation_ExpandFromTop,     //从上向下  展开
};

//弹出后显示方式，根据此值 计算最终显示位置
typedef NS_ENUM(NSInteger, PopAlignmentType)
{
    PopAlignmentType_AutoFram = 0,      //根据frame显示
    PopAlignmentType_HorizontallyCenter,//水平居中显示
    PopAlignmentType_VerticalCenter,    //垂直居中显示
    PopAlignmentType_Center             //水平居中显示 //垂直居中显示 ***default
};


@interface BIDPopStyle : NSObject

//弹出动画
@property (nonatomic, assign) PopAnimationType animationType;

//对齐方式，
@property (nonatomic, assign) PopAlignmentType alignmentType;

//是否有 点击背景 取消功能 (默认有)
@property (nonatomic, assign) BOOL isHaveCancel;


@end
























