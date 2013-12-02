//
//  AbstractGenerator.m
//  GenMathiOS
//
//  Created by Johan Stenberg on 2013-12-01.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import "AbstractGenerator.h"

@implementation AbstractGenerator

+(NSArray *) generateQuestions:(enum ProblemType) problemType andDifficulty: (int) difficulty andSize: (int) size;
{
    switch (difficulty) {
        case 1:
            return [self generateQuestionsOne:size andProblemType:problemType];
            break;
        case 2:
            return [self generateQuestionsTwo:size andProblemType:problemType];
            break;
        case 3:
            return [self generateQuestionsThree:size andProblemType:problemType];
            break;
        case 4:
            return [self generateQuestionsFour:size andProblemType:problemType];
            break;
        case 5:
            return [self generateQuestionsFive:size andProblemType:problemType];
            break;
        case 6:
            return [self generateQuestionsSix:size andProblemType:problemType];
            break;
        case 7:
            return [self generateQuestionsSeven:size andProblemType:problemType];
            break;
        case 8:
            return [self generateQuestionsEight:size andProblemType:problemType];
            break;
        case 9:
            return [self generateQuestionsNine:size andProblemType:problemType];
            break;
        case 10:
            return [self generateQuestionsTen:size andProblemType:problemType];
            break;
        default:
            [NSException raise:@"Invalid Difficulty!"
                        format:@"Difficulty %d is invalid", difficulty];
            break;
    }
    
    return nil;
}

+(NSArray *) generateQuestionsOne: (int) size andProblemType: (enum ProblemType) problemType
{
    return nil;
}

+(NSArray *) generateQuestionsTwo: (int) size  andProblemType: (enum ProblemType) problemType
{
    return nil;
}

+(NSArray *) generateQuestionsThree: (int) size  andProblemType: (enum ProblemType) problemType
{
    return nil;
}

+(NSArray *) generateQuestionsFour: (int) size  andProblemType: (enum ProblemType) problemType
{
    return nil;
}

+(NSArray *) generateQuestionsFive: (int) size andProblemType: (enum ProblemType) problemType
{
    return nil;
}

+(NSArray *) generateQuestionsSix: (int) size  andProblemType: (enum ProblemType) problemType
{
    return nil;
}

+(NSArray *) generateQuestionsSeven: (int) size  andProblemType: (enum ProblemType) problemType
{
    return nil;
}

+(NSArray *) generateQuestionsEight: (int) size  andProblemType: (enum ProblemType) problemType
{
    return nil;
}

+(NSArray *) generateQuestionsNine: (int) size  andProblemType: (enum ProblemType) problemType
{
    return nil;
}

+(NSArray *) generateQuestionsTen: (int) size  andProblemType: (enum ProblemType) problemType
{
    return nil;
}

@end
