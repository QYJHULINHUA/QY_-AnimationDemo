//
//  BIDPopViewAnimation.m
//  BIDPopView
//
//  Created by shengchu on 16/3/30.
//  Copyright (c) 2015年 zhanghongwei. All rights reserved.
//

#import "BIDPopAnimationView.h"

@implementation BIDPopStyle

- (id)init
{
    self = [super init];
    if (self) {
        self.animationType = PopAnimation_Transform;
        self.alignmentType = PopAlignmentType_Center;
        self.isHaveCancel = YES;
    }
    return self;
}

@end


@interface BIDPopAnimationView()


//弹出的 view
@property (nonatomic, strong) UIView *alertBg;
//弹出的 view 原始坐标
@property (nonatomic) CGRect alertBg_orginFram;
//弹出的 样式
@property (nonatomic, strong) BIDPopStyle *popStyle;


@end



@implementation BIDPopAnimationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (id)popAnimationView:(UIView*)view popStyle:(BIDPopStyle*)popStyle
{
    BIDPopAnimationView *popView = [[BIDPopAnimationView alloc] initAnimationView:view popStyle:popStyle];
    [popView clickShow];
    return popView;
}

- (id)initAnimationView:(UIView*)view popStyle:(BIDPopStyle*)popStyle
{
    self = [super init];
    if (self)
    {
        
        CGRect fram_old = view.frame;
        NSLog(@"alertBg Rect:%@",NSStringFromCGRect(fram_old));
        self.alertBg_orginFram = fram_old;
        
        self.alertBg = view;
        if (popStyle) {
            self.popStyle = popStyle;
        }
        else {
            self.popStyle = [[BIDPopStyle alloc] init];
        }
        
    }
    return self;
}


-(void)createBackgroundView
{
    // adding some styles to background view (behind table alert)
    self.frame = [[UIScreen mainScreen] bounds];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    self.opaque = NO;
    
    // adding it as subview of app's UIWindow
    UIWindow *appWindow = [[UIApplication sharedApplication] keyWindow];
    [appWindow addSubview:self];
    
    
    UIButton *canelBtn = [[UIButton alloc] initWithFrame:self.frame];
    canelBtn.backgroundColor = [UIColor clearColor];
    [canelBtn addTarget:self action:@selector(clickCancel) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:canelBtn];
}
- (void)removeSelf
{
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
    [self removeFromSuperview];
    
    //恢复原始位置
    self.alertBg.frame = self.alertBg_orginFram;
}

#pragma mark - 缩放弹出，带有震动效果
- (void)transformIn
{
    [self createBackgroundView];
    [self addSubview:self.alertBg];
    
    CGRect fram = self.alertBg.frame;
    fram.origin.x = (self.frame.size.width-fram.size.width)/2;
    fram.origin.y = (self.frame.size.height-fram.size.height)/2;
    self.alertBg.frame = fram;
    
#if 1
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    } completion:nil];
    
    
    self.alertBg.transform = CGAffineTransformMakeScale(0.5, 0.5);
    [UIView animateWithDuration:0.6 delay:0.0 usingSpringWithDamping:0.4 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alertBg.transform = CGAffineTransformIdentity;
    } completion:nil];
    
#else
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    self.alertBg.transform = CGAffineTransformMakeScale(0.6, 0.6);
    [UIView animateWithDuration:0.2 animations:^{
        self.alertBg.transform = CGAffineTransformMakeScale(1.1, 1.1);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    } completion:^(BOOL finished){
        [UIView animateWithDuration:1.0/15.0 animations:^{
            self.alertBg.transform = CGAffineTransformMakeScale(0.9, 0.9);
        } completion:^(BOOL finished){
            [UIView animateWithDuration:1.0/7.5 animations:^{
                self.alertBg.transform = CGAffineTransformMakeScale(1.0, 1.0);;
            }];
        }];
    }];
    
