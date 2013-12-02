//
//  GenMathInterface.h
//  Math
//
//  Created by Johan Stenberg on 2013-12-02.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import "Challenge.h"

#ifndef QUESTIONS_SIZE
#define QUESTIONS_SIZE 10
#endif

@interface GenMathInterface : NSObject
+(NSArray *) getQuestionsForChallenge: (Challenge *) challenge;
@end
