//
//  ChallengeCompletedScene.h
//  Math
//
//  Created by Johan Stenberg on 2013-11-07.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import "cocos2d.h"

#import "Challenge.h"

@interface ChallengeCompletedScene : CCScene
-(id) initWithChallenge: (Challenge *) challenge andScore: (NSNumber *) score;
@end