#endif
    
}
- (void)transformOut
{
    
    [UIView animateWithDuration:1.0/7.5 animations:^{
        self.alertBg.transform = CGAffineTransformMakeScale(0.9, 0.9);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0/15.0 animations:^{
            self.alertBg.transform = CGAffineTransformMakeScale(1.1, 1.1);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                self.alertBg.transform = CGAffineTransformMakeScale(0.01, 0.01);
                self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
            } completion:^(BOOL finished){
                [self removeSelf];
            }];
        }];
    }];

}

#pragma mark - 视图从下面往上弹出
- (void)popFromBottomIn
{
    [self createBackgroundView];
    [self addSubview:self.alertBg];
    
    //计算 垂直方向 弹出前的位置
    CGRect fram = [self verticalPopBeforeFrame];
    //计算 垂直方向 弹出后的位置
    CGRect fram1 = [self verticalPopLaterFrame];

    self.alertBg.frame = fram;
    [UIView animateWithDuration:0.5 animations:^{
        self.alertBg.frame = fram1;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    }];
    
}
- (void)popFromBottomOut
{
    //弹出之前的位置
    CGRect fram = self.alertBg.frame;
    fram.origin.y = self.frame.size.height;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.alertBg.frame = fram;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    } completion:^(BOOL finished) {
        [self removeSelf];
    }];
    
}

#pragma mark - 视图从上面往下弹出
- (void)popFromTopIn
{
    [self createBackgroundView];
    [self addSubview:self.alertBg];
    
    //计算 垂直方向 弹出前的位置
    CGRect fram = [self verticalPopBeforeFrame];
    //计算 垂直方向 弹出后的位置
    CGRect fram1 = [self verticalPopLaterFrame];
    self.alertBg.frame = fram;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.alertBg.frame = fram1;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    }];
    
}
- (void)popFromTopOut
{
    //弹出之前的位置
    CGRect fram = self.alertBg.frame;
    fram.origin.y = -fram.size.height;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.alertBg.frame = fram;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    } completion:^(BOOL finished) {
        [self removeSelf];
    }];
    
}

#pragma mark - 计算 垂直方向 弹出前的位置
- (CGRect)verticalPopBeforeFrame
{
    //弹出之前的位置
    CGRect fram = self.alertBg.frame;
    switch (self.popStyle.alignmentType) {
        case PopAlignmentType_Center:
        {
            fram.origin.x = (self.frame.size.width-fram.size.width)/2;
        }
            break;
        case PopAlignmentType_HorizontallyCenter:
        {
            fram.origin.x = (self.frame.size.width-fram.size.width)/2;
        }
            break;
        case PopAlignmentType_VerticalCenter:
        {
            fram.origin.x = fram.origin.x;
        }
            break;
        case PopAlignmentType_AutoFram:
        {
            //指定显示的位置
            fram.origin.x = fram.origin.x;
        }
            break;
        default:
            break;
    }
    if (self.popStyle.animationType == PopAnimation_FromBottom)
    {
        fram.origin.y = self.frame.size.height;
    }
    else if (self.popStyle.animationType == PopAnimation_FromTop)
    {
        fram.origin.y = -self.frame.size.height;
    }
    return fram;
}

#pragma mark - 计算 垂直方向 弹出后的位置
- (CGRect)verticalPopLaterFrame
{
    //弹出后的位置
    CGRect fram1 = self.alertBg.frame;
    switch (self.popStyle.alignmentType) {
        case PopAlignmentType_Center:
        {
            fram1.origin.x = (self.frame.size.width-fram1.size.width)/2;
            fram1.origin.y = (self.frame.size.height-fram1.size.height)/2;
        }
            break;
        case PopAlignmentType_HorizontallyCenter:
        {
            fram1.origin.x = (self.frame.size.width-fram1.size.width)/2;
            fram1.origin.y = fram1.origin.y;
        }
            break;
        case PopAlignmentType_VerticalCenter:
        {
            fram1.origin.x = fram1.origin.x;
            fram1.origin.y = (self.frame.size.height-fram1.size.height)/2;
        }
            break;
        case PopAlignmentType_AutoFram:
        {
            //指定显示的位置
            fram1.origin = fram1.origin;
        }
            break;
        default:
            break;
    }
    return fram1;
}


