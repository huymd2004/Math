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
    CoreDataUtils *coreDataUtils = [CoreDataUtils getInstance];
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    CCLayer *layer = [[CCLayer alloc] init];
    
    CCLabelTTF *sceneTitleLabel = [CCLabelTTF labelWithString:@"Worlds"
                                                     fontName:@"SketchCollege" fontSize:24];
    sceneTitleLabel.position = ccp(winSize.width/2, (winSize.height*9)/10);
    [layer addChild:sceneTitleLabel];
    
    Profile *profile = [coreDataUtils getCurrentProfile];
    Universe *universe = [coreDataUtils getUniverse];
    
    int currentWorld = [universe.worlds indexOfObject:profile.world];
    for (int i = 0; i < universe.worlds.count; ++i)
    {
        World *world = universe.worlds[i];
        
        if (i != currentWorld)
        {
            NSString *imageFilePath = i > currentWorld ? @"lock.png" : @"checkbox_selected.png";
            CCSprite *hasFinishedOrLockedSprite  = [CCSprite spriteWithFile:imageFilePath];
            
            hasFinishedOrLockedSprite.position = ccp((winSize.width*3)/4, (winSize.height*(8-i))/10);
            [layer addChild:hasFinishedOrLockedSprite];
        }
        
        CCMenuItem *worldMenuItem = [CCMenuItemFont itemWithString:world.name
                                        block:^(CCMenuItem *sender) {
                                            [self startSceneWithWorld:world];
                                        }];
        
        CCMenu *worldMenu = [CCMenu menuWithItems:worldMenuItem, nil];
        worldMenu.position = ccp(winSize.width/2, (winSize.height*(8-i))/10);
        [layer addChild:worldMenu];
    }
    
    CCMenuItem *backMenuItem = [CCMenuItemFont itemWithString:@"Back" target:self
                                                     selector:(@selector(backMenuItemSelected:))];
    
    CCMenu *backMenu = [CCMenu menuWithItems:backMenuItem, nil];
    backMenu.position = ccp(winSize.width/10, winSize.height/10);
    
    [layer addChild:backMenu];
    [self addChild:layer];
}

-(void) startSceneWithWorld: (World *) world
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                                               transitionWithDuration:1.0 scene:[[WorldScene alloc] initWithWorld:world]]];
}

-(void) backMenuItemSelected:(id) sender
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                                               transitionWithDuration:1.0 scene:[[MainMenuScene alloc] init]]];
}

@end
