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

#import "UIUtils.h"

#import "GenMathInterface.h"

#import "StringUtils.h"

#import "PauseGameScene.h"

#define START_SCORE 10000

@implementation QuestionScene

-(id) initWithQuestions: (NSArray *) questions
      andQuestionIndex: (int) index
          andChallenge: (Challenge *) challenge
              andScore: (NSNumber *) score
{
    if (self = [super init])
    {
        _questions = questions;
        _score = [score copy];
        _currentScore = START_SCORE;
        _startTimeMilliseconds = [[NSDate date] timeIntervalSince1970] * 1000;
        _challenge = challenge;
        
        [self setupLayout:_questions[index] andIndex:index];
    }
    
    return self;
}

-(void) setupLayout: (Question *) question andIndex: (int) index
{
    [UIUtils addDrawingPadBackground:self];
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    CCLayer *layer = [[CCLayer alloc] init];
    
    CCLabelTTF *questionLabel = [UIUtils createGloriaHallelujahTitle:question.question];
    [layer addChild:questionLabel];
    
    _scoreLabel = [UIUtils createGloriaHallelujahCCLabel:28 andText:[StringUtils getScoreLabel:_score]];
    _scoreLabel.position = ccp((winSize.width*4)/5, winSize.height/12);
    [layer addChild:_scoreLabel];
    
    for (int i = 0; i < question.answers.count; ++i)
    {
        Answer *answer = question.answers[i];
        CCControlButton *answerButton;
        
        if ([answer.isImage intValue] == 0)
        {
            CGSize size = CGSizeMake(220, 90);
            int fontSize = 66;
            if ([UIUtils getDeviceType] != iPad)
            {
                size = CGSizeMake(110, 45);
                fontSize = 60;
            }
            
            answerButton = [UIUtils createBlackBoardButtonWithSize:size  andText:answer.text
                                    andFontSize:fontSize];
        }
        else
        {
            answerButton = [UIUtils createImageButton:answer.text];
        }
        
        [answerButton setBlock:^(id sender, CCControlEvent event)
        {
             [self questionMenuItemSelected:answer andIndex:index andQuestionIndex:i];
        } forControlEvents:CCControlEventTouchUpInside];
        
        answerButton.position = [self getPositionForAnswerWithIndex:i];
        
        [layer addChild:answerButton];
    }
    
    CCControlButton *backButton = [UIUtils createBackButton];
    
    [backButton setBlock:^(id sender, CCControlEvent event)
     {
         [self backMenuItemSelected:_challenge];
     } forControlEvents:CCControlEventTouchUpInside];
    
    [layer addChild:backButton];
    
    CCControlButton *pauseButton = [UIUtils createImageButton:@"pause.png"];
    
    [pauseButton addTarget:self
                    action:@selector(pauseButtonSelected:)
          forControlEvents:CCControlEventTouchUpInside];
    
    [layer addChild:pauseButton];
    
    pauseButton.position = ccp((winSize.width)/2, winSize.height/12);
    
    [self addChild:layer];
}

-(CGPoint) getPositionForAnswerWithIndex: (int) index
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    if ([UIUtils getDeviceType] == iPad)
    {
        
        return ccp(((winSize.width*4*(index % 2)) +
                    (winSize.width*3))/10, (winSize.height*(6 - (index > 1 ? 2 : 0)))/10);
    }
    else
    {
        return ccp(((winSize.width*10*(index % 2)) +
                    (winSize.width*5))/20, (winSize.height*(6 - (index > 1 ? 2 : 0)))/10);
    }
}

-(void) questionMenuItemSelected: (Answer *) answer andIndex: (int) index andQuestionIndex: (int) i
{
    if ([answer.isCorrect intValue] == 0)
    {
        _currentScore -= 5000;
        _currentScore = _currentScore > 0 ? _currentScore : 0;
        CCControlButton *wrongAnswerImage = [UIUtils createWrongAnswerImage];
        wrongAnswerImage.position = [self getPositionForAnswerWithIndex:i];
        [self addChild:wrongAnswerImage];
        return;
    }
    
    double finishedTimeMilliseconds = [[NSDate date] timeIntervalSince1970] * 1000;
    _currentScore -= (finishedTimeMilliseconds - _startTimeMilliseconds) / 3;
    _currentScore = _currentScore > 0 ? _currentScore : 0;
    _score = [NSNumber numberWithInt:(_score.intValue + _currentScore)];
    
    if (index == QUESTIONS_SIZE - 1)
    {
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[[ChallengeCompletedScene alloc] initWithChallenge:_challenge andScore:_score]]];
    }
    else
    {
        ++index;
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                                                   transitionWithDuration:0 scene:[[QuestionScene alloc] initWithQuestions:_questions andQuestionIndex:index andChallenge:_challenge andScore:_score]]];
    }
}

-(void) backMenuItemSelected: (Challenge *) challenge
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                    transitionWithDuration:1.0 scene:[[ChallengeScene alloc] initWithChallenge:challenge]]];
}

-(void) pauseButtonSelected: (id) sender
{
    _pauseTimeMilliseconds = [[NSDate date] timeIntervalSince1970] * 1000;
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                                                 transitionWithDuration:1.0 scene:[[PauseGameScene alloc] initWithQuestionScene:self]]];
}

-(void) resume
{
    double timeNow = [[NSDate date] timeIntervalSince1970] * 1000;
    _startTimeMilliseconds = _startTimeMilliseconds + (timeNow - _pauseTimeMilliseconds);
}

@end