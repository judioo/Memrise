//
//  UIViewController+animateView.m
//  Memrise
//
//  Created by udo oji on 10/08/2012.
//  Copyright (c) 2012 fanstatsic.com. All rights reserved.
//

#import "UIViewController+animateView.h"

@implementation UIViewController (animateView)

- (void)animateViewUpFromBottom:(UIView *)sView withDelay:(double)delay
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
    
    [UIView animateWithDuration:delay animations:^{
        sView.frame  = currentRect;
    }];
    
    
}

- (void)animateViewDownFromTop:(UIView *)sView withDelay:(double)delay
{
    if(!sView.superview)
        return;
    
    CGRect currentRect  = [sView frame];
    
    // superviews y cords minus sView's height
    int top             = sView.superview.bounds.origin.y - 
                            currentRect.size.height;
    
    sView.frame         = CGRectMake(
                                     currentRect.origin.x, 
                                     top, 
                                     currentRect.size.width, 
                                     currentRect.size.height);
    
    [UIView animateWithDuration:delay animations:^{
        sView.frame  = currentRect;
    }];
}

@end
