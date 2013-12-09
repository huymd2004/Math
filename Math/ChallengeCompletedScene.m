//
//  ChallengeCompletedScene.m
//  Math
//
//  Created by Johan Stenberg on 2013-11-07.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import "ChallengeCompletedScene.h"

#import "MainMenuScene.h"

#import "QuestionScene.h"

#import "CoreDataUtils.h"

#import "Profile.h"

#import "WorldScene.h"

#import "ChallengeScene.h"

#import "Universe.h"

#import "GameCompletedScene.h"

#import "UIUtils.h"

#import "GenMathInterface.h"

#import "StringUtils.h"

@implementation ChallengeCompletedScene

-(id) initWithChallenge: (Challenge *) challenge andScore: (NSNumber *) score
{
    if (self = [super init])
    {
        [self setupLayout:challenge andScore:score];
    }
    
    return self;
}

-(void) setupLayout: (Challenge *) challenge andScore: (NSNumber *) score
{
    [UIUtils addDrawingPadBackground:self];
    
    CoreDataUtils *coreDataUtils = [CoreDataUtils getInstance];
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    CCLayer *layer = [[CCLayer alloc] init];
    
    World *world = challenge.world;
    Challenge *worldsLastChallenge = world.challenges[world.challenges.count - 1];
    BOOL completedWorld = [worldsLastChallenge.name isEqualToString: challenge.name];

    NSString *sceneTitleString = [StringUtils getCompletedString:completedWorld ? world.name : challenge.name];
    CCLabelTTF *sceneTitleLabel = [UIUtils createGloriaHallelujahTitle:sceneTitleString];
    [layer addChild:sceneTitleLabel];
    
    Profile *profile = [coreDataUtils getCurrentProfile];
    
    if ([coreDataUtils saveProfileChallengeScore:profile withChallenge:challenge andScore:score])
    {
        NSString *highScoreString = [StringUtils getCompletedChallengeOrWorldNewHighscoreString:challenge.name andScore:score];
        CCLabelTTF *highScoreLabel = [UIUtils createGloriaHallelujahSubTitle:highScoreString];
        [layer addChild:highScoreLabel];
    }
    
    if (completedWorld)
    {
        NSNumber *worldScore = 0;
        
        for (Challenge *worldChallenge in world.challenges)
        {
            ProfileChallengeScore *profileChallengeScore =
                [coreDataUtils getProfileChallengeScore:profile challenge:worldChallenge];
            worldScore = [NSNumber numberWithInt:(worldScore.intValue +
                                                     profileChallengeScore.score.intValue)];
        }
        
        if ([coreDataUtils saveProfileWorldScore:profile withWorld:world andScore:worldScore])
        {
            NSString *highScoreString = [StringUtils getCompletedChallengeOrWorldNewHighscoreString:world.name andScore:worldScore];
            CCLabelTTF *highScoreLabel = [UIUtils createGloriaHallelujahSubSubTitle:highScoreString];
            [layer addChild:highScoreLabel];
        }
    }
    
    Challenge *nextChallenge = nil;
    World *nextWorld = nil;
    
    if (completedWorld)
    {
        Universe *universe = challenge.world.universe;
        for (int i = 0; i < universe.worlds.count-1; ++i)
        {
            World *world = universe.worlds[i];
            if ([world.name isEqualToString:challenge.world.name])
            {
                nextWorld = universe.worlds[i+1];
                [coreDataUtils updateWorldForProfile:profile world:nextWorld];
                [coreDataUtils updateChallengeForProfile:profile challenge:nextWorld.challenges[0]];
                break;
            }
        }
    }
    else
    {
        for (int i = 0; i < challenge.world.challenges.count-1; ++i)
        {
            Challenge *worldChallenge = challenge.world.challenges[i];
            if ([challenge.name isEqualToString:worldChallenge.name])
            {
                nextChallenge = challenge.world.challenges[i+1];
                [coreDataUtils updateChallengeForProfile:profile challenge:nextChallenge];
                break;
            }
        }
    }
    
    CCControlButton *nextButton = [UIUtils createBlackBoardButton:30 andText:[StringUtils getNextString]];
    nextButton.position = ccp((winSize.width*4)/5, winSize.height/10);
    
    [nextButton setBlock:^(id sender, CCControlEvent event)
     {
        [self nextMenuItemSelected:nextChallenge orWorld:nextWorld];
     } forControlEvents:CCControlEventTouchUpInside];
    
    [layer addChild:nextButton];
    
    CCControlButton *replayButton = [UIUtils createBlackBoardButton:30 andText:[StringUtils getReplayString]];
    replayButton.position = ccp(winSize.width/2, winSize.height/10);
    
    [replayButton setBlock:^(id sender, CCControlEvent event)
     {
        [self replayMenuItemSelected:challenge];
     } forControlEvents:CCControlEventTouchUpInside];
    
    [layer addChild:replayButton];
    
    CCControlButton *menuButton = [UIUtils createBlackBoardButton:30 andText:[StringUtils getMenuString]];
    menuButton.position = ccp(winSize.width/5, winSize.height/10);
    
    [menuButton addTarget:self
                         action:@selector(menuMenuItemSelected:)
               forControlEvents:CCControlEventTouchUpInside];
    
    [layer addChild:menuButton];
    
    [self addChild:layer];
}

-(void) nextMenuItemSelected: (Challenge *) nextChallenge orWorld: (World *) nextWorld
{
    if (nextChallenge != nil)
    {
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0
                        scene:[[ChallengeScene alloc] initWithChallenge:nextChallenge]]];
    }
    else if (nextWorld != nil)
    {
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                        transitionWithDuration:1.0 scene:[[WorldScene alloc] initWithWorld:nextWorld]]];
    }
    else
    {
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                        transitionWithDuration:1.0 scene:[[GameCompletedScene alloc] init]]];
    }
}

-(void) replayMenuItemSelected: (Challenge *) challenge
{
    NSArray *questions = [GenMathInterface getQuestionsForChallenge:challenge];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[[QuestionScene alloc] initWithQuestions:questions andQuestionIndex:0 andChallenge:challenge andScore:0]]];
}

-(void) menuMenuItemSelected: (id) sender
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                                transitionWithDuration:1.0 scene:[[MainMenuScene alloc] init]]];
}

@end
