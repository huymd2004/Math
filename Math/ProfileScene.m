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
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    CCLayer *layer = [[CCLayer alloc] init];
    CoreDataUtils *coreDataUtils = [CoreDataUtils getInstance];
    Profile *profile = [coreDataUtils getCurrentProfile];
    
    NSString *profileTitle = @"Profile for: ";
    profileTitle = [profileTitle stringByAppendingString:profile.name];
    
    CCLabelTTF *profileTitleLabel = [CCLabelTTF labelWithString:profileTitle fontName:@"SketchCollege" fontSize:24];
    profileTitleLabel.position = ccp(winSize.width/2, (winSize.height*4)/5);
    [layer addChild:profileTitleLabel];
    
    NSString *worldTitle = @"You are at world: ";
    worldTitle = [worldTitle stringByAppendingString:profile.world.name];
    
    CCLabelTTF *worldTitleLabel = [CCLabelTTF labelWithString:worldTitle fontName:@"SketchCollege" fontSize:24];
    worldTitleLabel.position = ccp(winSize.width/2, (winSize.height*7)/10);
    [layer addChild:worldTitleLabel];
    
    NSString *challengeTitle = @"You are at challenge: ";
    challengeTitle = [challengeTitle stringByAppendingString:profile.challenge.name];
    
    CCLabelTTF *challengeTitleLabel = [CCLabelTTF labelWithString:challengeTitle fontName:@"SketchCollege" fontSize:24];
    challengeTitleLabel.position = ccp(winSize.width/2, (winSize.height*6)/10);
    [layer addChild:challengeTitleLabel];
    
    
    CCMenuItem *backMenuItem = [CCMenuItemFont itemWithString:@"Back" target:self
                                                     selector:(@selector(backMenuItemSelected:))];
    
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
