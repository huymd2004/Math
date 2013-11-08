//
//  QuestionScene.h
//  Math
//
//  Created by Johan Stenberg on 2013-11-07.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import "cocos2d.h"

#import "Question.h"

@interface QuestionScene : CCScene
{
    Question *_question;
    NSNumber *_score;
    CCLabelTTF *_scoreLabel;
    int _currentScore;
    double _startTimeMilliseconds;
}

-(id) initWithQuestion: (Question *) question andScore: (NSNumber *) score andCount: (int) count;
@end