#pragma mark - 视图 从左 往右 弹出
- (void)popFromLeftIn
{
    [self createBackgroundView];
    [self addSubview:self.alertBg];
    
    //计算 水平方向 弹出前的位置
    CGRect fram = [self horizontallyPopBeforeFrame];
    //计算 水平方向 弹出后的位置
    CGRect fram1 = [self horizontallyPopLaterFrame];
    self.alertBg.frame = fram;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.alertBg.frame = fram1;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    }];

}
- (void)popFromLeftOut
{
    //弹出之前的位置
    CGRect fram = self.alertBg.frame;
    fram.origin.x = -fram.size.width;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.alertBg.frame = fram;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    } completion:^(BOOL finished) {
        [self removeSelf];
    }];
}
#pragma mark - 视图 从右 往左 弹出
- (void)popFromRightIn
{
    [self createBackgroundView];
    [self addSubview:self.alertBg];
    
    //计算 水平方向 弹出前的位置
    CGRect fram = [self horizontallyPopBeforeFrame];
    //计算 水平方向 弹出后的位置
    CGRect fram1 = [self horizontallyPopLaterFrame];
    self.alertBg.frame = fram;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.alertBg.frame = fram1;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    }];
    
}
- (void)popFromRightOut
{
    //弹出之前的位置
    CGRect fram = self.alertBg.frame;
    fram.origin.x = self.frame.size.width;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.alertBg.frame = fram;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    } completion:^(BOOL finished) {
        [self removeSelf];
    }];
}


#pragma mark - 计算 水平方向 弹出前 的位置
- (CGRect)horizontallyPopBeforeFrame
{
    //弹出之前的位置
    CGRect fram = self.alertBg.frame;
    switch (self.popStyle.alignmentType) {
        case PopAlignmentType_Center:
        {
            fram.origin.y = (self.frame.size.height-fram.size.height)/2;
        }
            break;
        case PopAlignmentType_HorizontallyCenter:
        {
            fram.origin.y = fram.origin.y;
        }
            break;
        case PopAlignmentType_VerticalCenter:
        {
            fram.origin.y = (self.frame.size.height-fram.size.height)/2;
        }
            break;
        case PopAlignmentType_AutoFram:
        {
            //指定显示的位置
            fram.origin.y = fram.origin.y;
        }
            break;
        default:
            break;
    }

    if (self.popStyle.animationType == PopAnimation_FromLeft)
    {
        fram.origin.x = -self.frame.size.width;
    }
    else if (self.popStyle.animationType == PopAnimation_FromRight)
    {
        fram.origin.x = self.frame.size.width;
    }

    return fram;
}
#pragma mark - 计算 水平方向 弹出后 的位置
- (CGRect)horizontallyPopLaterFrame
{
    //弹出后的位置
    CGRect fram = self.alertBg.frame;
    switch (self.popStyle.alignmentType) {
        case PopAlignmentType_Center:
        {
            fram.origin.x = (self.frame.size.width-fram.size.width)/2;
            fram.origin.y = (self.frame.size.height-fram.size.height)/2;
        }
            break;
        case PopAlignmentType_HorizontallyCenter:
        {
            fram.origin.x = (self.frame.size.width-fram.size.width)/2;
            fram.origin.y = fram.origin.y;
        }
            break;
        case PopAlignmentType_VerticalCenter:
        {
            fram.origin.x = fram.origin.x;
            fram.origin.y = (self.frame.size.height-fram.size.height)/2;
        }
            break;
        case PopAlignmentType_AutoFram:
        {
            //指定显示的位置
            fram.origin = fram.origin;
        }
            break;
        default:
            break;
    }

    return fram;
}

