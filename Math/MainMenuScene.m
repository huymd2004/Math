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

@implementation MainMenuScene

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
    
    CCLabelTTF *label = [UIUtils createGloriaHallelujahCCLabel:56 andText:@"Welcome"];
    label.position = ccp(winSize.width/2, (winSize.height*4)/5);
    [layer addChild:label];
    

    [UIUtils setupDefaultBlackboardCCMenuSettings];
    
    CCSprite *playMenuBackground = [CCSprite spriteWithFile:@"blackboard.png"];
    CCMenuItem *playMenuItem = [CCMenuItemFont itemWithString:@"Play" target:self
                                                     selector:(@selector(playMenuItemSelected:))];
    CCMenu *playMenu = [CCMenu menuWithItems:playMenuItem, nil];
    playMenu.position = ccp(winSize.width/2, (winSize.height*3)/5);
    playMenuBackground.position = playMenu.position;
    [layer addChild:playMenuBackground z:-1];
    [layer addChild:playMenu z:0];

    CCSprite *optionsMenuBackground = [CCSprite spriteWithFile:@"blackboard.png"];
    CCMenuItem *optionsMenuItem = [CCMenuItemFont itemWithString:@"Options" target:self
                                                        selector:(@selector(optionsMenuItemSelected:))];
    CCMenu *optionsMenu = [CCMenu menuWithItems:optionsMenuItem, nil];
    optionsMenu.position = ccp(winSize.width/3, (winSize.height*3)/7);
    optionsMenuBackground.position = optionsMenu.position;
    [layer addChild:optionsMenuBackground z:-1];
    [layer addChild:optionsMenu z:0];
    
    CCSprite *profileMenuBackground = [CCSprite spriteWithFile:@"blackboard.png"];
    CCMenuItem *profileMenuItem = [CCMenuItemFont itemWithString:@"Profile" target:self
                                                        selector:(@selector(profileMenuItemSelected:))];
    CCMenu *profileMenu = [CCMenu menuWithItems:profileMenuItem, nil];
    profileMenu.position = ccp((winSize.width*2)/3, (winSize.height*3)/7);
    profileMenuBackground.position = profileMenu.position;
    [layer addChild:profileMenuBackground z:-1];
    [layer addChild:profileMenu z:0];
    
    [self addChild:layer];
}

-(void) playMenuItemSelected:(id) sender
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                transitionWithDuration:1.0 scene:[[UniverseScene alloc] init]]];
}

-(void) optionsMenuItemSelected:(id) sender
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                transitionWithDuration:1.0 scene:[[OptionsScene alloc] init]]];
}

-(void) profileMenuItemSelected:(id) sender
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                transitionWithDuration:1.0 scene:[[ProfileScene alloc] init]]];
}

@end
