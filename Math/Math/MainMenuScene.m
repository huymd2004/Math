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
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    CCLayer *layer = [[CCLayer alloc] init];
    
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Working Name Menu" fontName:@"SketchCollege" fontSize:24];
    label.position = ccp(winSize.width/2, (winSize.height*9)/10);
    [layer addChild:label];
    
    CCMenuItem *playMenuItem = [CCMenuItemFont itemWithString:@"Play" target:self
                                                     selector:(@selector(playMenuItemSelected:))];
    
    CCMenuItem *optionsMenuItem = [CCMenuItemFont itemWithString:@"Options" target:self
                                                        selector:(@selector(optionsMenuItemSelected:))];
    
    CCMenuItem *profileMenuItem = [CCMenuItemFont itemWithString:@"Profile" target:self
                                                        selector:(@selector(profileMenuItemSelected:))];
    
    CCMenu *menu = [CCMenu menuWithItems:playMenuItem, optionsMenuItem, profileMenuItem, nil];
    [menu alignItemsVertically];
    menu.position = ccp(winSize.width/2, winSize.height/2);
    
    [layer addChild:menu];
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
