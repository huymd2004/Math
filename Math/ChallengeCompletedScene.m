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

#import "CountdownScene.h"

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
    BOOL hasCompletedWorldBefore = [coreDataUtils hasUserCompletedWorld:profile world:world];
    
    if ([coreDataUtils saveProfileChallengeScore:profile withChallenge:challenge andScore:score])
    {
        NSString *highScoreString = [StringUtils getCompletedChallengeOrWorldNewHighscoreString:challenge.name andScore:score];
        CCLabelTTF *highScoreLabel = [UIUtils createGloriaHallelujahSubTitle:highScoreString];
        highScoreLabel.position = ccp(winSize.width/2, highScoreLabel.position.y - 50);
        [layer addChild:highScoreLabel];
    }
    else
    {
        NSString *string = [StringUtils getScoreLabel:score];
        CCLabelTTF *scoreLabel = [UIUtils createGloriaHallelujahSubTitle:string];
        scoreLabel.position = ccp(winSize.width/2, scoreLabel.position.y - 50);
        [layer addChild:scoreLabel];
    }
    
    if (completedWorld || hasCompletedWorldBefore)
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
            highScoreLabel.position = ccp(winSize.width/2, highScoreLabel.position.y - 100);
            [layer addChild:highScoreLabel];
        }
    }
    
    Challenge *nextChallenge = nil;
    World *nextWorld = nil;
    
    World *lastWorld = challenge.world.universe.worlds[challenge.world.universe.worlds.count-1];
    if (completedWorld && [challenge.world.name isEqualToString:lastWorld.name])
    {
        [coreDataUtils setHasCompletedGame:profile];
    }
    
    if (completedWorld)
    {
        Universe *universe = challenge.world.universe;
        for (int i = 0; i < universe.worlds.count-1; ++i)
        {
            World *world = universe.worlds[i];
            if ([world.name isEqualToString:challenge.world.name])
            {
                nextWorld = universe.worlds[i+1];
                if (!hasCompletedWorldBefore)
                {
                    [coreDataUtils updateChallengeForProfile:profile challenge:nextWorld.challenges[0]];
                    [coreDataUtils updateWorldForProfile:profile world:nextWorld];
                }
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
                if (!hasCompletedWorldBefore)
                {
                    [coreDataUtils updateChallengeForProfile:profile challenge:nextChallenge];
                }
                break;
            }
        }
    }
    
    int widthNext = [UIUtils getDeviceType] == iPad ? (winSize.width*4)/5 : (winSize.width*5)/6;
    
    CCControlButton *nextButton = [UIUtils createBlackBoardButton:30 andText:[StringUtils getNextString]];
    nextButton.position = ccp(widthNext, winSize.height/10);
    
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
    
    int widthMenu = [UIUtils getDeviceType] == iPad ? (winSize.width)/5 : (winSize.width)/6;
    
    CCControlButton *menuButton = [UIUtils createBlackBoardButton:30 andText:[StringUtils getMenuString]];
    menuButton.position = ccp(widthMenu, winSize.height/10);
    
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
    QuestionScene *questionsScene = [[QuestionScene alloc] initWithQuestions:questions andQuestionIndex:0 andChallenge:challenge andScore:[[NSNumber alloc] initWithInt:0]];
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[[CountdownScene alloc] initWithQuestionScene:questionsScene andIsPaused:NO]]];
}

-(void) menuMenuItemSelected: (id) sender
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                                transitionWithDuration:1.0 scene:[[MainMenuScene alloc] init]]];
}

@end
