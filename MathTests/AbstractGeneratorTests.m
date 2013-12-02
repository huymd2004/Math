//
//  AbstractGeneratorTests.m
//  GenMathiOS
//
//  Created by Johan Stenberg on 2013-12-02.
//  Copyright (c) 2013 Johan Stenberg. All rights reserved.
//

#import "AbstractGeneratorTests.h"

#import "Question.h"

#import "Answer.h"

@implementation AbstractGeneratorTests

- (void) testGenerateQuestionsForDifficultyOneOrSix: (enum ProblemType) problemType andDifficulty: (int) difficulty
{
    if (difficulty != 1 && difficulty != 6)
    {
        [NSException raise:@"Invalid Difficulty!"
                    format:@"Only difficulty 1 or 6 here."];
    }
    
    int size = 10;
    int answers = 4;
    NSArray *questions = [GenMath generateQuestions:problemType andDifficulty:difficulty andSize:size];
    [self testGeneralQuestionAttributes:questions andDesiredNumberOfAnswers:answers
            andDesiredNumberOfQuestions:size andIsSameQuestionsAllowed:NO];
    
    for (int i = 0; i < size; ++i)
    {
        Question *question = questions[i];
        switch (problemType)
        {
            case Addition:
            case Subtraction:
            case Multiplication:
            case Division:
            {
                NSExpression *expression = [NSExpression expressionWithFormat:question.question];
                int correctAnswer = [[expression expressionValueWithObject:nil context:nil] intValue];
                
                [self verifyIntegerAnswers:correctAnswer andAnswers:question.answers andIsExpression:NO];
            }
                break;
            default:
                [NSException raise:@"Invalid ProblemType!"
                            format:@"ProblemType %d is not implemented!", problemType];
                break;
                
        }
    }
}

