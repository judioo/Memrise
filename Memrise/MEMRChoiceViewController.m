//
//  MEMRChoiceViewController.m
//  Memrise
//
//  Created by udo oji on 10/08/2012.
//  Copyright (c) 2012 fanstatsic.com. All rights reserved.
//

#import "MEMRChoiceViewController.h"
#import "UIViewController+animateView.h"

@interface MEMRChoiceViewController ()
@end

@implementation MEMRChoiceViewController
@synthesize homeView;
@synthesize CommunityView;
@synthesize topicsView;
@synthesize aboutView;
@synthesize profileView;
@synthesize SpanishImage;
@synthesize SpanishLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureTouch];
    [self animateViewDownFromTop:self.homeView withDelay:0.5];
    [self animateViewDownFromTop:self.CommunityView withDelay:0.6];
    [self animateViewDownFromTop:self.topicsView withDelay:0.7];
    [self animateViewDownFromTop:self.aboutView withDelay:0.8];
    [self animateViewDownFromTop:self.profileView withDelay:0.9];
}

- (void)configureTouch
{
    [self setMenuAsDenied:self.homeView];
    [self setMenuAsDenied:self.CommunityView];
    [self setMenuAsDenied:self.topicsView];
    [self setMenuAsDenied:self.aboutView];
}

- (void)setMenuAsDenied:(UIView *)dView
{
    // views cannot share an instance of a gesture recognizer
    UITapGestureRecognizer *failedtap             = [[UITapGestureRecognizer alloc]
                                                     initWithTarget:self action:@selector(accessDenied:)];
    [dView addGestureRecognizer:failedtap];
}

- (void)accessDenied:(UITapGestureRecognizer *)gesture
{
    [self animateShake:gesture.view];
}

- (void)viewDidUnload
{
    [self setHomeView:nil];
    [self setCommunityView:nil];
    [self setTopicsView:nil];
    [self setAboutView:nil];
    [self setProfileView:nil];
    [self setSpanishImage:nil];
    [self setSpanishLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
