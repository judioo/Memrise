//
//  UIViewController+animateView.h
//  Memrise
//
//  Created by udo oji on 10/08/2012.
//  Copyright (c) 2012 fanstatsic.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (animateView)
- (void)animateViewUpFromBottom:(UIView *)sView withDelay:(double)delay;
- (void)animateViewDownFromTop:(UIView *)sView  withDelay:(double)delay;
- (void)animateShake:(UIView *)sView;
- (void)accessDenied:(UITapGestureRecognizer *)gesture;

@end