#pragma mark - 视图 淡入淡出
- (void)popCurveEaseIn
{
    [self createBackgroundView];
    [self addSubview:self.alertBg];
    
    //淡入淡出  弹出前 和 弹出后 的位置 一样
    //计算 弹出后的位置
    CGRect fram1 = [self curveEaseInOutPopLaterFrame];
    //计算 弹出前的位置
    CGRect fram = fram1;
    self.alertBg.frame = fram;
    
    
    self.alertBg.alpha = 0.2f;
    [UIView animateWithDuration:0.6f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        self.alertBg.alpha = 1.0f;
    } completion:^(BOOL finished) {
    }];
    
}
- (void)popCurveEaseOut
{
    [UIView animateWithDuration:0.6f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        self.alertBg.alpha = 0.2f;
    } completion:^(BOOL finished) {
        [self removeSelf];
    }];
}
#pragma mark - 计算 淡入淡出 弹出后 的位置
- (CGRect)curveEaseInOutPopLaterFrame
{
    //弹出后的位置
    CGRect fram = self.alertBg.frame;
    switch (self.popStyle.alignmentType) {
        case PopAlignmentType_Center:
        {
            fram.origin.x = (self.frame.size.width-fram.size.width)/2;
            fram.origin.y = (self.frame.size.height-fram.size.height)/2;
        }
            break;
        case PopAlignmentType_HorizontallyCenter:
        {
            fram.origin.x = (self.frame.size.width-fram.size.width)/2;
            fram.origin.y = fram.origin.y;
        }
            break;
        case PopAlignmentType_VerticalCenter:
        {
            fram.origin.x = fram.origin.x;
            fram.origin.y = (self.frame.size.height-fram.size.height)/2;
        }
            break;
        case PopAlignmentType_AutoFram:
        {
            fram.origin = fram.origin;
        }
            break;
        default:
            break;
    }
    
    return fram;
}

#pragma mark - 从左向右 展开
- (void)popExpandFromLeftIn
{
    [self createBackgroundView];
    [self addSubview:self.alertBg];
    
    //计算 展开 后的位置
    CGRect fram1 = [self horizontallyPopLaterFrame];
    //计算 展开 前的位置
    CGRect fram = fram1;
    fram.size.width = 0.0f;
    
    self.alertBg.frame = fram;
    
    [self.alertBg layoutIfNeeded];
    [UIView animateWithDuration:0.5 animations:^{
        self.alertBg.frame = fram1;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        
        [self.alertBg layoutIfNeeded];
    }];

}
- (void)popExpandFromLeftOut
{
    //展开前 的位置
    CGRect fram = self.alertBg.frame;
    fram.size.width = 0.0f;
    
    [self.alertBg layoutIfNeeded];
    [UIView animateWithDuration:0.5 animations:^{
        self.alertBg.frame = fram;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        
        [self.alertBg layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeSelf];
    }];
}

#pragma mark - 从右向左 展开
- (void)popExpandFromRightIn
{
    [self createBackgroundView];
    [self addSubview:self.alertBg];
    
    //计算 展开 后的位置
    CGRect fram1 = [self horizontallyPopLaterFrame];
    //计算 展开 前的位置
    CGRect fram = fram1;
    fram.origin.x += fram.size.width;
    fram.size.width = 0.0f;
    
    self.alertBg.frame = fram;
    
    [self.alertBg layoutIfNeeded];
    [UIView animateWithDuration:0.5 animations:^{
        self.alertBg.frame = fram1;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        
        [self.alertBg layoutIfNeeded];
    }];
    
}
- (void)popExpandFromRightOut
{
    //展开前 的位置
    CGRect fram = self.alertBg.frame;
    fram.origin.x += fram.size.width;
    fram.size.width = 0.0f;
    
    [self.alertBg layoutIfNeeded];
    [UIView animateWithDuration:0.5 animations:^{
        self.alertBg.frame = fram;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        [self.alertBg layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeSelf];
    }];
}

#pragma mark - 从下向上 展开
- (void)popExpandFromBottomIn
{
    [self createBackgroundView];
    [self addSubview:self.alertBg];
    
    //计算 展开 后的位置
    CGRect fram1 = [self verticalPopLaterFrame];
    //计算 展开 前的位置
    CGRect fram = fram1;
    fram.origin.y += fram.size.height;
    fram.size.height = 0.0f;
    
    self.alertBg.frame = fram;
    
    [self.alertBg layoutIfNeeded];
    [UIView animateWithDuration:0.5 animations:^{
        self.alertBg.frame = fram1;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        
        [self.alertBg layoutIfNeeded];
    }];
    
}
- (void)popExpandFromBottomOut
{
    //展开前 的位置
    CGRect fram = self.alertBg.frame;
    fram.origin.y += fram.size.height;
    fram.size.height = 0.0f;
    
    [self.alertBg layoutIfNeeded];
    [UIView animateWithDuration:0.5 animations:^{
        self.alertBg.frame = fram;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        
        [self.alertBg layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeSelf];
    }];
}

