//
//  PauseGameScene.m
//  Math
//
//  Created by Johan Stenberg on 2013-12-09.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import "PauseGameScene.h"

#import "UIUtils.h"

#import "StringUtils.h"

#import "MainMenuScene.h"

#import "CountdownScene.h"

@implementation PauseGameScene

-(id) initWithQuestionScene: (QuestionScene *) questionScene
{
    if (self = [super init])
    {
        _questionScene = questionScene;
        
        [self setupLayout];
    }
    
    return self;
}

-(void) setupLayout
{
    [UIUtils addDrawingPadBackground:self];
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    CCLayer *layer = [CCLayer node];
    CCLabelTTF *sceneTitleLabel = [UIUtils createGloriaHallelujahTitle:[StringUtils getPausedString]];
    [layer addChild:sceneTitleLabel];
    
    CCControlButton *resumeButton =
        [UIUtils createBlackBoardButton:40 andText:[StringUtils getResumeString]];
    resumeButton.position = ccp(winSize.width/2, (winSize.height*9)/15);
    
    [resumeButton addTarget:self
                      action:@selector(resumeButtonSelected:)
            forControlEvents:CCControlEventTouchUpInside];
    
    [layer addChild:resumeButton];
    
    CCControlButton *menuButton =
        [UIUtils createBlackBoardButton:40 andText:[StringUtils getMenuString]];
    menuButton.position = ccp(winSize.width/2, (winSize.height*7)/15);
    
    [menuButton addTarget:self
                      action:@selector(menuButtonSelected:)
            forControlEvents:CCControlEventTouchUpInside];
    
    [layer addChild:menuButton];
    [self addChild:layer];
}

-(void) resumeButtonSelected: (id) sender
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                                               transitionWithDuration:1.0 scene:[[CountdownScene alloc] initWithQuestionScene:_questionScene andIsPaused:YES]]];
}

-(void) menuButtonSelected: (id) sender
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                                               transitionWithDuration:1.0 scene:[[MainMenuScene alloc] init]]];
}

@end
