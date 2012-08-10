//
//  UIViewController+formatView.h
//  Memrise
//
//  Created by udo oji on 10/08/2012.
//  Copyright (c) 2012 fanstatsic.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (formatView)
- (void)roundViewsCorner:(UIView *)tView withRadius:(float)rad;
- (void)roundViewsBottomCorner:(UIView *)tView withRadius:(float)rad;
@end
