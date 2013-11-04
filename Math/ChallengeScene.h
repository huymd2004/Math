//
//  ChallengeScene.h
//  Math
//
//  Created by Johan Stenberg on 2013-11-03.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import "cocos2d.h"

#import "Challenge.h"

@interface ChallengeScene : CCScene
{
    Challenge *_challenge;
}

-(id) initWithChallenge: (Challenge *) challenge;
@end
