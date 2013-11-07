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
    CoreDataUtils *coreDataUtils = [CoreDataUtils getInstance];
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    CCLayer *layer = [[CCLayer alloc] init];
    
    NSString *sceneTitleString = [NSString stringWithFormat:@"Challenges for %@", world.name];
    CCLabelTTF *sceneTitleLabel = [CCLabelTTF labelWithString:sceneTitleString
                                                     fontName:@"SketchCollege" fontSize:24];
    sceneTitleLabel.position = ccp(winSize.width/2, (winSize.height*9)/10);
    [layer addChild:sceneTitleLabel];
    
    Profile *profile = [coreDataUtils getCurrentProfile];
    
    ProfileWorldScore *score = [coreDataUtils getProfileWorldScore:profile world:world];
    
    if (score != nil)
    {
        NSString *highScoreString = [NSString stringWithFormat:@"Highscore is %@ for %@",
                                     score.score, world.name];
        CCLabelTTF *highScoreLabel = [CCLabelTTF labelWithString:highScoreString
                                                        fontName:@"SketchCollege" fontSize:24];
        highScoreLabel.position = ccp(winSize.width/2, (winSize.height*17)/20);
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
    
    for (int i = 0; i < world.challenges.count; ++i)
    {
        Challenge *challenge = world.challenges[i];
        
        if (i != currentChallengeIndex)
        {
            NSString *imageFilePath = i > currentChallengeIndex ? @"lock.png" : @"checkbox_checked.png";
            CCSprite *hasFinishedOrLockedSprite  = [CCSprite spriteWithFile:imageFilePath];
            
            hasFinishedOrLockedSprite.position = ccp((winSize.width*3)/4, (winSize.height*(8-i))/10);
            [layer addChild:hasFinishedOrLockedSprite];
        }
        
        CCMenuItem *challengeMenuItem = [CCMenuItemFont itemWithString:challenge.name
                                                             block:^(CCMenuItem *sender) {
                                                                 [self startSceneWithChallenge:challenge];
                                                             }];
        
        CCMenu *challengeMenu = [CCMenu menuWithItems:challengeMenuItem, nil];
        challengeMenu.position = ccp(winSize.width/2, (winSize.height*(8-i))/10);
        [layer addChild:challengeMenu];
    }
    
    CCMenuItem *backMenuItem = [CCMenuItemFont itemWithString:@"Back" target:self
                                                     selector:(@selector(backMenuItemSelected:))];
    
    CCMenu *backMenu = [CCMenu menuWithItems:backMenuItem, nil];
    backMenu.position = ccp(winSize.width/10, winSize.height/10);
    
    [layer addChild:backMenu];
    [self addChild:layer];
}

-(void) startSceneWithChallenge: (Challenge *) challenge
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                                               transitionWithDuration:1.0 scene:[[ChallengeScene alloc] initWithChallenge:challenge]]];
}

-(void) backMenuItemSelected:(id) sender
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                                               transitionWithDuration:1.0 scene:[[UniverseScene alloc] init]]];
}

@end
