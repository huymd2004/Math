//
//  GameCompletedScene.m
//  Math
//
//  Created by Johan Stenberg on 2013-11-07.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import "GameCompletedScene.h"

#import "MainMenuScene.h"

#import "Profile.h"

#import "CoreDataUtils.h"

#import "UIUtils.h"

#import "StringUtils.h"

@implementation GameCompletedScene

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
    
    CoreDataUtils *coreDataUtils = [CoreDataUtils getInstance];
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    CCLayer *layer = [[CCLayer alloc] init];
    
    Profile *profile = [coreDataUtils getCurrentProfile];
    
    NSString *sceneTitle = [StringUtils getCompletedGameString:profile.name];
    CCLabelTTF *sceneTitleLabel = [UIUtils createGloriaHallelujahTitle:sceneTitle];
    [layer addChild:sceneTitleLabel];
    
    CCControlButton *menuButton = [UIUtils createBlackBoardButton:30 andText:[StringUtils getMenuString]];
    menuButton.position = ccp(winSize.width/2, (winSize.height)/2);
    
    [menuButton addTarget:self
                   action:@selector(menuMenuItemSelected:)
         forControlEvents:CCControlEventTouchDown];
    
    [layer addChild:menuButton];
    
    [self addChild:layer];
}

-(void) menuMenuItemSelected: (id) sender
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                transitionWithDuration:1.0 scene:[[MainMenuScene alloc] init]]];
}

@end
