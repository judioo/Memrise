//
//  MEMRQuizViewController.m
//  Memrise
//
//  Created by udo oji on 11/08/2012.
//  Copyright (c) 2012 fanstatsic.com. All rights reserved.
//

#import "MEMRQuizViewController.h"
#import "UIViewController+formatView.h"
#import "UIViewController+animateView.h"


#define kAnswerCornerRadius     10
#define kQuestionCornerRadius   20
#define kViewAnimationDelay     0.9

@interface MEMRQuizViewController ()

@end

@implementation MEMRQuizViewController
@synthesize questionView;
@synthesize questionLabel;
@synthesize answer1View;
@synthesize answer1Label;
@synthesize answer2View;
@synthesize answer2Label;
@synthesize answer3View;
@synthesize answer3Label;
@synthesize answer4View;
@synthesize answer4Label;
@synthesize answer5View;
@synthesize answer5Label;
@synthesize answer6View;
@synthesize answer6Label;

@synthesize homeView;
@synthesize CommunityView;
@synthesize topicsView;
@synthesize aboutView;
@synthesize profileView;


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
    [self configureHome];
    [self startQuiz];
}


- (void)startQuiz
{
    [self animateViewRandomly:self.questionView withDelay:kViewAnimationDelay];
    [self animateViewRandomly:self.answer1View withDelay:kViewAnimationDelay];
    [self animateViewRandomly:self.answer2View withDelay:kViewAnimationDelay];
    [self animateViewRandomly:self.answer3View withDelay:kViewAnimationDelay];
    [self animateViewRandomly:self.answer4View withDelay:kViewAnimationDelay];
    [self animateViewRandomly:self.answer5View withDelay:kViewAnimationDelay];
    [self animateViewRandomly:self.answer6View withDelay:kViewAnimationDelay];
}

- (void)pushView
{
    [self performSegueWithIdentifier:@"quizToChoiceSegue" sender:self];
}

- (void)configureHome
{
    UITapGestureRecognizer *homeTap        = [[UITapGestureRecognizer alloc]
                                               initWithTarget:self action:@selector(pushView)];
    
    [self.homeView addGestureRecognizer:homeTap];   
}
     
- (void)formatMenuViews
{
    // menu views
    [self roundViewsBottomCorner:self.homeView withRadius:5.0f];
    [self roundViewsBottomCorner:self.CommunityView withRadius:5.0f];
    [self roundViewsBottomCorner:self.topicsView withRadius:5.0f];
    [self roundViewsBottomCorner:self.aboutView withRadius:5.0f];
    [self roundViewsBottomCorner:self.profileView withRadius:5.0f];
    
    // question and answer views
    [self roundViewsCorner:self.questionView withRadius:kQuestionCornerRadius];
    [self roundViewsCorner:self.answer1View withRadius:kAnswerCornerRadius];
    [self roundViewsCorner:self.answer2View withRadius:kAnswerCornerRadius];
    [self roundViewsCorner:self.answer3View withRadius:kAnswerCornerRadius];
    [self roundViewsCorner:self.answer4View withRadius:kAnswerCornerRadius];
    [self roundViewsCorner:self.answer5View withRadius:kAnswerCornerRadius];
    [self roundViewsCorner:self.answer6View withRadius:kAnswerCornerRadius];
}

- (void)configureTouch
{
    [self setMenuAsDenied:self.profileView];
    [self setMenuAsDenied:self.CommunityView];
    [self setMenuAsDenied:self.topicsView];
    [self setMenuAsDenied:self.aboutView];
}


- (void)viewDidUnload
{
    [self setQuestionView:nil];
    [self setQuestionLabel:nil];
    [self setAnswer1View:nil];
    [self setAnswer1Label:nil];
    [self setAnswer2View:nil];
    [self setAnswer2Label:nil];
    [self setAnswer3View:nil];
    [self setAnswer3Label:nil];
    [self setAnswer4View:nil];
    [self setAnswer4Label:nil];
    [self setAnswer5View:nil];
    [self setAnswer5Label:nil];
    [self setAnswer6View:nil];
    [self setAnswer6Label:nil];
    [self setProfileView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
