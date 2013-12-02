//
//  AbstractGenerator.h
//  GenMathiOS
//
//  Created by Johan Stenberg on 2013-12-01.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GenMath.h"

@interface AbstractGenerator : NSObject

+(NSArray *) generateQuestions:(enum ProblemType) problemType andDifficulty: (int) difficulty andSize: (int) size;

@end
