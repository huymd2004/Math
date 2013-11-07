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
    CoreDataUtils *coreDataUtils = [CoreDataUtils getInstance];
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    CCLayer *layer = [[CCLayer alloc] init];
    
    World *world = challenge.world;
    Challenge *worldsLastChallenge = world.challenges[world.challenges.count - 1];
    BOOL completedWorld = [worldsLastChallenge.name isEqualToString: challenge.name];
    
    NSString *sceneTitleString = [NSString stringWithFormat:@"%@ completed!", completedWorld ? world.name : challenge.name];
    CCLabelTTF *sceneTitleLabel = [CCLabelTTF labelWithString:sceneTitleString
                                                     fontName:@"SketchCollege" fontSize:24];
    sceneTitleLabel.position = ccp(winSize.width/2, (winSize.height*9)/10);
    [layer addChild:sceneTitleLabel];
    
    Profile *profile = [coreDataUtils getCurrentProfile];
    
    if ([coreDataUtils saveProfileChallengeScore:profile withChallenge:challenge andScore:score])
    {
        NSString *highScoreString = [NSString
                                     stringWithFormat:@"Congratulations! New highscore \n for %@ is %d!", challenge.name, score.integerValue];
        CCLabelTTF *highScoreLabel = [CCLabelTTF labelWithString:highScoreString
                                                        fontName:@"SketchCollege" fontSize:24];
        highScoreLabel.position = ccp(winSize.width/2, (winSize.height*17)/20);
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
            NSString *highScoreString = [NSString
                                         stringWithFormat:@"Congratulations! New highscore \n for %@ is %d!", world.name, worldScore.integerValue];
            CCLabelTTF *highScoreLabel = [CCLabelTTF labelWithString:highScoreString
                                                            fontName:@"SketchCollege" fontSize:24];
            highScoreLabel.position = ccp(winSize.width/2, (winSize.height*14)/20);
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
    
    CCMenuItem *nextMenuItem = [CCMenuItemFont itemWithString:@"Next"
                                                          block:^(id sender) {
                                                              [self nextMenuItemSelected:nextChallenge orWorld:nextWorld];
                                                          }];
    
    CCMenu *nextMenu = [CCMenu menuWithItems:nextMenuItem, nil];
    nextMenu.position = ccp((winSize.width*9)/10, winSize.height/10);
    
    [layer addChild:nextMenu];
    
    CCMenuItem *replayMenuItem = [CCMenuItemFont itemWithString:@"Replay"
                                                        block:^(id sender) {
                                                            [self replayMenuItemSelected:challenge];
                                                        }];
    
    CCMenu *replayMenu = [CCMenu menuWithItems:replayMenuItem, nil];
    replayMenu.position = ccp(winSize.width/2, winSize.height/10);
    
    [layer addChild:replayMenu];
    
    CCMenuItem *menuMenuItem = [CCMenuItemFont itemWithString:@"Menu" target:self selector:@selector(menuMenuItemSelected:)];
                                
    
    CCMenu *menuMenu = [CCMenu menuWithItems:menuMenuItem, nil];
    menuMenu.position = ccp(winSize.width/10, winSize.height/10);
    
    [layer addChild:menuMenu];
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
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[[QuestionScene alloc] initWithQuestion:challenge.questions[0] andScore:[NSNumber numberWithInt:0] andCount:1]]];
}

-(void) menuMenuItemSelected: (id) sender
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                                transitionWithDuration:1.0 scene:[[MainMenuScene alloc] init]]];
}

@end
