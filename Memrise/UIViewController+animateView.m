//
//  UIViewController+animateView.m
//  Memrise
//
//  Created by udo oji on 10/08/2012.
//  Copyright (c) 2012 fanstatsic.com. All rights reserved.
//

#import "UIViewController+animateView.h"

@implementation UIViewController (animateView)

- (void)animateViewUpFromBottom:(UIView *)sView
{
    // if the passed view does not have a superview return
    if(!sView.superview)
        return;
    
    CGRect currentRect  = [sView frame];
    int bottom          = sView.superview.bounds.size.height;
    
    sView.frame         = CGRectMake(
                                     currentRect.origin.x, 
                                     bottom, 
                                     currentRect.size.width, 
                                     currentRect.size.height);
    
    [UIView animateWithDuration:1.0 animations:^{
        sView.frame  = currentRect;
    }];
    
    
}

- (void)animateViewDownFromTop:(UIView *)sView
{
    
}

@end
