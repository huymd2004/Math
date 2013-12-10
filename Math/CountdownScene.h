//
//  CountdownScene.h
//  Math
//
//  Created by Johan Stenberg on 2013-12-10.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import "CCScene.h"

#import "QuestionScene.h"

@interface CountdownScene : CCScene
{
    double _timeFromStartMilliseconds;
    CCLabelTTF *_countDownLabel;
    QuestionScene *_questionScene;
    BOOL _isPaused;
}

-(id) initWithQuestionScene: (QuestionScene *) questionScene andIsPaused: (BOOL) isPaused;

@end
