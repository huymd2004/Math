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
    
    NSString *profileTitle = @"Profile for: ";
    profileTitle = [NSString stringWithFormat:@"%@\n\n%@", profileTitle, profile.name];
    
    CCControlButton *profilePresenterLabel = [UIUtils createBlackBoardButton:24 andText:profileTitle];
    profilePresenterLabel.position = ccp(winSize.width/2, (winSize.height*7)/10);
    profilePresenterLabel.touchEnabled = NO;
    [layer addChild:profilePresenterLabel];
    
    NSString *worldTitle = @"You are at world: ";
    worldTitle = [NSString stringWithFormat:@"%@\n\n%@", worldTitle, profile.world.name];
    
    CCControlButton *worldPresenterLabel = [UIUtils createBlackBoardButton:20 andText:worldTitle];
    worldPresenterLabel.position = ccp(winSize.width/2, (winSize.height*1)/2);
    worldPresenterLabel.touchEnabled = NO;
    [layer addChild:worldPresenterLabel];
    
    NSString *challengeTitle = @"You are at challenge: ";
    challengeTitle = [NSString stringWithFormat:@"%@\n\n%@", challengeTitle, profile.challenge.name];
    
    CCControlButton *challengePresenterLabel = [UIUtils createBlackBoardButton:20 andText:challengeTitle];
    challengePresenterLabel.position = ccp(winSize.width/2, (winSize.height*3)/10);
    challengePresenterLabel.touchEnabled = NO;
    [layer addChild:challengePresenterLabel];
    
    /*NSString *profileTitle = @"Profile for: ";
    
    CCControlButton *profilePresenterLabel = [UIUtils createBlackBoardButton:20 andText:profileTitle];
    profilePresenterLabel.position = ccp((winSize.width*2)/5, (winSize.height*4)/5);
    profilePresenterLabel.touchEnabled = NO;
    [layer addChild:profilePresenterLabel];
    
    CCLabelTTF *profileTitleLabel = [UIUtils createGloriaHallelujahCCLabel:24 andText:profile.name];
    [profileTitleLabel setColor:ccc3(1, 1, 1)];
    profileTitleLabel.position = ccp((winSize.width*3)/4, (winSize.height*4)/5);
    [layer addChild:profileTitleLabel];
    
    NSString *worldTitle = @"You are at world: ";
    
    CCControlButton *worldPresenterLabel = [UIUtils createBlackBoardButton:20 andText:worldTitle];
    worldPresenterLabel.position = ccp((winSize.width*2)/5, (winSize.height*7)/10);
    worldPresenterLabel.touchEnabled = NO;
    [layer addChild:worldPresenterLabel];
    
    CCLabelTTF *worldTitleLabel = [UIUtils createGloriaHallelujahCCLabel:24 andText:profile.world.name];
    [worldTitleLabel setColor:ccc3(1, 1, 1)];
    worldTitleLabel.position = ccp((winSize.width*3)/4, (winSize.height*7)/10);
    [layer addChild:worldTitleLabel];
    
    NSString *challengeTitle = @"You are at challenge: ";
    
    CCControlButton *challengePresenterLabel = [UIUtils createBlackBoardButton:20 andText:challengeTitle];
    challengePresenterLabel.position = ccp((winSize.width*2)/5, (winSize.height*3)/5);
    challengePresenterLabel.touchEnabled = NO;
    [layer addChild:challengePresenterLabel];
    
    CCLabelTTF *challengeTitleLabel =
        [UIUtils createGloriaHallelujahCCLabel:24 andText:profile.challenge.name];
    [challengeTitleLabel setColor:ccc3(1, 1, 1)];
    challengeTitleLabel.position = ccp((winSize.width*3)/4, (winSize.height*3)/5);
    [layer addChild:challengeTitleLabel];*/
    
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
