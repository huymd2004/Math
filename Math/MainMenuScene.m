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

#import "StringUtils.h"

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
    
    CCLabelTTF *label = [UIUtils createGloriaHallelujahTitle:[StringUtils getMainMenuTitle]];
    [layer addChild:label];
    
    CCControlButton *playButton = [UIUtils createBlackBoardButton:40 andText:[StringUtils getPlayString]];
    playButton.position = ccp(winSize.width/2, (winSize.height*9)/15);
    
    [playButton addTarget:self
                action:@selector(playButtonSelected:)
                forControlEvents:CCControlEventTouchUpInside];
    
    [layer addChild:playButton];
    
    CCControlButton *optionsButton = [UIUtils createBlackBoardButton:40 andText:[StringUtils getOptionsString]];
    optionsButton.position = ccp(winSize.width/2, (winSize.height*7)/15);
    
    [optionsButton addTarget:self
                   action:@selector(optionsButtonSelected:)
         forControlEvents:CCControlEventTouchUpInside];
    
    [layer addChild:optionsButton];
    
    CCControlButton *profileButton = [UIUtils createBlackBoardButton:40 andText:[StringUtils getProfileString]];
    profileButton.position = ccp(winSize.width/2, (winSize.height*5)/15);
    
    [profileButton addTarget:self
                      action:@selector(profileButtonSelected:)
            forControlEvents:CCControlEventTouchUpInside];
    
    [layer addChild:profileButton];
    
    Profile *profile = [coreDataUtils getCurrentProfile];
    NSString *currentProfileString = [StringUtils getCurrentProfileString:profile.name];
    CCLabelTTF *profileLabel = [UIUtils createGloriaHallelujahCCLabel:24 andText:currentProfileString];
    profileLabel.position = ccp((winSize.width*13)/20, (winSize.height)/10);
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
