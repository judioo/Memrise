//
//  UIViewController+animateView.m
//  Memrise
//
//  Created by udo oji on 10/08/2012.
//  Copyright (c) 2012 fanstatsic.com. All rights reserved.
//

#import "UIViewController+animateView.h"

#define kShakeWidth 10

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

- (void)animateViewLeftFromSide:(UIView *)sView  withDelay:(double)delay
{
    if(!sView.superview)
        return;
    
    CGRect currentRect  = [sView frame];
    
    // superviews x cords minus sView's width
    int left            = sView.superview.bounds.origin.x - 
    currentRect.size.width;
    
    sView.frame         = CGRectMake(
                                     left, 
                                     currentRect.origin.y, 
                                     currentRect.size.width, 
                                     currentRect.size.height);
    
    [UIView animateWithDuration:delay animations:^{
        sView.frame  = currentRect;
    }];
}

- (void)animateViewRightFromSide:(UIView *)sView  withDelay:(double)delay
{
    if(!sView.superview)
        return;
    
    CGRect currentRect  = [sView frame];
    
    // superviews x cords minus sView's width
    int right           = sView.superview.bounds.origin.x + 
    sView.superview.bounds.size.width;
    
    sView.frame         = CGRectMake(
                                     right, 
                                     currentRect.origin.y, 
                                     currentRect.size.width, 
                                     currentRect.size.height);
    
    [UIView animateWithDuration:delay animations:^{
        sView.frame  = currentRect;
    }];
}

- (void)animateViewRandomly:(UIView *)sView withDelay:(double)delay
{
    int choice  = arc4random() % 4;
    switch (choice) {
        case 0:
            [self animateViewUpFromBottom:sView withDelay:delay];
            break;
        case 1:
            [self animateViewDownFromTop:sView withDelay:delay];
            break;
        case 2:
            [self animateViewLeftFromSide:sView withDelay:delay];
            break;
        case 3:
            [self animateViewRightFromSide:sView withDelay:delay];
            break;
        default:
            break;
    }
}


- (void)animateShake:(UIView *)sView
{
    CGRect currentRect  = [sView frame];
    
    CGAffineTransform leftShake     = CGAffineTransformTranslate(CGAffineTransformIdentity, 
                                                                 -kShakeWidth, 
                                                                 sView.frame.origin.y);

    CGAffineTransform rightShake    = CGAffineTransformTranslate(CGAffineTransformIdentity, 
                                                                 kShakeWidth, 
                                                                 sView.frame.origin.y);
    
    sView.transform = leftShake;
    
    [UIView beginAnimations:@"accessDenied" context:NULL];
    [UIView setAnimationRepeatAutoreverses:YES];
    
    [UIView setAnimationRepeatCount:2];
    [UIView setAnimationDuration:0.07];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animateShakeEnd:finished:context:)];
    
    sView.transform = rightShake; 
    
    [UIView commitAnimations];
    
    sView.frame = currentRect;
}

- (void)earthquakeEnded:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context 
{
    if ([finished boolValue]) 
    {
        UIView* item = (__bridge UIView *)context;
        item.transform = CGAffineTransformIdentity;
    }
}

- (void)accessDenied:(UITapGestureRecognizer *)gesture
{
    [self animateShake:gesture.view];
}



@end
