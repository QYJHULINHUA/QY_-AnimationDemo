//
//  BIDPopStyle.m
//  CommunityHD
//
//  Created by ihefelocal001 on 16/3/30.
//  Copyright © 2016年 ihefe. All rights reserved.
//

#import "BIDPopStyle.h"

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
//
//- (void)setAnimationType:(PopAnimationType)animationType
//{
//    _animationType = animationType;
//    switch (_animationType) {
//        case PopAnimation_Transform:
//        {
//            _alignmentType = PopAlignmentType_Center;
//        }
//            break;
//        case PopAnimation_FromBottom:
//        case PopAnimation_FromTop:
//        {
//            _alignmentType = PopAlignmentType_HorizontallyCenter;
//        }
//            break;
//        case PopAnimation_FromLeft:
//        case PopAnimation_FromRight:
//        {
//            _alignmentType = PopAlignmentType_VerticalCenter;
//        }
//            break;
//        default:
//        {
//            _alignmentType = PopAlignmentType_AutoFram;
//        }
//            break;
//    }
//}


@end
