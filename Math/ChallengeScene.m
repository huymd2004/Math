//
//  ChallengeScene.m
//  Math
//
//  Created by Johan Stenberg on 2013-11-03.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import "ChallengeScene.h"

@implementation ChallengeScene

-(id) initWithChallenge: (Challenge *) challenge
{
    if (self = [super init])
    {
        _challenge = challenge;
    }
    
    return self;
}

@end
