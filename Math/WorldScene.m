//
//  WorldScene.m
//  Math
//
//  Created by Johan Stenberg on 2013-11-03.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import "WorldScene.h"

#import "UniverseScene.h"

#import "ChallengeScene.h"

#import "CoreDataUtils.h"

#import "ProfileWorldScore.h"

#import "Universe.h"

#import "UIUtils.h"

#import "CCScrollLayerVertical.h"

#import "StringUtils.h"

@implementation WorldScene

-(id) initWithWorld:(World *) world
{
    if(self = [super init])
    {
        [self setupLayoutWithWorld:world];
    }
    
    return self;
}

-(void) setupLayoutWithWorld:(World *) world
{
    [UIUtils addDrawingPadBackground:self];
    
    CoreDataUtils *coreDataUtils = [CoreDataUtils getInstance];
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    CCLayer *layer = [CCLayer node];
    layer.position = ccp(winSize.width, winSize.height);
    
    CCLabelTTF *sceneTitleLabel = [UIUtils createGloriaHallelujahTitle:world.name];
    [layer addChild:sceneTitleLabel];
    
    Profile *profile = [coreDataUtils getCurrentProfile];
    
    ProfileWorldScore *score = [coreDataUtils getProfileWorldScore:profile world:world];
    
    if (score != nil)
    {
        NSString *highScoreString = [StringUtils getHighScoreLabel:world.name andScore:score.score];
        CCControlButton *highScoreLabel = [UIUtils createBlackBoardLabel:40 andText:highScoreString];
        highScoreLabel.position = ccp(winSize.width/2, (winSize.height*7)/10);
        [layer addChild:highScoreLabel];
    }
    
    int currentChallengeIndex = 0;
    for (int i = 0; i < world.challenges.count; ++i)
    {
        Challenge *challenge = world.challenges[i];
        
        if ([challenge.name isEqualToString:profile.challenge.name])
        {
            currentChallengeIndex = i;
            break;
        }
    }
    
    int thisWorldIndex = 0;
    int profileWorldIndex = 0;
    
    
    Universe *universe = [coreDataUtils getUniverse];
    for (int i = 0; i < universe.worlds.count; ++i)
    {
        World *currentWorld = universe.worlds[i];
        
        if ([currentWorld.name isEqualToString:world.name])
        {
            thisWorldIndex = i;
        }
        
        if ([currentWorld.name isEqualToString:profile.world.name])
        {
            profileWorldIndex = i;
        }
    }
    
    currentChallengeIndex = thisWorldIndex == profileWorldIndex ? currentChallengeIndex : INT_MAX;
    
    float smallestHeight = 0;
    for (int i = 0; i < world.challenges.count; ++i)
    {
        Challenge *challenge = world.challenges[i];
        
        if (i > currentChallengeIndex)
        {
            NSString *imageFilePath = @"lock.png";
            CCSprite *hasFinishedOrLockedSprite  = [CCSprite spriteWithFile:imageFilePath];
            
            
            hasFinishedOrLockedSprite.position = ccp((winSize.width*7)/10, (winSize.height*6)/10 + i*-125);
            
            [layer addChild:hasFinishedOrLockedSprite];
        }
        
        CCControlButton *challengeButton = [UIUtils createBlackBoardButton:36 andText:challenge.name];
        challengeButton.position = ccp((winSize.width)/2, (winSize.height*6)/10 + i*-125);
        
        [challengeButton setBlock:^(id sender, CCControlEvent event)
        {
            if (i <= currentChallengeIndex)
            {
                [self startSceneWithChallenge:challenge];
            }
            else
            {
                [self pressedLockedChallenge];
            }
        } forControlEvents:CCControlEventTouchUpInside];
        
        [layer addChild:challengeButton];
        
        if (i == world.challenges.count - 1)
        {
            smallestHeight = (winSize.height*6)/10 + i*-100;
        }
    }
    
    CCControlButton *backButton = [UIUtils createBackButton];
    
    [backButton addTarget:self
                   action:@selector(backMenuItemSelected:)
         forControlEvents:CCControlEventTouchDown];
    
    [self addChild:backButton z:1];
    
    layer.contentSize = CGSizeMake(winSize.width, winSize.height  - smallestHeight + 100);
    CCScrollLayerVertical *scrollLayer = [[CCScrollLayerVertical alloc] initWithLayer:layer];
    [self addChild:scrollLayer z:0];
}

-(void) startSceneWithChallenge: (Challenge *) challenge
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                                               transitionWithDuration:1.0 scene:[[ChallengeScene alloc] initWithChallenge:challenge]]];
}

-(void) pressedLockedChallenge
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:[StringUtils getLockedChallengeStringTitle]
                          message:[StringUtils getLockedChallengeStringMessage]
                          delegate:nil
                          cancelButtonTitle:[StringUtils getOKString]
                          otherButtonTitles:nil];
    [alert show];
}

-(void) backMenuItemSelected:(id) sender
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                                               transitionWithDuration:1.0 scene:[[UniverseScene alloc] init]]];
}

@end
