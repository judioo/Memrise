//
//  UIViewController+formatView.m
//  Memrise
//
//  Created by udo oji on 10/08/2012.
//  Copyright (c) 2012 fanstatsic.com. All rights reserved.
//

#import "UIViewController+formatView.h"
#import <QuartzCore/QuartzCore.h>


@implementation UIViewController (formatView)

- (void)roundViewsCorner:(UIView *)tView withRadius:(float)rad
{
    tView.layer.cornerRadius  = rad;
    tView.layer.masksToBounds = YES;
}

- (void)roundViewsBottomCorner:(UIView *)tView withRadius:(float)rad
{
    // http://www.iphonedevsdk.com/forum/iphone-sdk-development/95917-adding-rounded-corners-to-only-top-of-uitableview.html
    
    UIBezierPath *maskPath  = [UIBezierPath bezierPathWithRoundedRect:tView.bounds
                                                    byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight
                                                          cornerRadii:CGSizeMake(rad, rad)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame         = tView.bounds;
    maskLayer.path          = maskPath.CGPath;
    
    tView.layer.mask        = maskLayer;
}
@end
