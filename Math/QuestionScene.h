//
//  QuestionScene.h
//  Math
//
//  Created by Johan Stenberg on 2013-11-07.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import "cocos2d.h"

#import "Question.h"

#import "Challenge.h"

@interface QuestionScene : CCScene
{
    NSArray *_questions;
    NSNumber *_score;
    CCLabelTTF *_scoreLabel;
    int _currentScore;
    double _startTimeMilliseconds;
    Challenge *_challenge;
}

-(id) initWithQuestions: (NSArray *) questions
      andQuestionIndex: (int) index
          andChallenge: (Challenge *) challenge
              andScore: (NSNumber *) score;
@end
