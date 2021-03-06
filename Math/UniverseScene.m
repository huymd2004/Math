//
//  UniverseScene.m
//  Math
//
//  Created by Johan Stenberg on 2013-11-03.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import "UniverseScene.h"

#import "CoreDataUtils.h"

#import "Universe.h"

#import "Profile.h"

#import "MainMenuScene.h"

#import "World.h"

#import "WorldScene.h"

#import "UIUtils.h"

#import "StringUtils.h"

#import "CCScrollLayerVertical.h"

@implementation UniverseScene

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
    
    CCLabelTTF *sceneTitleLabel = [UIUtils createGloriaHallelujahTitle:[StringUtils getWorldsString]];
    [layer addChild:sceneTitleLabel];
    
    Profile *profile = [coreDataUtils getCurrentProfile];
    Universe *universe = [coreDataUtils getUniverse];
    
    float smallestHeight = INT_MAX;
    
    int currentWorld = [universe.worlds indexOfObject:profile.world];
    for (int i = 0; i < universe.worlds.count; ++i)
    {
        World *world = universe.worlds[i];
        
        if (i > currentWorld)
        {
            NSString *imageFilePath = @"lock.png";
            CCSprite *hasFinishedOrLockedSprite  = [CCSprite spriteWithFile:imageFilePath];
            
            int widthPosition = [UIUtils getDeviceType] == iPad ? (winSize.width*3)/4 : (winSize.width*17)/20;
            hasFinishedOrLockedSprite.position = ccp(widthPosition, (winSize.height*(26-5*i))/40);
            [layer addChild:hasFinishedOrLockedSprite];
        }
        
        CCControlButton *worldButton = [UIUtils createBlackBoardButton:40 andText:world.name];
        worldButton.position = ccp(winSize.width/2, (winSize.height*(26-5*i))/40);
        
        [worldButton setBlock:^(id sender, CCControlEvent event)
        {
            if (i <= currentWorld)
            {
                [self startSceneWithWorld:world];
            }
            else
            {
                [self pressedLockedWorld];
            }
        } forControlEvents:CCControlEventTouchUpInside];
        
        [layer addChild:worldButton];
        
        smallestHeight = min(worldButton.position.y, smallestHeight);
        
        if (worldButton.position.y < smallestHeight)
        {
            smallestHeight = worldButton.position.y;
        }
    }
    
    CCControlButton *backButton = [UIUtils createBackButton];
    
    [backButton addTarget:self
                   action:@selector(backMenuItemSelected:)
         forControlEvents:CCControlEventTouchDown];
    
    [layer addChild:backButton];
    [self addChild:layer];
}

-(void) startSceneWithWorld: (World *) world
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                                               transitionWithDuration:1.0 scene:[[WorldScene alloc] initWithWorld:world]]];
}

-(void) pressedLockedWorld
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:[StringUtils getLockedWorldStringTitle]
                          message:[StringUtils getLockedWorldStringMessage]
                          delegate:nil
                          cancelButtonTitle:[StringUtils getOKString]
                          otherButtonTitles:nil];
    [alert show];
}

-(void) backMenuItemSelected:(id) sender
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                                               transitionWithDuration:1.0 scene:[[MainMenuScene alloc] init]]];
}

@end
