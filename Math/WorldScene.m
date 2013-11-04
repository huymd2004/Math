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
    
    int currentChallenge = [world.challenges indexOfObject:profile.challenge];
    for (int i = 0; i < world.challenges.count; ++i)
    {
        Challenge *challenge = world.challenges[i];
        
        if (i != currentChallenge)
        {
            NSString *imageFilePath = i > currentChallenge ? @"lock.png" : @"checkbox_selected.png";
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
