//
//  GenMath.h
//  GenMathiOS
//
//  Created by Johan Stenberg on 2013-11-29.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import <Foundation/Foundation.h>

enum ProblemType {
    Addition,
    Subtraction,
    Multiplication,
    Division,
    Mixed
};

#ifndef MIN_DIFFICULTY
#define MIN_DIFFICULTY 1
#endif

#ifndef MAX_DIFFICULTY
#define MAX_DIFFICULTY 10
#endif

@interface GenMath : NSObject

+(NSArray *) generateQuestions:(enum ProblemType) problemType andDifficulty: (int) difficulty andSize: (int) size;

+(enum ProblemType) intToProblemType: (int) i;

@end
