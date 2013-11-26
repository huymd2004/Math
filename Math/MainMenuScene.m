//
//  MainMenuScene.m
//  Math
//
//  Created by Johan Stenberg on 2013-11-01.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import "MainMenuScene.h"

#import "ProfileScene.h"

#import "OptionsScene.h"

#import "UniverseScene.h"

#import "UIUtils.h"

#import "CoreDataUtils.h"

#import "Profile.h"

#import "CCControlExtension.h"

@implementation MainMenuScene

-(id) init
{
    if (self = [super init])
    {
        [self setupLayout];
        [self scheduleUpdate];
    }
    
    return self;
}

-(void) setupLayout
{
    [UIUtils addDrawingPadBackground:self];
    CoreDataUtils *coreDataUtils = [CoreDataUtils getInstance];
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    CCLayer *layer = [[CCLayer alloc] init];
    
    CCLabelTTF *label = [UIUtils createGloriaHallelujahCCLabel:56 andText:@"Blackboard Math"];
    label.position = ccp(winSize.width/2, (winSize.height*4)/5);
    [layer addChild:label];
    
    CCControlButton *playButton = [UIUtils createBlackBoardButton:30 andText:@"Play"];
    playButton.position = ccp(winSize.width/2, (winSize.height*3)/5);
    
    [playButton addTarget:self
                action:@selector(playButtonSelected:)
                forControlEvents:CCControlEventTouchDown];
    
    [layer addChild:playButton];
    
    CCControlButton *optionsButton = [UIUtils createBlackBoardButton:30 andText:@"Options"];
    optionsButton.position = ccp(winSize.width/2, (winSize.height)/2);
    
    [optionsButton addTarget:self
                   action:@selector(optionsButtonSelected:)
         forControlEvents:CCControlEventTouchDown];
    
    [layer addChild:optionsButton];
    
    CCControlButton *profileButton = [UIUtils createBlackBoardButton:30 andText:@"Profile"];
    profileButton.position = ccp(winSize.width/2, (winSize.height*2)/5);
    
    [profileButton addTarget:self
                      action:@selector(profileButtonSelected:)
            forControlEvents:CCControlEventTouchDown];
    
    [layer addChild:profileButton];
    
    Profile *profile = [coreDataUtils getCurrentProfile];
    NSString *currentProfileString = [NSString stringWithFormat:@"Current profile: %@", profile.name];
    CCLabelTTF *profileLabel = [UIUtils createGloriaHallelujahCCLabel:16 andText:currentProfileString];
    profileLabel.position = ccp((winSize.width*4)/5, (winSize.height)/10);
    [layer addChild:profileLabel z:0];
    
    [self addChild:layer];
}

-(void) playButtonSelected:(id) sender
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                transitionWithDuration:1.0 scene:[[UniverseScene alloc] init]]];
}

-(void) optionsButtonSelected:(id) sender
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                transitionWithDuration:1.0 scene:[[OptionsScene alloc] init]]];
}

-(void) profileButtonSelected:(id) sender
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                transitionWithDuration:1.0 scene:[[ProfileScene alloc] init]]];
}

-(void) update:(ccTime) dt
{
    
}

@end
