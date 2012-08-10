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
    [self welcomeSound];
    [self animateViewUpFromBottom:self.welcomeView withDelay:1.0];
}
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
