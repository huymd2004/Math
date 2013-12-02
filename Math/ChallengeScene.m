//
//  ChallengeScene.m
//  Math
//
//  Created by Johan Stenberg on 2013-11-03.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import "ChallengeScene.h"

#import "CoreDataUtils.h"

#import "Profile.h"

#import "WorldScene.h"

#import "QuestionScene.h"

#import "UIUtils.h"

#import "GenMathInterface.h"

@implementation ChallengeScene

-(id) initWithChallenge: (Challenge *) challenge
{
    if (self = [super init])
    {
        _challenge = challenge;
        [self setupLayout:challenge];
    }
    
    return self;
}

-(void) setupLayout: (Challenge *) challenge
{
    [UIUtils addDrawingPadBackground:self];
    
    CoreDataUtils *coreDataUtils = [CoreDataUtils getInstance];
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    CCLayer *layer = [[CCLayer alloc] init];
    
    NSString *sceneTitleString = [NSString stringWithFormat:@"Welcome to %@", challenge.name];
    CCLabelTTF *sceneTitleLabel = [UIUtils createGloriaHallelujahTitle:sceneTitleString];
    [layer addChild:sceneTitleLabel];
    
    Profile *profile = [coreDataUtils getCurrentProfile];
    
    ProfileChallengeScore *score = [coreDataUtils getProfileChallengeScore:profile challenge:challenge];
    
    if (score != nil)
    {
        NSString *highScoreString =
            [NSString stringWithFormat:@"Highscore for this challenge\n is %@", score.score];
        CCLabelTTF *highScoreLabel = [UIUtils createGloriaHallelujahSubTitle:highScoreString];
        [layer addChild:highScoreLabel];
    }
    
    CCControlButton *playButton = [UIUtils createBlackBoardButton:30 andText:@"Play"];
    playButton.position = ccp(winSize.width/2, winSize.height/2);
    
    [playButton setBlock:^(id sender, CCControlEvent event)
     {
         [self playMenuItemSelected:challenge];
     } forControlEvents:CCControlEventTouchUpInside];
    
    [layer addChild:playButton];
    
    CCControlButton *backButton = [UIUtils createBackButton];
    
    [backButton addTarget:self
                   action:@selector(backMenuItemSelected:)
         forControlEvents:CCControlEventTouchDown];
    
    [layer addChild:backButton];
    [self addChild:layer];
}

-(void) playMenuItemSelected: (Challenge *) challenge
{
    NSArray *questions = [GenMathInterface getQuestionsForChallenge:challenge];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                                               transitionWithDuration:1.0 scene:[[QuestionScene alloc] initWithQuestions:questions andQuestionIndex:0 andChallenge:challenge andScore:0]]];
}

-(void) backMenuItemSelected: (Challenge *) challenge
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                                               transitionWithDuration:1.0 scene:[[WorldScene alloc] initWithWorld:challenge.world]]];
}

@end
