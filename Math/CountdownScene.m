//
//  CountdownScene.m
//  Math
//
//  Created by Johan Stenberg on 2013-12-10.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import "CountdownScene.h"

#import "UIUtils.h"

@implementation CountdownScene

-(id) initWithQuestionScene: (QuestionScene *) questionScene andIsPaused: (BOOL) isPaused
{
    if (self = [super init])
    {
        _timeFromStartMilliseconds = 0;
        _questionScene = questionScene;
        _isPaused = isPaused;
        [self setupLayout];
        
        [self scheduleUpdate];
    }
    
    return self;
}

-(void) setupLayout
{
    [UIUtils addDrawingPadBackground:self];
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    _countDownLabel = [UIUtils createGloriaHallelujahCCLabel:250 andText:@"3"];
    _countDownLabel.position = ccp(winSize.width/2, winSize.height/2);
    [self addChild:_countDownLabel];
}

-(void) update: (ccTime) dt
{
    _timeFromStartMilliseconds += dt;
    BOOL shouldChange = NO;
    NSString *label = @"3";
    if (_timeFromStartMilliseconds > 1.5 && _timeFromStartMilliseconds < 2.5)
    {
        shouldChange = YES;
        label = @"2";
    }
    else if (_timeFromStartMilliseconds > 2.5 && _timeFromStartMilliseconds < 3.5)
    {
        shouldChange = YES;
        label = @"1";
    }
    else if (_timeFromStartMilliseconds > 3.5)
    {
        shouldChange = YES;
        label = @"0";
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                                                   transitionWithDuration:1.0 scene:_questionScene]];
        if (_isPaused)
        {
            [_questionScene resume];
        }
        
        [self unscheduleUpdate];
    }
    
    if (shouldChange)
    {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        [self removeChild:_countDownLabel];
        
        _countDownLabel = [UIUtils createGloriaHallelujahCCLabel:250 andText:label];
        _countDownLabel.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:_countDownLabel];
    }
}

@end
