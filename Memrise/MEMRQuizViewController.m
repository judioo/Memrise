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

@synthesize questionsDictionary;
@synthesize allPossibleQuestions;
@synthesize answerToQuestion;

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

- (void)loadQuestions
{
    NSBundle *bundle    = [NSBundle mainBundle];
    NSURL *plistURL     = [bundle URLForResource:@"questions"
                                   withExtension:@"plist"];
    
    self.questionsDictionary    = [NSDictionary
                                   dictionaryWithContentsOfURL:plistURL];
    self.allPossibleQuestions   = [[NSArray alloc]
                                   initWithArray:[self.questionsDictionary allKeys]];
}

- (void)configureQuestion
{
    [self loadQuestions];
    
    int seed                = [self.allPossibleQuestions count];
    int index               = arc4random() % seed;

    NSString *question      = [self.allPossibleQuestions objectAtIndex:index];
    self.questionLabel.text = question;
    
    NSArray *pAnswersArray  = [self.questionsDictionary objectForKey:question];
    self.answerToQuestion   = [pAnswersArray objectAtIndex:0];
    
    NSMutableSet *possibleAnswers  = [[NSMutableSet alloc] initWithArray:pAnswersArray];
    [self populatePossibleAnswers:possibleAnswers];
}

- (void)populatePossibleAnswers:(NSMutableSet *)pAnswers
{
    [self populatePossibleAnswerLabel:pAnswers forLabel:answer1Label];
    [self populatePossibleAnswerLabel:pAnswers forLabel:answer2Label];
    [self populatePossibleAnswerLabel:pAnswers forLabel:answer3Label];
    [self populatePossibleAnswerLabel:pAnswers forLabel:answer4Label];
    [self populatePossibleAnswerLabel:pAnswers forLabel:answer5Label];
    [self populatePossibleAnswerLabel:pAnswers forLabel:answer6Label];
}

- (void)populatePossibleAnswerLabel:(NSMutableSet *)pAnswers forLabel:(UILabel *)label
{
    NSString *anAnswer = [pAnswers anyObject];
    if (!anAnswer)
        return;
    
    label.text  = anAnswer;
    
    [pAnswers removeObject:anAnswer];
}


- (void)startQuiz
{
    [self loadQuestions];
    [self configureQuestion];
    
    
    [self animateViewRandomly:self.questionView withDelay:kViewAnimationDelay];
    [self animateViewRandomly:self.answer1View withDelay:kViewAnimationDelay];
    [self animateViewRandomly:self.answer2View withDelay:kViewAnimationDelay];
    [self animateViewRandomly:self.answer3View withDelay:kViewAnimationDelay];
    [self animateViewRandomly:self.answer4View withDelay:kViewAnimationDelay];
    [self animateViewRandomly:self.answer5View withDelay:kViewAnimationDelay];
    [self animateViewRandomly:self.answer6View withDelay:kViewAnimationDelay];
    
    [self attachViewRecognizer:answer1View];
    [self attachViewRecognizer:answer2View];
    [self attachViewRecognizer:answer3View];
    [self attachViewRecognizer:answer4View];
    [self attachViewRecognizer:answer5View];
    [self attachViewRecognizer:answer6View];
}

- (void)isAnswerCorrect:(UIGestureRecognizer *)gesture
{
    UIView *sView   = [gesture view];
    UILabel *sLabel = [sView.subviews objectAtIndex:0];
    
    if ([self.answerToQuestion isEqualToString:sLabel.text]) {
        // match
        sView.backgroundColor   = [UIColor greenColor];
        sView.
    } else {
        sView.backgroundColor   = [UIColor redColor];
    }
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

- (void)attachViewRecognizer:(UIView *)sView
{   
    UITapGestureRecognizer *guesture        = [[UITapGestureRecognizer alloc]
                                               initWithTarget:self action:@selector(isAnswerCorrect:)];
    
    
    [sView addGestureRecognizer:guesture];    
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