#pragma mark - 从上向下 展开
- (void)popExpandFromTopIn
{
    [self createBackgroundView];
    [self addSubview:self.alertBg];
    
    //计算 展开 后的位置
    CGRect fram1 = [self verticalPopLaterFrame];
    //计算 展开 前的位置
    CGRect fram = fram1;
    fram.size.height = 0.0f;
    
    self.alertBg.frame = fram;
    
    [self.alertBg layoutIfNeeded];
    [UIView animateWithDuration:0.5 animations:^{
        self.alertBg.frame = fram1;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        
        [self.alertBg layoutIfNeeded];
    }];
    
}
- (void)popExpandFromTopOut
{
    //展开前 的位置
    CGRect fram = self.alertBg.frame;
    fram.size.height = 0.0f;
    
    [self layoutIfNeeded];
    [UIView animateWithDuration:0.5 animations:^{
        self.alertBg.frame = fram;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        
        [self.alertBg layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeSelf];
    }];
}


#pragma mark - 点击背景 取消
- (void)clickCancel
{
    if (!self.popStyle.isHaveCancel) {
        return;
    }
    
    [self clickHidden];
}


#pragma mark - 控制视图的弹出和隐藏
- (void)clickShow
{
    switch (self.popStyle.animationType)
    {
        case PopAnimation_Transform: //带有 震动 缩放 效果 ***default
        {
            [self transformIn];
        }
            break;
        case PopAnimation_FromBottom: //从屏幕 下方弹出
        {
            [self popFromBottomIn];
        }
            break;
        case PopAnimation_FromTop: //从屏幕 上方弹出
        {
            [self popFromTopIn];
        }
            break;
        case PopAnimation_FromLeft: //从屏幕 左侧弹出
        {
            [self popFromLeftIn];
        }
            break;
        case PopAnimation_FromRight://从屏幕 右侧弹出
        {
            [self popFromRightIn];
        }
            break;
        case PopAnimation_CurveEaseInOut: //淡入淡出
        {
            [self popCurveEaseIn];
        }
            break;
        case PopAnimation_ExpandFromLeft: //从左向右  展开
        {
            [self popExpandFromLeftIn];
        }
            break;
        case PopAnimation_ExpandFromRight: //从右向左  展开
        {
            [self popExpandFromRightIn];
        }
            break;
        case PopAnimation_ExpandFromBottom: //从下向上  展开
        {
            [self popExpandFromBottomIn];
        }
            break;
        case PopAnimation_ExpandFromTop: //从上向下  展开
        {
            [self popExpandFromTopIn];
        }
            break;
        default:
            break;
    }
}
- (void)clickHidden
{
    switch (self.popStyle.animationType)
    {
        case PopAnimation_Transform:
        {
            [self transformOut];
        }
            break;
        case PopAnimation_FromBottom:
        {
            [self popFromBottomOut];
        }
            break;
        case PopAnimation_FromTop:
        {
            [self popFromTopOut];
        }
            break;
        case PopAnimation_FromLeft:
        {
            [self popFromLeftOut];
        }
            break;
        case PopAnimation_FromRight:
        {
            [self popFromRightOut];
        }
            break;
        case PopAnimation_CurveEaseInOut:
        {
            [self popCurveEaseOut];
        }
            break;
        case PopAnimation_ExpandFromLeft:
        {
            [self popExpandFromLeftOut];
        }
            break;
        case PopAnimation_ExpandFromRight:
        {
            [self popExpandFromRightOut];
        }
            break;
        case PopAnimation_ExpandFromBottom:
        {
            [self popExpandFromBottomOut];
        }
            break;
        case PopAnimation_ExpandFromTop:
        {
            [self popExpandFromTopOut];
        }
            break;
        default:
            break;
    }
}


@end
