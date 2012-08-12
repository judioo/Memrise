//
//  MEMRQuizViewController.h
//  Memrise
//
//  Created by udo oji on 11/08/2012.
//  Copyright (c) 2012 fanstatsic.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MEMRQuizViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *questionView;
@property (strong, nonatomic) IBOutlet UILabel *questionLabel;


@property (strong, nonatomic) IBOutlet UIView *answer1View;
@property (strong, nonatomic) IBOutlet UILabel *answer1Label;

@property (strong, nonatomic) IBOutlet UIView *answer2View;
@property (strong, nonatomic) IBOutlet UILabel *answer2Label;

@property (strong, nonatomic) IBOutlet UIView *answer3View;
@property (strong, nonatomic) IBOutlet UILabel *answer3Label;

@property (strong, nonatomic) IBOutlet UIView *answer4View;
@property (strong, nonatomic) IBOutlet UILabel *answer4Label;

@property (strong, nonatomic) IBOutlet UIView *answer5View;
@property (strong, nonatomic) IBOutlet UILabel *answer5Label;

@property (strong, nonatomic) IBOutlet UIView *answer6View;
@property (strong, nonatomic) IBOutlet UILabel *answer6Label;


@property (strong, nonatomic) IBOutlet UIView *homeView;
@property (strong, nonatomic) IBOutlet UIView *CommunityView;
@property (strong, nonatomic) IBOutlet UIView *topicsView;
@property (strong, nonatomic) IBOutlet UIView *aboutView;
@property (strong, nonatomic) IBOutlet UIView *profileView;



@end
