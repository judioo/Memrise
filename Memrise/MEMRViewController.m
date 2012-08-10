//
//  MEMRViewController.m
//  Memrise
//
//  Created by udo oji on 10/08/2012.
//  Copyright (c) 2012 fanstatsic.com. All rights reserved.
//

#import "MEMRViewController.h"
#import <QuartzCore/QuartzCore.h>

#define kWelcomeView 1

@interface MEMRViewController ()

@end

@implementation MEMRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView *welcomeView = [self.view viewWithTag:kWelcomeView];
    
    welcomeView.layer.cornerRadius  = 26.0f;
    welcomeView.layer.masksToBounds = YES;
    
    UIImage *image  = [UIImage imageNamed:@"hills.png"];
    UIImageView *imageView  = [[UIImageView alloc] initWithImage:image];
    
    [welcomeView addSubview:imageView];
    [welcomeView sendSubviewToBack:imageView];
    
}

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
