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

@end


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
    
    [self configureSound];
    [self animateIn:welcomeView];
    
}

- (void)animateIn:(UIView *)tView
{
    CGRect currentRect  = [tView frame];
    int bottom          = self.view.bounds.size.height;
    
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
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
