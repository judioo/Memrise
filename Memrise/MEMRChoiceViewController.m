//
//  MEMRChoiceViewController.m
//  Memrise
//
//  Created by udo oji on 10/08/2012.
//  Copyright (c) 2012 fanstatsic.com. All rights reserved.
//

#import "MEMRChoiceViewController.h"
#import "UIViewController+animateView.h"
#import "UIViewController+formatView.h"

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
    [self formatMenuViews];
    [self configureTouch];
    [self setImageLink];
    [self animateViews];
}

- (void)setImageLink
{
    self.SpanishImage.userInteractionEnabled    = YES;
    self.SpanishLabel.userInteractionEnabled    = YES;

    
    UITapGestureRecognizer *ImageTap        = [[UITapGestureRecognizer alloc]
                                               initWithTarget:self action:@selector(pushView)];
    
    UITapGestureRecognizer *labelTap        = [[UITapGestureRecognizer alloc]
                                               initWithTarget:self action:@selector(pushView)];

    [self.SpanishImage addGestureRecognizer:ImageTap];
    [self.SpanishLabel addGestureRecognizer:labelTap];

}

- (void)pushView
{
    [self performSegueWithIdentifier:@"choiceToQuizSegue" sender:self];
}


- (void)formatMenuViews
{
    [self roundViewsBottomCorner:self.homeView withRadius:5.0f];
    [self roundViewsBottomCorner:self.CommunityView withRadius:5.0f];
    [self roundViewsBottomCorner:self.topicsView withRadius:5.0f];
    [self roundViewsBottomCorner:self.aboutView withRadius:5.0f];
    [self roundViewsBottomCorner:self.profileView withRadius:5.0f];
}

- (void)animateViews 
{
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
