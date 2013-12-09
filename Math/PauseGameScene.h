//
//  PauseGameScene.h
//  Math
//
//  Created by Johan Stenberg on 2013-12-09.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import "cocos2d.h"

#import "Challenge.h"

#import "QuestionScene.h"

@interface PauseGameScene : CCScene
{
    QuestionScene *_questionScene;
}

-(id) initWithQuestionScene: (QuestionScene *) questionScene;

@end