- (void) testGenerateQuestionsForDifficultyTwoOrSeven: (enum ProblemType) problemType andDifficulty: (int) difficulty
{
    if (difficulty != 2 && difficulty != 7)
    {
        [NSException raise:@"Invalid Difficulty!"
                    format:@"Only difficulty 2 or 7 here."];
    }
    
    int size = 10;
    int answers = 4;
    NSArray *questions = [GenMath generateQuestions:problemType andDifficulty:difficulty andSize:size];
    [self testGeneralQuestionAttributes:questions andDesiredNumberOfAnswers:answers
            andDesiredNumberOfQuestions:size andIsSameQuestionsAllowed:NO];
    
    for (int i = 0; i < size; ++i)
    {
        Question *question = questions[i];
        switch (problemType)
        {
            case Addition:
            {
                int correctAnswer = 0;
                if ([[question.question substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"?"])
                {
                    NSArray *componentsFirst = [question.question componentsSeparatedByString:@" + "];
                    NSArray *componentsSecond = [componentsFirst[1] componentsSeparatedByString:@" = "];
                    int firstValue = [componentsSecond[0] intValue];
                    int secondValue = [componentsSecond[1] intValue];
                    correctAnswer = secondValue - firstValue;
                }
                else
                {
                    NSArray *componentsFirst = [question.question componentsSeparatedByString:@" + "];
                    NSArray *componentsSecond = [componentsFirst[1] componentsSeparatedByString:@" = "];
                    int firstValue = [componentsFirst[0] intValue];
                    int secondValue = [componentsSecond[1] intValue];
                    correctAnswer = secondValue - firstValue;
                }
                
                [self verifyIntegerAnswers:correctAnswer andAnswers:question.answers andIsExpression:NO];
            }
                break;
            case Subtraction:
            {
                int correctAnswer = 0;
                if ([[question.question substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"?"])
                {
                    NSArray *componentsFirst = [question.question componentsSeparatedByString:@" - "];
                    NSArray *componentsSecond = [componentsFirst[1] componentsSeparatedByString:@" = "];
                    int firstValue = [componentsSecond[0] intValue];
                    int secondValue = [componentsSecond[1] intValue];
                    correctAnswer = secondValue + firstValue;
                }
                else
                {
                    NSArray *componentsFirst = [question.question componentsSeparatedByString:@" - "];
                    NSArray *componentsSecond = [componentsFirst[1] componentsSeparatedByString:@" = "];
                    int firstValue = [componentsFirst[0] intValue];
                    int secondValue = [componentsSecond[1] intValue];
                    correctAnswer = firstValue - secondValue;
                }
                
                [self verifyIntegerAnswers:correctAnswer andAnswers:question.answers andIsExpression:NO];
            }
                break;
            case Multiplication:
            {
                int firstValue = 0;
                int secondValue = 0;
                int correctAnswer = 0;
                if ([[question.question substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"?"])
                {
                    NSArray *componentsFirst = [question.question componentsSeparatedByString:@" * "];
                    NSArray *componentsSecond = [componentsFirst[1] componentsSeparatedByString:@" = "];
                    firstValue = [componentsSecond[0] intValue];
                    secondValue = [componentsSecond[1] intValue];
                }
                else
                {
                    NSArray *componentsFirst = [question.question componentsSeparatedByString:@" * "];
                    NSArray *componentsSecond = [componentsFirst[1] componentsSeparatedByString:@" = "];
                    firstValue = [componentsFirst[0] intValue];
                    secondValue = [componentsSecond[1] intValue];
                }
                
                if (firstValue == 0)
                {
                    correctAnswer = 0;
                }
                else
                {
                    correctAnswer = secondValue / firstValue;
                }
                
                [self verifyIntegerAnswers:correctAnswer andAnswers:question.answers andIsExpression:NO];
            }
                break;
            case Division:
            {
                int correctAnswer = 0;
                if ([[question.question substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"?"])
                {
                    NSArray *componentsFirst = [question.question componentsSeparatedByString:@" / "];
                    NSArray *componentsSecond = [componentsFirst[1] componentsSeparatedByString:@" = "];
                    int firstValue = [componentsSecond[0] intValue];
                    int secondValue = [componentsSecond[1] intValue];
                    correctAnswer = secondValue * firstValue;
                }
                else
                {
                    NSArray *componentsFirst = [question.question componentsSeparatedByString:@" / "];
                    NSArray *componentsSecond = [componentsFirst[1] componentsSeparatedByString:@" = "];
                    int firstValue = [componentsFirst[0] intValue];
                    int secondValue = [componentsSecond[1] intValue];
                    correctAnswer = firstValue / secondValue;
                }
                
                [self verifyIntegerAnswers:correctAnswer andAnswers:question.answers andIsExpression:NO];
            }
                break;
            default:
                [NSException raise:@"Invalid ProblemType!"
                            format:@"ProblemType %d is not implemented!", problemType];
                break;
                
        }
    }
}

- (void) testGenerateQuestionsForDifficultyThreeOrEight: (enum ProblemType) problemType andDifficulty: (int) difficulty
{
    if (difficulty != 3 && difficulty != 8)
    {
        [NSException raise:@"Invalid Difficulty!"
                    format:@"Only difficulty 3 or 8 here."];
    }
    
    int size = 10;
    int answers = 4;
    NSArray *questions = [GenMath generateQuestions:problemType andDifficulty:difficulty andSize:size];
    [self testGeneralQuestionAttributes:questions andDesiredNumberOfAnswers:answers
            andDesiredNumberOfQuestions:size andIsSameQuestionsAllowed:NO];
    
    for (int i = 0; i < size; ++i)
    {
        Question *question = questions[i];
        switch (problemType)
        {
            case Addition:
            case Subtraction:
            case Multiplication:
            case Division:
            {
                NSExpression *expression = [NSExpression expressionWithFormat:question.question];
                int correctAnswer = [[expression expressionValueWithObject:nil context:nil] intValue];
                
                [self verifyIntegerAnswers:correctAnswer andAnswers:question.answers andIsExpression:NO];
            }
                break;
            default:
                [NSException raise:@"Invalid ProblemType!"
                            format:@"ProblemType %d is not implemented!", problemType];
                break;
                
        }
    }
}

- (void) testGenerateQuestionsForDifficultyFourFiveNineOrTen: (enum ProblemType) problemType andDifficulty: (int) difficulty
{
    if (difficulty != 4 && difficulty != 5 && difficulty < 9)
    {
        [NSException raise:@"Invalid Difficulty!"
                    format:@"Only difficulty 4, 5, 9 or 10 here."];
    }
    
    int size = 10;
    int answers = 4;
    NSArray *questions = [GenMath generateQuestions:problemType andDifficulty:difficulty andSize:size];
    [self testGeneralQuestionAttributes:questions andDesiredNumberOfAnswers:answers
            andDesiredNumberOfQuestions:size andIsSameQuestionsAllowed:YES];
    
    BOOL isMin = difficulty == 4 || difficulty == 9;
    
    for (int i = 0; i < size; ++i)
    {
        Question *question = questions[i];
        if (isMin)
        {
            XCTAssertTrue([question.question isEqualToString:@"Smallest?"], @"Wrong question!");
        }
        else
        {
            XCTAssertTrue([question.question isEqualToString:@"Largest?"], @"Wrong question!");
        }
        
        int correctAnswer = isMin ? INT_MAX : INT_MIN;
        
        for (int j = 0; j < answers; ++j)
        {
            Answer *currentAnswer = question.answers[j];
            switch (problemType)
            {
                case Addition:
                case Subtraction:
                case Multiplication:
                case Division:
                {
                    NSExpression *expression = [NSExpression expressionWithFormat:currentAnswer.text];
                    int current = [[expression expressionValueWithObject:nil context:nil] intValue];
                    
                    if (isMin)
                    {
                        correctAnswer = current < correctAnswer ? current : correctAnswer;
                    }
                    else
                    {
                        correctAnswer = current > correctAnswer ? current : correctAnswer;
                    }
                }
                    break;
                default:
                    [NSException raise:@"Invalid ProblemType!"
                                format:@"ProblemType %d is not implemented!", problemType];
                    break;
                    
            }
        }
        
        [self verifyIntegerAnswers:correctAnswer andAnswers:question.answers andIsExpression:YES];
    }
}

- (void) testGeneralQuestionAttributes: (NSArray *) questions
             andDesiredNumberOfAnswers: (int) numberOfAnswers
           andDesiredNumberOfQuestions: (int) size
             andIsSameQuestionsAllowed: (BOOL) sameQuestionsAllowed
{
    XCTAssertTrue(size == [questions count], @"Wrong number of questions!");
    
    NSMutableSet *questionSet = [[NSMutableSet alloc] init];
    for (int i = 0; i < [questions count]; ++i)
    {
        Question *question = questions[i];
        
        if (!sameQuestionsAllowed)
        {
            XCTAssertFalse([questionSet containsObject:question.question], @"Duplicate question!");
        }
        [questionSet addObject:question.question];
        
        XCTAssertTrue([question.answers count] == numberOfAnswers, @"Invalid number of answers!");
        
        BOOL hasCorrect = NO;
        int imagesCount = 0;
        for (int j = 0; j < [question.answers count]; ++j)
        {
            Answer *answer = question.answers[j];
            if ([answer.isCorrect intValue] == 1)
            {
                hasCorrect = YES;
            }
            
            imagesCount = [answer.isImage intValue] == 1 ? imagesCount + 1 : imagesCount;
        }
        
        XCTAssertTrue(hasCorrect, @"Has no correct answer!");
        XCTAssertTrue(imagesCount == 0 || imagesCount == [question.answers count], @"Only some answers are images!");
    }
}

-(void) verifyIntegerAnswers: (int) correctAnswer andAnswers: (NSArray *) answers andIsExpression: (BOOL) isExpression
{
    for (int j = 0; j < [answers count]; ++j)
    {
        Answer *answer = answers[j];
        int value = [answer.text intValue];
        if (isExpression)
        {
            NSExpression *expression = [NSExpression expressionWithFormat:answer.text];
            value = [[expression expressionValueWithObject:nil context:nil] intValue];
        }
            
        if ([answer.isCorrect intValue] == 1)
        {
            XCTAssertTrue(value == correctAnswer, @"Correct answer not correct!");
        }
        else
        {
            XCTAssertFalse(value == correctAnswer, @"Wrong answer is correct!");
        }
    }
}

@end
