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
#define kCorrectImageTag        1
#define kIncorrectImageTag      2

@interface MEMRQuizViewController ()
@property (strong, nonatomic) UIImage *correctImage;
@property (strong, nonatomic) UIImage *incorrectImage;

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
@synthesize askedQuestions;

@synthesize correctImage;
@synthesize incorrectImage;

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
    self.askedQuestions     = [NSMutableArray array];
    
    [super viewDidLoad];
    [self loadImages];
    [self addImagesToAnswerViews];
    [self loadQuestions];

    [self formatMenuViews];
    [self configureTouch];
    [self configureHome];
    [self startQuiz];
}

- (void)loadImages
{
    self.correctImage   = [UIImage imageNamed:@"correct.png"];
    self.incorrectImage = [UIImage imageNamed:@"incorrect.png"];
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
    int seed                = [self.allPossibleQuestions count];
    int index               = arc4random() % seed;
    NSString *question      = [self.allPossibleQuestions objectAtIndex:index];
    
    // check that we have not seen all the questions
    if ([self.askedQuestions count] == [self.allPossibleQuestions count]) {
        [self.askedQuestions removeAllObjects];
        NSLog(@"resetting askedQuestions to empty");
    }
    
    // have we asked this question before
    for (NSString *previouslyAskedQuestion in self.askedQuestions) {
        if ([previouslyAskedQuestion isEqualToString:question]) {
            [self configureQuestion];
            return;
        }
    }
    
    // if here we have never asked this question
    [self.askedQuestions addObject:question];
    
    NSArray *pAnswersArray  = [self.questionsDictionary objectForKey:question];
    NSString *correctAnswer = [pAnswersArray objectAtIndex:0];
    
    self.questionLabel.text = question;
    self.answerToQuestion   = correctAnswer;
    
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
    if (![pAnswers count])
        return;
    
    int number          = arc4random() % [pAnswers count];
    NSString *anAnswer  = [[pAnswers allObjects] objectAtIndex:number];
    
    label.text  = anAnswer;
    
    [pAnswers removeObject:anAnswer];
}


- (void)startQuiz
{
    [self resetAllAnswersViews];
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
        [self displayView:sView withTag:kCorrectImageTag];
        [self performSelector:@selector(startQuiz) 
                   withObject:nil 
                   afterDelay:2.0];
    } else {
        sView.backgroundColor   = [UIColor redColor];
        [self displayView:sView withTag:kIncorrectImageTag];
    }
}

- (void)displayView:(UIView *)sView withTag:(int)number
{
    [[sView viewWithTag:number] setHidden:NO];
}

- (void)addImagesToAnswerViews
{
    [self addImage:self.correctImage toView:self.answer1View withTag:kCorrectImageTag];
    [self addImage:self.correctImage toView:self.answer2View withTag:kCorrectImageTag];
    [self addImage:self.correctImage toView:self.answer3View withTag:kCorrectImageTag];
    [self addImage:self.correctImage toView:self.answer4View withTag:kCorrectImageTag];
    [self addImage:self.correctImage toView:self.answer5View withTag:kCorrectImageTag];
    [self addImage:self.correctImage toView:self.answer6View withTag:kCorrectImageTag];

    [self addImage:self.incorrectImage toView:self.answer1View withTag:kIncorrectImageTag];
    [self addImage:self.incorrectImage toView:self.answer2View withTag:kIncorrectImageTag];
    [self addImage:self.incorrectImage toView:self.answer3View withTag:kIncorrectImageTag];
    [self addImage:self.incorrectImage toView:self.answer4View withTag:kIncorrectImageTag];
    [self addImage:self.incorrectImage toView:self.answer5View withTag:kIncorrectImageTag];
    [self addImage:self.incorrectImage toView:self.answer6View withTag:kIncorrectImageTag];
}

- (void)resetAllAnswersViews
{
    [self resetView:self.answer1View];
    [self resetView:self.answer2View];
    [self resetView:self.answer3View];
    [self resetView:self.answer4View];
    [self resetView:self.answer5View];
    [self resetView:self.answer6View];
}

- (void)resetView:(UIView *)sView
{
    sView.backgroundColor   = [UIColor whiteColor];
    [[sView viewWithTag:kCorrectImageTag] setHidden:YES];
    [[sView viewWithTag:kIncorrectImageTag] setHidden:YES];
}

- (void)addImageToView:(UIView *)sView 
{
    [self addImage:self.incorrectImage toView:sView withTag:kIncorrectImageTag];
    [self addImage:self.correctImage toView:sView withTag:kCorrectImageTag];
}

- (void)addImage:(UIImage *)image toView:(UIView *)sView withTag:(int)number
{
    UIImageView *iv = [[UIImageView alloc]
                       initWithImage:image];
    iv.frame        = CGRectMake(sView.bounds.size.width - 44, 
                                 0,44, 44);
    iv.tag          = number;

    
    [sView addSubview:iv];
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
