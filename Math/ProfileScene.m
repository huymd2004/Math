//
//  ProfileScene.m
//  Math
//
//  Created by Johan Stenberg on 2013-11-01.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import "ProfileScene.h"

#import "Profile.h"

#import "CoreDataUtils.h"

#import "MainMenuScene.h"

#import "World.h"

#import "Challenge.h"

#import "UIUtils.h"

#import "CCControlExtension.h"

#import "StringUtils.h"

@implementation ProfileScene

-(id) init
{
    if (self = [super init])
    {
        [self setupLayout];
    }
    
    return self;
}

-(void) setupLayout
{
    [UIUtils addDrawingPadBackground:self];
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    CCLayer *layer = [[CCLayer alloc] init];
    CoreDataUtils *coreDataUtils = [CoreDataUtils getInstance];
    Profile *profile = [coreDataUtils getCurrentProfile];
    
    CCLabelTTF *label = [UIUtils createGloriaHallelujahTitle:[StringUtils getProfileString]];
    [layer addChild:label];
    
    NSString *profileTitle = [StringUtils getProfileForString:profile.name];
    CCControlButton *profilePresenterLabel = [UIUtils createBlackBoardLabel:36 andText:profileTitle];
    profilePresenterLabel.position = ccp(winSize.width/2, (winSize.height*3)/5);
    [layer addChild:profilePresenterLabel];
    
    if (!profile.hasCompletedGame)
    {
        NSString *worldTitle = [StringUtils getCurrentWorldString:profile.world.name];
        CCControlButton *worldPresenterLabel = [UIUtils createBlackBoardLabel:36 andText:worldTitle];
        worldPresenterLabel.position = ccp(winSize.width/2, (winSize.height*13)/30);
        [layer addChild:worldPresenterLabel];
    
        NSString *challengeTitle = [StringUtils getCurrentChallengeString:profile.challenge.name];
        CCControlButton *challengePresenterLabel = [UIUtils createBlackBoardLabel:36 andText:challengeTitle];
        challengePresenterLabel.position = ccp(winSize.width/2, (winSize.height*4)/15);
        [layer addChild:challengePresenterLabel];
    }
    else
    {
        NSString *hasCompletedGameTitle = [StringUtils getHasCompletedGameString:profile.name];
        CCControlButton *hasCompletedGameLabel =
            [UIUtils createBlackBoardLabel:36 andText:hasCompletedGameTitle];
        hasCompletedGameLabel.position = ccp(winSize.width/2, (winSize.height*13)/30);
        [layer addChild:hasCompletedGameLabel];
    }
    
    CCControlButton *backButton = [UIUtils createBackButton];
    
    [backButton addTarget:self
                   action:@selector(backMenuItemSelected:)
         forControlEvents:CCControlEventTouchDown];
    
    [layer addChild:backButton];
    
    [self addChild:layer];
}

-(void) backMenuItemSelected:(id) sender
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                                               transitionWithDuration:1.0 scene:[[MainMenuScene alloc] init]]];
}

@end
