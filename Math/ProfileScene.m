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
    
    CCLabelTTF *label = [UIUtils createGloriaHallelujahCCLabel:56 andText:@"Profile"];
    label.position = ccp(winSize.width/2, (winSize.height*4)/5);
    [layer addChild:label];
    
    NSString *profileTitle = @"Profile for: ";
    profileTitle = [NSString stringWithFormat:@"%@\n\n%@", profileTitle, profile.name];
    
    CCControlButton *profilePresenterLabel = [UIUtils createBlackBoardButton:24 andText:profileTitle];
    profilePresenterLabel.position = ccp(winSize.width/2, (winSize.height*13)/20);
    profilePresenterLabel.enabled = NO;
    [layer addChild:profilePresenterLabel];
    
    NSString *worldTitle = @"You are at world: ";
    worldTitle = [NSString stringWithFormat:@"%@\n\n%@", worldTitle, profile.world.name];
    
    CCControlButton *worldPresenterLabel = [UIUtils createBlackBoardButton:20 andText:worldTitle];
    worldPresenterLabel.position = ccp(winSize.width/2, (winSize.height*1)/2);
    worldPresenterLabel.enabled = NO;
    [layer addChild:worldPresenterLabel];
    
    NSString *challengeTitle = @"You are at challenge: ";
    challengeTitle = [NSString stringWithFormat:@"%@\n\n%@", challengeTitle, profile.challenge.name];
    
    CCControlButton *challengePresenterLabel = [UIUtils createBlackBoardButton:20 andText:challengeTitle];
    challengePresenterLabel.position = ccp(winSize.width/2, (winSize.height*7)/20);
    challengePresenterLabel.enabled = NO;
    [layer addChild:challengePresenterLabel];
    
    [UIUtils setupDefaultDrawingPadCCMenuSettings];
    
    CCMenuItem *backMenuItem = [CCMenuItemFont itemWithString:@"<" target:self
                                                     selector:(@selector(backMenuItemSelected:))];
    [backMenuItem setColor:ccc3(1, 1, 1)];
    CCMenu *backMenu = [CCMenu menuWithItems:backMenuItem, nil];
    backMenu.position = ccp(winSize.width/10, winSize.height/10);
    [layer addChild:backMenu];
    
    [self addChild:layer];
}

-(void) backMenuItemSelected:(id) sender
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                                               transitionWithDuration:1.0 scene:[[MainMenuScene alloc] init]]];
}

@end
