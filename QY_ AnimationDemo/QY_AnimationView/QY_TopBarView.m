//
//  QY_TopBarView.m
//  QY_ AnimationDemo
//
//  Created by ihefe－hulinhua on 16/4/8.
//  Copyright © 2016年 ihefe_hlh. All rights reserved.
//

#import "QY_TopBarView.h"

@implementation QY_TopBarView


+(instancetype)getInstanceWithTitleStr:(NSString *)titleStr
{
    QY_TopBarView *containerView = [[QY_TopBarView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH ,60) withTitle:titleStr];
    
    return containerView;
}

- (id)initWithFrame:(CGRect)frame withTitle:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor cyanColor];
        if (title) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 40)];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = title;
            [self addSubview:label];
        }
        
    }
    
    return self;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
