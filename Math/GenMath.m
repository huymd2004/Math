//
//  GenMath.m
//  GenMathiOS
//
//  Created by Johan Stenberg on 2013-11-29.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import "GenMath.h"

#import "IntegerArithmeticGenerator.h"

@implementation GenMath

+(NSArray *) generateQuestions:(enum ProblemType) problemType andDifficulty: (int) difficulty andSize: (int) size
{
    switch (problemType)
    {
        case Addition:
        case Subtraction:
        case Multiplication:
        case Division:
            return [IntegerArithmeticGenerator generateQuestions:problemType andDifficulty:difficulty andSize:size];
            break;
        case MixedArithmetics:
            break;
        case Puzzle:
            break;
        case Geometry:
            break;
        case Fraction:
            break;
        case Time:
            break;
        case Statistics:
            break;
        default:
            [NSException raise:@"Invalid ProblemType!"
                        format:@"ProblemType %d is invalid", problemType];
            break;
    }
    
    return nil;
}

+(enum ProblemType) intToProblemType: (int) i
{
    switch (i)
    {
        case Addition:
            return Addition;
        case Subtraction:
            return Subtraction;
        case Multiplication:
            return Multiplication;
        case Division:
            return Division;
            break;
        case MixedArithmetics:
            return MixedArithmetics;
        case Puzzle:
            return Puzzle;
        case Geometry:
            return Geometry;
        case Fraction:
            return Fraction;
        case Time:
            return Time;
        case Statistics:
            return Statistics;
        default:
            [NSException raise:@"Invalid ProblemType!"
                        format:@"ProblemType %d is invalid", i];
            break;
    }
    
    return nil;
}

@end
