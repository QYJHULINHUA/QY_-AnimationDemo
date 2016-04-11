//
//  QY_TopBarView.h
//  QY_ AnimationDemo
//
//  Created by ihefe－hulinhua on 16/4/8.
//  Copyright © 2016年 ihefe_hlh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QY_TopBarView : UIView

#define getQY_TopBarViewInstancetype(tiltle) \
[QY_TopBarView getInstanceWithTitleStr:tiltle]


+(instancetype)getInstanceWithTitleStr:(NSString *)titleStr;

@end
