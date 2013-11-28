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
    
    CCLabelTTF *label = [UIUtils createGloriaHallelujahTitle:@"Profile"];
    [layer addChild:label];
    
    NSString *profileTitle = @"Profile for: ";
    profileTitle = [NSString stringWithFormat:@"%@\n\n%@", profileTitle, profile.name];
    
    CCControlButton *profilePresenterLabel = [UIUtils createBlackBoardLabel:24 andText:profileTitle];
    profilePresenterLabel.position = ccp(winSize.width/2, (winSize.height*13)/20);
    [layer addChild:profilePresenterLabel];
    
    NSString *worldTitle = @"Current world: ";
    worldTitle = [NSString stringWithFormat:@"%@\n\n%@", worldTitle, profile.world.name];
    
    CCControlButton *worldPresenterLabel = [UIUtils createBlackBoardLabel:24 andText:worldTitle];
    worldPresenterLabel.position = ccp(winSize.width/2, (winSize.height*1)/2);
    [layer addChild:worldPresenterLabel];
    
    NSString *challengeTitle = @"Current challenge: ";
    challengeTitle = [NSString stringWithFormat:@"%@\n\n%@", challengeTitle, profile.challenge.name];
    
    CCControlButton *challengePresenterLabel = [UIUtils createBlackBoardLabel:24 andText:challengeTitle];
    challengePresenterLabel.position = ccp(winSize.width/2, (winSize.height*7)/20);
    [layer addChild:challengePresenterLabel];
    
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
