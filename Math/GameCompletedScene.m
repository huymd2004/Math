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
    CoreDataUtils *coreDataUtils = [CoreDataUtils getInstance];
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    CCLayer *layer = [[CCLayer alloc] init];
    
    Profile *profile = [coreDataUtils getCurrentProfile];
    
    NSString *sceneTitle = [NSString stringWithFormat:@"Congratulations %@! You completed the game!",
                            profile.name];
    CCLabelTTF *sceneTitleLabel = [CCLabelTTF labelWithString:sceneTitle
                                                     fontName:@"SketchCollege" fontSize:24];
    sceneTitleLabel.position = ccp(winSize.width/2, (winSize.height*9)/10);
    [layer addChild:sceneTitleLabel];
    
    CCMenuItem *menuMenuItem = [CCMenuItemFont itemWithString:@"Menu" target:self
                                                     selector:(@selector(menuMenuItemSelected:))];
    
    CCMenu *menuMenu = [CCMenu menuWithItems:menuMenuItem, nil];
    menuMenu.position = ccp(winSize.width/10, winSize.height/10);
    
    [layer addChild:menuMenu];
    [self addChild:layer];
}

-(void) menuMenuItemSelected: (id) sender
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                transitionWithDuration:1.0 scene:[[MainMenuScene alloc] init]]];
}

@end
