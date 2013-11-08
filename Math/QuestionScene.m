//
//  QuestionScene.m
//  Math
//
//  Created by Johan Stenberg on 2013-11-07.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import "QuestionScene.h"

#import "ChallengeScene.h"

#import "CoreDataUtils.h"

#import "Challenge.h"

#import "Answer.h"

#import "ChallengeCompletedScene.h"

#define START_SCORE 10000

@implementation QuestionScene

-(id) initWithQuestion: (Question *) question andScore: (NSNumber *) score andCount: (int) count
{
    if (self = [super init])
    {
        _question = question;
        _score = [score copy];
        _currentScore = START_SCORE;
        _startTimeMilliseconds = [[NSDate date] timeIntervalSince1970] * 1000;
        
        [self setupLayout:_question andCount:count];
    }
    
    return self;
}

-(void) setupLayout: (Question *) question andCount: (int) count
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    CCLayer *layer = [[CCLayer alloc] init];
    
    NSString *questionString = [NSString stringWithFormat:@"%@", question.question];
    CCLabelTTF *questionLabel = [CCLabelTTF labelWithString:questionString
                                                     fontName:@"SketchCollege" fontSize:24];
    questionLabel.position = ccp(winSize.width/2, (winSize.height*9)/10);
    [layer addChild:questionLabel];
    
    _scoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Score: %@", _score] fontName:@"SketchCollege" fontSize:24];
    _scoreLabel.position = ccp(winSize.width/2, (winSize.height*8)/10);
    [layer addChild:_scoreLabel];
    
    for (int i = 0; i < question.answers.count; ++i)
    {
        Answer *answer = question.answers[i];
        CCMenuItem *questionMenuItem;
        
        if ([answer.isImage intValue] == 0)
        {
            questionMenuItem = [CCMenuItemFont itemWithString:answer.text
                                                         block:^(id sender) {
                                                             [self questionMenuItemSelected:answer andCount:count];
                                                         }];
        }
        else
        {
            questionMenuItem = [CCMenuItemImage itemWithNormalImage:answer.text selectedImage:answer.text
                                                              block:^(id sender) {
                                                                  [self questionMenuItemSelected:answer andCount:count];
                                                              }];
        }
        
        CCMenu *questionMenu = [CCMenu menuWithItems:questionMenuItem, nil];
        
        if (i < 2)
        {
            questionMenu.position = ccp(((winSize.width*i) + (winSize.width))/3, (winSize.height*6)/10);
        }
        else
        {
            switch (question.answers.count)
            {
                case 3:
                    questionMenu.position = ccp(winSize.width/2, (winSize.height*5)/10);
                    break;
                case 4:
                    questionMenu.position =
                        ccp(((winSize.width*(i - 2)) + (winSize.width))/3, (winSize.height*5)/10);
                    break;
            }
        }
        
        [layer addChild:questionMenu];
    }
    
    CCMenuItem *backMenuItem = [CCMenuItemFont itemWithString:@"Back"
                                                        block:^(id sender) {
                                                            [self backMenuItemSelected:question.challenge];
                                                        }];
    
    CCMenu *backMenu = [CCMenu menuWithItems:backMenuItem, nil];
    backMenu.position = ccp(winSize.width/10, winSize.height/10);
    
    [layer addChild:backMenu];
    [self addChild:layer];
}

-(void) questionMenuItemSelected: (Answer *) answer andCount: (int) count
{
    if ([answer.isCorrect intValue] == 0)
    {
        _currentScore -= 1000;
        return;
    }
    
    Challenge *challenge = answer.question.challenge;
    
    double finishedTimeMilliseconds = [[NSDate date] timeIntervalSince1970] * 1000;
    _currentScore -= finishedTimeMilliseconds - _startTimeMilliseconds;
    _currentScore = _currentScore > 0 ? _currentScore : 0;
    _score = [NSNumber numberWithInt:(_score.intValue + _currentScore)];
    
    if (challenge.questions.count == count)
    {
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[[ChallengeCompletedScene alloc] initWithChallenge:challenge andScore:_score]]];
    }
    else
    {
        ++count;
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                transitionWithDuration:1.0 scene:[[QuestionScene alloc] initWithQuestion:challenge.questions[count-1] andScore:_score andCount:count]]];
    }
}

-(void) backMenuItemSelected: (Challenge *) challenge
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                    transitionWithDuration:1.0 scene:[[ChallengeScene alloc] initWithChallenge:challenge]]];
}

@end