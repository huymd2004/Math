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

#import "StringUtils.h"

#import "CountdownScene.h"

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
    
    NSString *sceneTitleString = [StringUtils getWelcomeToLevel:challenge.name];
    CCLabelTTF *sceneTitleLabel = [UIUtils createGloriaHallelujahTitle:sceneTitleString];
    [layer addChild:sceneTitleLabel];
    
    Profile *profile = [coreDataUtils getCurrentProfile];
    
    ProfileChallengeScore *score = [coreDataUtils getProfileChallengeScore:profile challenge:challenge];
    
    if (score != nil)
    {
        NSString *highScoreString = [StringUtils getCurrentChallengeHighScore:score.score];
        CCControlButton *highScoreLabel = [UIUtils createBlackBoardLabel:36 andText:highScoreString];
        highScoreLabel.position = ccp(winSize.width/2, (winSize.height*1)/5);
        [layer addChild:highScoreLabel];
    }
    
    CCControlButton *playButton = [UIUtils createBlackBoardButton:40 andText:[StringUtils getPlayString]];
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
    QuestionScene *questionScene = [[QuestionScene alloc] initWithQuestions:questions andQuestionIndex:0 andChallenge:challenge andScore:[[NSNumber alloc] initWithInt:0]];
    CountdownScene *challengeScene =
        [[CountdownScene alloc] initWithQuestionScene:questionScene andIsPaused:NO];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                                               transitionWithDuration:1.0 scene:challengeScene]];
}

-(void) backMenuItemSelected:(id) sender
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                transitionWithDuration:1.0 scene:[[WorldScene alloc] initWithWorld:_challenge.world]]];
}

@end
