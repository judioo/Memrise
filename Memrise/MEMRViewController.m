//
//  MEMRViewController.m
//  Memrise
//
//  Created by udo oji on 10/08/2012.
//  Copyright (c) 2012 fanstatsic.com. All rights reserved.
//

#import "MEMRViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>

#define kWelcomeView 1

@interface MEMRViewController () {
    SystemSoundID magicChimesID;

}
@property (nonatomic, strong) UIView *welcomeView;

@end

@implementation MEMRViewController
@synthesize welcomeView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configureWelcomeView];
    [self configureSound];
    [self animateUp:self.welcomeView];
    
}

- (void)configureWelcomeView
{
    self.welcomeView = [self.view viewWithTag:kWelcomeView];
    
    self.welcomeView.layer.cornerRadius  = 26.0f;
    self.welcomeView.layer.masksToBounds = YES;
    
    UIImage *image  = [UIImage imageNamed:@"hills.png"];
    UIImageView *imageView  = [[UIImageView alloc] initWithImage:image];
    
    [self.welcomeView addSubview:imageView];
    [self.welcomeView sendSubviewToBack:imageView];
 
}

- (void)animateUp:(UIView *)tView
{
    // if the passed view does not have a superview return
    if(!tView.superview)
        return;
    
    CGRect currentRect  = [tView frame];
    int bottom          = tView.superview.bounds.size.height;
    
    tView.frame         = CGRectMake(
                                     currentRect.origin.x, 
                                     bottom, 
                                     currentRect.size.width, 
                                     currentRect.size.height);
    
    [self welcomeSound];
    [UIView animateWithDuration:1.0 animations:^{
        tView.frame  = currentRect;
    }];
    
    
}

- (void)welcomeSound
{
    AudioServicesPlayAlertSound(magicChimesID);
}

- (void)configureSound {
    CFBundleRef mainbundle      = CFBundleGetMainBundle();
    CFURLRef magicChimeSoundURL = CFBundleCopyResourceURL(mainbundle, 
                                                          CFSTR("chimes"), 
                                                          CFSTR("mp3"),
                                                          NULL);
    
    AudioServicesCreateSystemSoundID(magicChimeSoundURL,&magicChimesID);
    
    CFRelease(magicChimeSoundURL);
}


- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)dealloc {
    AudioServicesDisposeSystemSoundID(magicChimesID);
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
